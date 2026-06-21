<?php

namespace App\Http\Controllers\Publico;

use App\Http\Controllers\Controller;
use App\Models\Carrera;
use App\Models\ConfiguracionInstitucional;
use App\Models\Sede;
use Illuminate\Database\Eloquent\Collection as EloquentCollection;
use Illuminate\Support\Facades\Schema;
use Illuminate\View\View;

class InicioController extends Controller
{
    public function __invoke(): View
    {
        return view('publico.inicio', [
            'configuracion' => $this->configuracion(),
            'sedePrincipal' => $this->sedePrincipal(),
            'totalSedes' => $this->countActive('sedes', Sede::class),
            'totalCarreras' => $this->countActive('carreras', Carrera::class),
            'carrerasDestacadas' => $this->carrerasDestacadas(),
        ]);
    }

    private function configuracion(): ?ConfiguracionInstitucional
    {
        if (! Schema::hasTable('configuracion_institucional')) {
            return null;
        }

        return ConfiguracionInstitucional::query()->where('estado', true)->first();
    }

    private function sedePrincipal(): ?Sede
    {
        if (! Schema::hasTable('sedes')) {
            return null;
        }

        return Sede::query()
            ->where('estado', true)
            ->where('es_principal', true)
            ->first();
    }

    /**
     * @param  class-string<\Illuminate\Database\Eloquent\Model>  $model
     */
    private function countActive(string $table, string $model): int
    {
        if (! Schema::hasTable($table)) {
            return 0;
        }

        return $model::query()->where('estado', true)->count();
    }

    /**
     * @return EloquentCollection<int, Carrera>
     */
    private function carrerasDestacadas(): EloquentCollection
    {
        if (! Schema::hasTable('carreras')) {
            return new EloquentCollection();
        }

        return Carrera::query()
            ->where('estado', true)
            ->where('es_destacada', true)
            ->orderBy('nombre')
            ->limit(6)
            ->get();
    }
}
