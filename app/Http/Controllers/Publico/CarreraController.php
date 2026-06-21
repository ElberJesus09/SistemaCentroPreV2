<?php

namespace App\Http\Controllers\Publico;

use App\Http\Controllers\Controller;
use App\Models\Carrera;
use App\Models\ConfiguracionInstitucional;
use Illuminate\Database\Eloquent\Collection as EloquentCollection;
use Illuminate\Support\Facades\Schema;
use Illuminate\View\View;

class CarreraController extends Controller
{
    public function __invoke(): View
    {
        $carreras = Schema::hasTable('carreras')
            ? Carrera::query()
                ->with(['facultad', 'grupoAcademico'])
                ->where('estado', true)
                ->orderByDesc('es_destacada')
                ->orderBy('nombre')
                ->get()
            : new EloquentCollection();

        return view('publico.carreras', [
            'configuracion' => Schema::hasTable('configuracion_institucional')
                ? ConfiguracionInstitucional::query()->where('estado', true)->first()
                : null,
            'destacadas' => $carreras->where('es_destacada', true)->values(),
            'otras' => $carreras->where('es_destacada', false)->values(),
        ]);
    }
}
