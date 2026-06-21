<?php

namespace App\Http\Controllers\IngresosAdmision\Academico;

use App\Http\Controllers\Controller;
use App\Http\Requests\IngresosAdmision\Academico\TurnoStoreRequest;
use App\Http\Requests\IngresosAdmision\Academico\TurnoUpdateRequest;
use App\Models\Turno;
use App\Services\IngresosAdmision\Academico\AcademicoAdmisionService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class TurnoController extends Controller
{
    public function index(): View
    {
        $turnos = Turno::query()->orderBy('nombre')->paginate(20);

        return view('ingresos-admision.academico.turnos.index', compact('turnos'));
    }

    public function create(): View
    {
        return view('ingresos-admision.academico.turnos.create', ['turno' => new Turno()]);
    }

    public function store(TurnoStoreRequest $request): RedirectResponse
    {
        Turno::query()->create($request->validated());

        return redirect()->route('ingresos-admision.turnos.index')->with('status', 'Turno creado.');
    }

    public function edit(Turno $turno): View
    {
        return view('ingresos-admision.academico.turnos.edit', compact('turno'));
    }

    public function update(TurnoUpdateRequest $request, Turno $turno): RedirectResponse
    {
        $turno->update($request->validated());

        return redirect()->route('ingresos-admision.turnos.index')->with('status', 'Turno actualizado.');
    }

    public function destroy(Turno $turno, AcademicoAdmisionService $service): RedirectResponse
    {
        $service->deleteTurno($turno);

        return redirect()->route('ingresos-admision.turnos.index')->with('status', 'Turno eliminado.');
    }
}
