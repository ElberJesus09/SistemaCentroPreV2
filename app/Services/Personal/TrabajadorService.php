<?php

namespace App\Services\Personal;

use App\Models\Trabajador;
use Illuminate\Support\Facades\DB;

class TrabajadorService
{
    /**
     * @param  array<string, mixed>  $datos
     */
    public function crearTrabajador(array $datos): Trabajador
    {
        return DB::transaction(fn (): Trabajador => Trabajador::query()->create($datos));
    }

    /**
     * @param  array<string, mixed>  $datos
     */
    public function actualizarTrabajador(Trabajador $trabajador, array $datos): Trabajador
    {
        return DB::transaction(function () use ($trabajador, $datos): Trabajador {
            $trabajador->update($datos);

            return $trabajador->refresh();
        });
    }

    public function desactivarTrabajador(Trabajador $trabajador): void
    {
        DB::transaction(fn () => $trabajador->update(['estado' => false]));
    }
}
