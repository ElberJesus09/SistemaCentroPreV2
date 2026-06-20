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
                'tipo' => 'principal',
                'direccion' => 'Av. Jose Leonardo Ortiz 405, Chiclayo, Peru',
                'distrito' => 'Chiclayo',
                'provincia' => 'Chiclayo',
                'departamento' => 'Lambayeque',
                'pais' => 'Peru',
                'horario' => 'Lun - Vie segun calendario institucional',
                'correo' => 'soporteinformatico_cpu@unprg.edu.pe',
                'telefono' => '+51 987 654 321',
                'mapa_url' => 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d832.8989196118165!2d-79.84621234365474!3d-6.7750537240223245',
                'es_principal' => true,
                'permite_acceso_sistema' => true,
                'estado' => true,
            ],
        );
    }
}
