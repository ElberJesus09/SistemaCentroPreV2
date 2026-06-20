<?php

namespace App\Services\Institucional;

use App\Models\GrupoAcademico;
use Illuminate\Support\Facades\DB;

class GrupoAcademicoService
{
    public function crear(array $datos): GrupoAcademico
    {
        return DB::transaction(fn (): GrupoAcademico => GrupoAcademico::query()->create($datos));
    }

    public function actualizar(GrupoAcademico $grupoAcademico, array $datos): GrupoAcademico
    {
        return DB::transaction(function () use ($grupoAcademico, $datos): GrupoAcademico {
            $grupoAcademico->update($datos);

            return $grupoAcademico->refresh();
        });
    }

    public function desactivar(GrupoAcademico $grupoAcademico): void
    {
        DB::transaction(fn () => $grupoAcademico->update(['estado' => false]));
    }
}
