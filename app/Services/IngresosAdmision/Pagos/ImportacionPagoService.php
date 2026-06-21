<?php

namespace App\Services\IngresosAdmision\Pagos;

use App\Enums\IngresosAdmision\Pagos\EstadoDetalleImportacionPago;
use App\Enums\IngresosAdmision\Pagos\EstadoImportacionPago;
use App\Models\CanalPago;
use App\Models\ImportacionPago;
use App\Services\IngresosAdmision\Pagos\Readers\BancoNacionExcelReader;
use App\Services\IngresosAdmision\Pagos\Readers\PagaloPeExcelReader;
use App\Services\IngresosAdmision\Pagos\Readers\PaymentFileReaderInterface;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;
use RuntimeException;
use Throwable;

class ImportacionPagoService
{
    public function __construct(
        private readonly ProcesamientoFilaPagoService $filas,
    ) {}

    public function import(CanalPago $canal, Carbon $fechaReferencia, UploadedFile $archivo, int $userId): ImportacionPago
    {
        $hash = hash_file('sha256', $archivo->getRealPath());
        if (ImportacionPago::query()->where('hash_archivo', $hash)->exists()) {
            throw ValidationException::withMessages([
                'archivo' => ['Este archivo ya fue importado anteriormente.'],
            ]);
        }

        $extension = strtolower($archivo->getClientOriginalExtension());
        $nombreInterno = Str::uuid().'.'.$extension;
        $ruta = $archivo->storeAs('pagos/importaciones/'.now()->format('Y/m'), $nombreInterno, 'local');
        if (! is_string($ruta)) {
            throw ValidationException::withMessages([
                'archivo' => ['No se pudo guardar el archivo en storage privado.'],
            ]);
        }

        $importacion = ImportacionPago::query()->create([
            'canal_pago_id' => $canal->id,
            'fecha_referencia' => $fechaReferencia->toDateString(),
            'nombre_archivo' => $archivo->getClientOriginalName(),
            'nombre_interno' => $nombreInterno,
            'disco' => 'local',
            'ruta_archivo' => $ruta,
            'mime_type' => $archivo->getClientMimeType(),
            'extension' => $extension,
            'tamano' => $archivo->getSize(),
            'hash_archivo' => $hash,
            'importado_por' => $userId,
            'estado' => EstadoImportacionPago::Pendiente,
        ]);

        return $this->process($importacion);
    }

    /**
     * @param  list<array{numero_fila:int,datos:array<string, mixed>}>  $rows
     * @return array{
     *     total:int,
     *     procesados:int,
     *     observados:int,
     *     filas:list<array<string, mixed>>,
     *     observaciones:list<array<string, mixed>>
     * }
     */
    public function previewRows(CanalPago $canal, Carbon $fechaReferencia, array $rows): array
    {
        if ($rows === []) {
            throw ValidationException::withMessages([
                'archivo' => ['El archivo no contiene filas para procesar.'],
            ]);
        }

        $filas = [];
        foreach ($rows as $row) {
            $resultado = $this->filas->preview($canal, $fechaReferencia, $row['datos']);
            $filas[] = [
                'numero_fila' => $row['numero_fila'],
                ...$resultado,
            ];
        }

        $observaciones = array_values(array_filter(
            $filas,
            fn (array $fila): bool => $fila['estado'] === EstadoDetalleImportacionPago::Observada->value,
        ));

        return [
            'total' => count($filas),
            'procesados' => count($filas) - count($observaciones),
            'observados' => count($observaciones),
            'filas' => array_slice($filas, 0, 50),
            'observaciones' => array_slice($observaciones, 0, 50),
        ];
    }

    /**
     * @return list<array{numero_fila:int,datos:array<string, mixed>}>
     */
    public function readRows(CanalPago $canal, string $path, string $extension): array
    {
        $reader = $this->readerFor($canal, $extension);

        return $reader->read($path);
    }

