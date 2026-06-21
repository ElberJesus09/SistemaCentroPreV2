<?php

namespace App\Services\IngresosAdmision\Alumnos;

use Illuminate\Support\Carbon;

class ReglaApoderadoService
{
    public function requiereApoderado(Carbon|string $fechaNacimiento, ?Carbon $fechaRegistro = null): bool
    {
        $fecha = $fechaNacimiento instanceof Carbon
            ? $fechaNacimiento
            : Carbon::parse($fechaNacimiento);

        return $fecha->diffInYears($fechaRegistro ?? now()) < 18;
    }
}
