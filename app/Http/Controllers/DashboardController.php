<?php

namespace App\Http\Controllers;

use App\Models\Carrera;
use App\Models\Facultad;
use App\Models\GrupoAcademico;
use App\Models\Sede;
use App\Models\Trabajador;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Schema;
use Illuminate\View\View;

class DashboardController extends Controller
{
    public function __invoke(): View
    {
        return view('dashboard.index', [
            'resumen' => [
                'trabajadores' => $this->countActive(Trabajador::class),
                'usuarios' => $this->countActive(User::class),
                'sedes' => $this->countActive(Sede::class),
                'gruposAcademicos' => $this->countActive(GrupoAcademico::class),
                'facultades' => $this->countActive(Facultad::class),
                'carreras' => $this->countActive(Carrera::class),
            ],
        ]);
    }

    /**
     * @param  class-string<Model>  $model
     */
    private function countActive(string $model): int
    {
        $instance = new $model();

        $table = $instance->getTable();

        if (! Schema::hasTable($table)) {
            return 0;
        }

        if (! Schema::hasColumn($table, 'estado')) {
            return $model::query()->count();
        }

        return $model::query()->where('estado', true)->count();
    }
}