    /**
     * @param  array{nombre_archivo:string,mime_type:?string,tamano:int,extension:string,hash_archivo:string}  $metadata
     * @param  list<array{numero_fila:int,datos:array<string, mixed>}>  $rows
     */
    public function importFromRows(
        CanalPago $canal,
        Carbon $fechaReferencia,
        array $metadata,
        array $rows,
        int $userId,
    ): ImportacionPago {
        if (ImportacionPago::query()->where('hash_archivo', $metadata['hash_archivo'])->exists()) {
            throw ValidationException::withMessages([
                'archivo' => ['Este archivo ya fue importado anteriormente.'],
            ]);
        }

        $importacion = ImportacionPago::query()->create([
            'canal_pago_id' => $canal->id,
            'fecha_referencia' => $fechaReferencia->toDateString(),
            'nombre_archivo' => $metadata['nombre_archivo'],
            'nombre_interno' => null,
            'disco' => null,
            'ruta_archivo' => null,
            'mime_type' => $metadata['mime_type'],
            'extension' => $metadata['extension'],
            'tamano' => $metadata['tamano'],
            'hash_archivo' => $metadata['hash_archivo'],
            'importado_por' => $userId,
            'estado' => EstadoImportacionPago::Pendiente,
        ]);

        return $this->processRows($importacion, $rows);
    }

    public function process(ImportacionPago $importacion): ImportacionPago
    {
        $importacion->update([
            'estado' => EstadoImportacionPago::Procesando,
            'iniciado_at' => now(),
            'mensaje_error' => null,
        ]);

        try {
            $path = Storage::disk($importacion->disco)->path($importacion->ruta_archivo);
            $reader = $this->readerFor($importacion->canalPago, (string) $importacion->extension);
            $rows = $reader->read($path);

            return $this->processRows($importacion, $rows);
        } catch (Throwable $e) {
            $importacion->update([
                'estado' => EstadoImportacionPago::Fallida,
                'finalizado_at' => now(),
                'mensaje_error' => $e->getMessage(),
            ]);

            return $importacion->fresh(['canalPago', 'importador']);
        }
    }

    /**
     * @param  list<array{numero_fila:int,datos:array<string, mixed>}>  $rows
     */
    public function processRows(ImportacionPago $importacion, array $rows): ImportacionPago
    {
        $importacion->update([
            'estado' => EstadoImportacionPago::Procesando,
            'iniciado_at' => now(),
            'mensaje_error' => null,
        ]);

        if ($rows === []) {
            throw new RuntimeException('El archivo no contiene filas para procesar.');
        }

        foreach ($rows as $row) {
            $this->filas->process($importacion, $row['numero_fila'], $row['datos']);
        }

        $this->refreshCounters($importacion);

        return $importacion->fresh(['canalPago', 'importador']);
    }

    public function refreshCounters(ImportacionPago $importacion): void
    {
        DB::transaction(function () use ($importacion): void {
            $total = $importacion->detalles()->count();
            $procesados = $importacion->detalles()
                ->where('estado', EstadoDetalleImportacionPago::Procesada->value)
                ->count();
            $observados = $importacion->detalles()
                ->where('estado', EstadoDetalleImportacionPago::Observada->value)
                ->count();

            $importacion->update([
                'total_registros' => $total,
                'registros_procesados' => $procesados + $observados,
                'registros_importados' => $procesados,
                'registros_observados' => $observados,
                'estado' => $observados > 0
                    ? EstadoImportacionPago::ProcesadaConObservaciones
                    : EstadoImportacionPago::Procesada,
                'finalizado_at' => now(),
            ]);
        });
    }

    private function readerFor(CanalPago $canal, string $extension): PaymentFileReaderInterface
    {
        if ($extension !== 'xlsx') {
            throw new RuntimeException('El archivo XLS fue recibido, pero el lector binario aun no esta activo. Use XLSX.');
        }

        return $canal->codigo === 'PAGALO_PE'
            ? new PagaloPeExcelReader()
            : new BancoNacionExcelReader();
    }
}
