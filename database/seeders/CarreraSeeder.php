<?php

namespace Database\Seeders;

use App\Models\Carrera;
use App\Models\Facultad;
use App\Models\GrupoAcademico;
use Illuminate\Database\Seeder;

class CarreraSeeder extends Seeder
{
    public function run(): void
    {
        $grupos = GrupoAcademico::query()->pluck('id', 'codigo');
        $facultades = Facultad::query()->pluck('id', 'sigla');

        $carreras = [
            ['ADM', 'ADMINISTRACION', 'business', 'FACEAC'],
            ['AGR', 'AGRONOMIA', 'engineering_agricultural', 'FAG'],
            ['ARK', 'ARQUEOLOGIA', 'law_social', 'FACHSE'],
            ['ARC', 'ARQUITECTURA', 'engineering_agricultural', 'FICSA'],
            ['ARP', 'ARTE - ARTES PLASTICAS', 'law_social', 'FACHSE'],
            ['APA', 'ARTE - PEDAGOGIA ARTISTICA', 'law_social', 'FACHSE'],
            ['ARD', 'ARTE - DANZAS', 'law_social', 'FACHSE'],
            ['ARM', 'ARTE - MUSICA', 'law_social', 'FACHSE'],
            ['ART', 'ARTE - TEATRO', 'law_social', 'FACHSE'],
            ['CPO', 'CIENCIA POLITICA', 'law_social', 'FDCP'],
            ['CBB', 'CIENCIAS BIOLOGICAS - BIOLOGIA', 'medical', 'FCCBB'],
            ['CBT', 'CIENCIAS BIOLOGICAS - BOTANICA', 'medical', 'FCCBB'],
            ['CBM', 'CIENCIAS BIOLOGICAS - MICROBIOLOGIA - PARASITOLOGIA', 'medical', 'FCCBB'],
            ['CBP', 'CIENCIAS BIOLOGICAS - PESQUERIA', 'medical', 'FCCBB'],
            ['CDC', 'CIENCIAS DE LA COMUNICACION', 'law_social', 'FACHSE'],
            ['CNI', 'COMERCIO Y NEGOCIOS INTERNACIONALES', 'business', 'FACEAC'],
            ['CON', 'CONTABILIDAD', 'business', 'FACEAC'],
            ['DER', 'DERECHO', 'law_social', 'FDCP'],
            ['ECO', 'ECONOMIA', 'business', 'FACEAC'],
            ['EHS', 'EDUCACION - CIENCIAS HIST. SOC. Y FILOSOFIA', 'law_social', 'FACHSE'],
            ['ECN', 'EDUCACION - CIENCIAS NATURALES', 'law_social', 'FACHSE'],
            ['EEF', 'EDUCACION - EDUCACION FISICA', 'law_social', 'FACHSE'],
            ['EIE', 'EDUCACION - IDIOMAS EXTRANJEROS', 'law_social', 'FACHSE'],
            ['EIN', 'EDUCACION - INICIAL', 'law_social', 'FACHSE'],
            ['ELL', 'EDUCACION - LENGUA Y LITERATURA', 'law_social', 'FACHSE'],
            ['EMC', 'EDUCACION - MATEMATICA Y COMPUTACION', 'law_social', 'FACHSE'],
            ['EPR', 'EDUCACION - PRIMARIA', 'law_social', 'FACHSE'],
            ['ENF', 'ENFERMERIA', 'medical', 'FE'],
            ['EST', 'ESTADISTICA', 'engineering_agricultural', 'FACFYM'],
            ['FIS', 'FISICA', 'engineering_agricultural', 'FACFYM'],
            ['IAG', 'INGENIERIA AGRICOLA', 'engineering_agricultural', 'FIA'],
            ['ICV', 'INGENIERIA CIVIL', 'engineering_agricultural', 'FICSA'],
            ['IIA', 'INGENIERIA DE INDUSTRIAS ALIMENTARIAS', 'engineering_agricultural', 'FIQIA'],
            ['ISI', 'INGENIERIA DE SISTEMAS', 'engineering_agricultural', 'FICSA'],
            ['IEL', 'INGENIERIA ELECTRONICA', 'engineering_agricultural', 'FACFYM'],
            ['ICI', 'INGENIERIA EN COMPUTACION E INFORMATICA', 'engineering_agricultural', 'FACFYM'],
            ['IME', 'INGENIERIA MECANICA Y ELECTRICA', 'engineering_agricultural', 'FIME'],
            ['IQU', 'INGENIERIA QUIMICA', 'engineering_agricultural', 'FIQIA'],
            ['IZO', 'INGENIERIA ZOOTECNIA', 'engineering_agricultural', 'FIZ'],
            ['MAT', 'MATEMATICAS', 'engineering_agricultural', 'FACFYM'],
            ['MED', 'MEDICINA HUMANA', 'medical', 'FMH'],
            ['MVE', 'MEDICINA VETERINARIA', 'medical', 'FMV'],
            ['PSI', 'PSICOLOGIA', 'law_social', 'FACHSE'],
            ['SOC', 'SOCIOLOGIA', 'law_social', 'FACHSE'],
        ];

        $destacadas = ['MED', 'ICV', 'ISI', 'ICI', 'ARC', 'CBB', 'MVE', 'DER', 'ENF', 'PSI', 'IAG'];

        foreach ($carreras as [$codigo, $nombre, $grupoCodigo, $facultadSigla]) {
            Carrera::query()->updateOrCreate(
                ['codigo' => $codigo],
                [
                    'nombre' => $nombre,
                    'grupo_academico_id' => $grupos[$grupoCodigo],
                    'facultad_id' => $facultades[$facultadSigla],
                    'enlace' => Facultad::query()->where('sigla', $facultadSigla)->value('enlace'),
                    'es_destacada' => in_array($codigo, $destacadas, true),
                    'estado' => true,
                ],
            );
        }
    }
}
