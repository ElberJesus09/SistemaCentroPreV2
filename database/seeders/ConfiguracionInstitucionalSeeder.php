<?php

namespace Database\Seeders;

use App\Models\ConfiguracionInstitucional;
use Illuminate\Database\Seeder;

class ConfiguracionInstitucionalSeeder extends Seeder
{
    public function run(): void
    {
        ConfiguracionInstitucional::query()->updateOrCreate(
            ['nombre' => 'Centro Preuniversitario Juan Francisco Aguinaga Castro'],
            [
                'institucion_relacionada' => 'Universidad Nacional Pedro Ruiz Gallo - UNPRG',
                'proposito_portal' => 'Mostrar informacion institucional, sedes, carreras y servicios publicos del centro preuniversitario.',
                'descripcion_publica' => 'Preparacion preuniversitaria con orientacion academica hacia la Universidad Nacional Pedro Ruiz Gallo.',
                'correo' => 'soporteinformatico_cpu@unprg.edu.pe',
                'telefono' => null,
                'sitio_web' => 'https://www.unprg.edu.pe/',
                'estado' => true,
            ],
        );
    }
}
