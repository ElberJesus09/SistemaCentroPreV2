<?php

namespace Database\Seeders;

use App\Models\TipoDocumento;
use Illuminate\Database\Seeder;

class TipoDocumentoSeeder extends Seeder
{
    public function run(): void
    {
        $tipos = [
            [
                'nombre' => 'Documento Nacional de Identidad',
                'codigo' => 'DNI',
                'longitud_minima' => 8,
                'longitud_maxima' => 8,
                'es_numerico' => true,
            ],
            [
                'nombre' => 'Carnet de extranjeria',
                'codigo' => 'CE',
                'longitud_minima' => 6,
                'longitud_maxima' => 20,
                'es_numerico' => false,
            ],
            [
                'nombre' => 'Pasaporte',
                'codigo' => 'PAS',
                'longitud_minima' => 6,
                'longitud_maxima' => 20,
                'es_numerico' => false,
            ],
        ];

        foreach ($tipos as $tipo) {
            TipoDocumento::query()->updateOrCreate(
                ['codigo' => $tipo['codigo']],
                $tipo + ['estado' => true],
            );
        }
    }
}
