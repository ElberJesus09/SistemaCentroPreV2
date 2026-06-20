<?php

namespace App\Services\Institucional;

use App\Models\ConfiguracionInstitucional;
use Illuminate\Support\Facades\DB;

class ConfiguracionInstitucionalService
{
    public function obtenerActual(): ConfiguracionInstitucional
    {
        return ConfiguracionInstitucional::query()->firstOrCreate(
            ['nombre' => 'Centro Preuniversitario Juan Francisco Aguinaga Castro'],
            [
                'institucion_relacionada' => 'Universidad Nacional Pedro Ruiz Gallo - UNPRG',
                'estado' => true,
            ],
        );
    }

    public function actualizar(ConfiguracionInstitucional $configuracion, array $datos): ConfiguracionInstitucional
    {
        return DB::transaction(function () use ($configuracion, $datos): ConfiguracionInstitucional {
            $configuracion->update($datos);

            return $configuracion->refresh();
        });
    }
}
