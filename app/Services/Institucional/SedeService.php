<?php

namespace App\Services\Institucional;

use App\Models\Sede;
use Illuminate\Support\Facades\DB;

class SedeService
{
    public function crear(array $datos): Sede
    {
        return DB::transaction(function () use ($datos): Sede {
            if ($datos['es_principal']) {
                Sede::query()->where('es_principal', true)->update(['es_principal' => false]);
            }

            return Sede::query()->create($datos);
        });
    }

    public function actualizar(Sede $sede, array $datos): Sede
    {
        return DB::transaction(function () use ($sede, $datos): Sede {
            if ($datos['es_principal']) {
                Sede::query()->whereKeyNot($sede->id)->where('es_principal', true)->update(['es_principal' => false]);
            }

            $sede->update($datos);

            return $sede->refresh();
        });
    }

    public function desactivar(Sede $sede): void
    {
        DB::transaction(fn () => $sede->update(['estado' => false]));
    }
}
