<?php

namespace Database\Seeders;

use App\Models\CanalPago;
use App\Models\CodigoPagoExterno;
use App\Models\ConceptoPago;
use Illuminate\Database\Seeder;

class CodigoPagoExternoSeeder extends Seeder
{
    public function run(): void
    {
        $canalBanco = CanalPago::query()->where('codigo', 'BANCO_NACION')->first();
        $matricula = ConceptoPago::query()->where('codigo', 'MATRICULA')->first();
        $pension = ConceptoPago::query()->where('codigo', 'PENSION')->first();

        if (! $canalBanco || ! $matricula || ! $pension) {
            return;
        }

        foreach ([
            ['codigo_externo' => '00001096', 'concepto_pago_id' => $matricula->id, 'descripcion_externa' => 'Matricula Banco de la Nacion'],
            ['codigo_externo' => '00001097', 'concepto_pago_id' => $pension->id, 'descripcion_externa' => 'Pension Banco de la Nacion'],
        ] as $codigo) {
            CodigoPagoExterno::query()->updateOrCreate(
                [
                    'canal_pago_id' => $canalBanco->id,
                    'codigo_externo' => $codigo['codigo_externo'],
                ],
                $codigo + [
                    'canal_pago_id' => $canalBanco->id,
                    'estado' => true,
                ],
            );
        }
    }
}
