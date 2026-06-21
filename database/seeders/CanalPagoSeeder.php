<?php

namespace Database\Seeders;

use App\Models\CanalPago;
use Illuminate\Database\Seeder;

class CanalPagoSeeder extends Seeder
{
    public function run(): void
    {
        foreach ([
            ['codigo' => 'BANCO_NACION', 'nombre' => 'Banco de la Nacion'],
            ['codigo' => 'PAGALO_PE', 'nombre' => 'Pagalo.pe'],
        ] as $canal) {
            CanalPago::query()->updateOrCreate(
                ['codigo' => $canal['codigo']],
                $canal + ['estado' => true],
            );
        }
    }
}
