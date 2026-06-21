<?php

namespace Database\Seeders;

use App\Models\ConceptoPago;
use Illuminate\Database\Seeder;

class ConceptoPagoSeeder extends Seeder
{
    public function run(): void
    {
        foreach ([
            ['codigo' => 'MATRICULA', 'nombre' => 'Matricula'],
            ['codigo' => 'PENSION', 'nombre' => 'Pension'],
        ] as $concepto) {
            ConceptoPago::query()->updateOrCreate(
                ['codigo' => $concepto['codigo']],
                $concepto + ['estado' => true],
            );
        }
    }
}
