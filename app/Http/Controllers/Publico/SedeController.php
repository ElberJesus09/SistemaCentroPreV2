<?php

namespace App\Http\Controllers\Publico;

use App\Http\Controllers\Controller;
use App\Models\ConfiguracionInstitucional;
use App\Models\Sede;
use Illuminate\Database\Eloquent\Collection as EloquentCollection;
use Illuminate\Support\Facades\Schema;
use Illuminate\View\View;

class SedeController extends Controller
{
    public function __invoke(): View
    {
        $sedes = Schema::hasTable('sedes')
            ? Sede::query()
                ->where('estado', true)
                ->orderByDesc('es_principal')
                ->orderBy('nombre')
                ->get()
            : new EloquentCollection();

        return view('publico.sedes', [
            'configuracion' => Schema::hasTable('configuracion_institucional')
                ? ConfiguracionInstitucional::query()->where('estado', true)->first()
                : null,
            'sedes' => $sedes,
            'sedePrincipal' => $sedes->firstWhere('es_principal', true) ?? $sedes->first(),
        ]);
    }
}
