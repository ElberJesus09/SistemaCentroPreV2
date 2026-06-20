<?php

namespace App\Services\Institucional;

use App\Models\Facultad;
use Illuminate\Support\Facades\DB;

class FacultadService
{
    public function crear(array $datos): Facultad
    {
        return DB::transaction(fn (): Facultad => Facultad::query()->create($datos));
    }

    public function actualizar(Facultad $facultad, array $datos): Facultad
    {
        return DB::transaction(function () use ($facultad, $datos): Facultad {
            $facultad->update($datos);

            return $facultad->refresh();
        });
    }

    public function desactivar(Facultad $facultad): void
    {
        DB::transaction(fn () => $facultad->update(['estado' => false]));
    }
}
