<?php

namespace Database\Seeders;

use App\Models\Facultad;
use Illuminate\Database\Seeder;

class FacultadSeeder extends Seeder
{
    public function run(): void
    {
        $facultades = [
            ['sigla' => 'FACEAC', 'nombre' => 'Facultad de Ciencias Economicas, Administrativas y Contables', 'enlace' => 'https://faceac.unprg.edu.pe/'],
            ['sigla' => 'FCCBB', 'nombre' => 'Facultad de Ciencias Biologicas', 'enlace' => 'https://fccbb.unprg.edu.pe/escuela-profesional'],
            ['sigla' => 'FE', 'nombre' => 'Facultad de Enfermeria', 'enlace' => 'https://www.unprg.edu.pe/admision/index.php/carreras-profesionales/pregrado?view=article&id=141'],
            ['sigla' => 'FMH', 'nombre' => 'Facultad de Medicina Humana', 'enlace' => 'https://fmh.unprg.edu.pe/escuela-profesional'],
            ['sigla' => 'FMV', 'nombre' => 'Facultad de Medicina Veterinaria', 'enlace' => 'https://fmv.unprg.edu.pe/escuela-profesional'],
            ['sigla' => 'FICSA', 'nombre' => 'Facultad de Ingenieria Civil, de Sistemas y de Arquitectura', 'enlace' => 'https://ficsa.unprg.edu.pe/escuelas-profesionales'],
            ['sigla' => 'FACFYM', 'nombre' => 'Facultad de Ciencias Fisicas y Matematicas', 'enlace' => 'https://facfym.unprg.edu.pe/escuelas-profesionales'],
            ['sigla' => 'FIME', 'nombre' => 'Facultad de Ingenieria Mecanica y Electrica', 'enlace' => 'https://fime.unprg.edu.pe/escuela-profesional'],
            ['sigla' => 'FIQIA', 'nombre' => 'Facultad de Ingenieria Quimica e Industrias Alimentarias', 'enlace' => 'https://figia.unprg.edu.pe/escuelas-profesionales'],
            ['sigla' => 'FAG', 'nombre' => 'Facultad de Agronomia', 'enlace' => 'https://fag.unprg.edu.pe/escuela-profesional'],
            ['sigla' => 'FIA', 'nombre' => 'Facultad de Ingenieria Agricola', 'enlace' => 'https://fia.unprg.edu.pe/escuela-profesional'],
            ['sigla' => 'FIZ', 'nombre' => 'Facultad de Zootecnia', 'enlace' => 'https://fiz.unprg.edu.pe/escuela-profesional'],
            ['sigla' => 'FACHSE', 'nombre' => 'Facultad de Ciencias Historico Sociales y Educacion', 'enlace' => 'https://fachse.unprg.edu.pe/'],
            ['sigla' => 'FDCP', 'nombre' => 'Facultad de Derecho y Ciencia Politica', 'enlace' => 'https://fdcp.unprg.edu.pe/'],
        ];

        foreach ($facultades as $facultad) {
            Facultad::query()->updateOrCreate(
                ['sigla' => $facultad['sigla']],
                $facultad + ['estado' => true],
            );
        }
    }
}
