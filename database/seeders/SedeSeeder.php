<?php

namespace Database\Seeders;

use App\Models\Sede;
use Illuminate\Database\Seeder;

class SedeSeeder extends Seeder
{
    public function run(): void
    {
        Sede::query()->updateOrCreate(
            ['nombre' => 'Centro Preuniversitario Juan Francisco Aguinaga Castro'],
            [
                'direccion' => 'Av. Jose Leonardo Ortiz 405, Chiclayo, Peru',
                'telefono' => '+51 987 654 321',
                'estado' => true,
            ],
        );
    }
}
