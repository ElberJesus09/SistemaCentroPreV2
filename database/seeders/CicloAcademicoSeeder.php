<?php

namespace Database\Seeders;

use App\Models\CicloAcademico;
use Illuminate\Database\Seeder;

class CicloAcademicoSeeder extends Seeder
{
    public function run(): void
    {
        CicloAcademico::query()->updateOrCreate(
            ['codigo' => '2026-I'],
            [
                'nombre' => 'Ciclo 2026-I',
                'fecha_inicio' => '2026-01-15',
                'fecha_fin' => '2026-05-31',
                'fecha_inicio_inscripcion' => '2026-01-01',
                'fecha_fin_inscripcion' => '2026-01-31',
                'estado' => true,
            ],
        );
    }
}
