<?php

namespace Database\Seeders;

use App\Models\GrupoAcademico;
use Illuminate\Database\Seeder;

class GrupoAcademicoSeeder extends Seeder
{
    public function run(): void
    {
        $grupos = [
            ['codigo' => 'engineering_agricultural', 'nombre' => 'Grupo I (Ingenierias - Agropecuarias)'],
            ['codigo' => 'medical', 'nombre' => 'Grupo II (Ciencias Medicas)'],
            ['codigo' => 'business', 'nombre' => 'Grupo III (Empresariales)'],
            ['codigo' => 'law_social', 'nombre' => 'Grupo IV (Derecho y Sociales)'],
        ];

        foreach ($grupos as $grupo) {
            GrupoAcademico::query()->updateOrCreate(
                ['codigo' => $grupo['codigo']],
                $grupo + ['estado' => true],
            );
        }
    }
}
