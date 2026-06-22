<?php

namespace Database\Seeders;

use App\Models\CanalPago;
use App\Models\ImportacionPago;
use App\Models\User;
use App\Services\IngresosAdmision\Pagos\ImportacionPagoService;
use Illuminate\Database\Seeder;
use Illuminate\Support\Carbon;
use RuntimeException;

class PagosExcelSeeder extends Seeder
{
    public function run(): void
    {
        $directory = database_path('seeders/data/pagos_excel');
        if (! is_dir($directory)) {
            throw new RuntimeException("Coloca los Excel en esta carpeta: {$directory}");
        }

        $files = glob($directory.'/*.xlsx') ?: [];
        sort($files);

        if ($files === []) {
            throw new RuntimeException("No hay archivos .xlsx en: {$directory}");
        }

        $userId = User::query()->min('id');
        if ($userId === null) {
            throw new RuntimeException('Primero debe existir un usuario para registrar la importacion.');
        }

        $canal = CanalPago::query()->where('codigo', 'BANCO_NACION')->firstOrFail();
        $importador = app(ImportacionPagoService::class);

        foreach ($files as $file) {
            $hash = hash_file('sha256', $file);
            if (ImportacionPago::query()->where('hash_archivo', $hash)->exists()) {
                continue;
            }

            $rows = $importador->readRows($canal, $file, 'xlsx');
            $importador->importFromRows(
                $canal,
                $this->fechaReferencia($file),
                [
                    'nombre_archivo' => basename($file),
                    'mime_type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                    'tamano' => filesize($file) ?: 0,
                    'extension' => 'xlsx',
                    'hash_archivo' => $hash,
                ],
                $rows,
                $userId,
            );
        }
    }

    private function fechaReferencia(string $file): Carbon
    {
        $name = pathinfo($file, PATHINFO_FILENAME);

        if (preg_match('/(2026[-_]?06[-_]?(16|17|18|19))/', $name, $match)) {
            return Carbon::createFromFormat('Ymd', str_replace(['-', '_'], '', $match[1]));
        }

        if (preg_match('/\b(16|17|18|19)\b/', $name, $match)) {
            return Carbon::create(2026, 6, (int) $match[1]);
        }

        throw new RuntimeException("No pude obtener la fecha desde el nombre del archivo: {$name}. Usa 2026-06-16.xlsx, 2026-06-17.xlsx o 2026-06-18.xlsx.");
    }
}
