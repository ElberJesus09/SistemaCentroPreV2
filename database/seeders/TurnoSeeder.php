<?php

namespace Database\Seeders;

use App\Models\Turno;
use Illuminate\Database\Seeder;

class TurnoSeeder extends Seeder
{
    public function run(): void
    {
        foreach ([
            ['codigo' => 'MANANA', 'nombre' => 'Mañana', 'hora_inicio' => '08:00', 'hora_fin' => '12:00'],
            ['codigo' => 'TARDE', 'nombre' => 'Tarde', 'hora_inicio' => '14:00', 'hora_fin' => '18:00'],
        ] as $turno) {
            Turno::query()->updateOrCreate(
                ['codigo' => $turno['codigo']],
                $turno + ['estado' => true],
            );
        }
    }
}
