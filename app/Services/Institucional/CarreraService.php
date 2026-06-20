<?php

namespace App\Services\Institucional;

use App\Models\Carrera;
use Illuminate\Support\Facades\DB;

class CarreraService
{
    public function crear(array $datos): Carrera
    {
        return DB::transaction(fn (): Carrera => Carrera::query()->create($datos));
    }

    public function actualizar(Carrera $carrera, array $datos): Carrera
    {
        return DB::transaction(function () use ($carrera, $datos): Carrera {
            $carrera->update($datos);

            return $carrera->refresh();
        });
    }

    public function desactivar(Carrera $carrera): void
    {
        DB::transaction(fn () => $carrera->update(['estado' => false]));
    }
}
