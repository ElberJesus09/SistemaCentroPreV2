<?php

namespace App\Http\Controllers\IngresosAdmision\Academico;

use App\Http\Controllers\Controller;
use App\Http\Requests\IngresosAdmision\Academico\CicloAcademicoStoreRequest;
use App\Http\Requests\IngresosAdmision\Academico\CicloAcademicoUpdateRequest;
use App\Models\CicloAcademico;
use App\Services\IngresosAdmision\Academico\AcademicoAdmisionService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class CicloAcademicoController extends Controller
{
    public function index(): View
    {
        $ciclos = CicloAcademico::query()->latest()->paginate(20);

        return view('ingresos-admision.academico.ciclos.index', compact('ciclos'));
    }

    public function create(): View
    {
        return view('ingresos-admision.academico.ciclos.create', ['ciclo' => new CicloAcademico()]);
    }

    public function store(CicloAcademicoStoreRequest $request): RedirectResponse
    {
        CicloAcademico::query()->create($request->validated());

        return redirect()->route('ingresos-admision.ciclos.index')->with('status', 'Ciclo academico creado.');
    }

    public function edit(CicloAcademico $ciclo): View
    {
        return view('ingresos-admision.academico.ciclos.edit', compact('ciclo'));
    }

    public function update(CicloAcademicoUpdateRequest $request, CicloAcademico $ciclo): RedirectResponse
    {
        $ciclo->update($request->validated());

        return redirect()->route('ingresos-admision.ciclos.index')->with('status', 'Ciclo academico actualizado.');
    }

    public function destroy(CicloAcademico $ciclo, AcademicoAdmisionService $service): RedirectResponse
    {
        $service->deleteCiclo($ciclo);

        return redirect()->route('ingresos-admision.ciclos.index')->with('status', 'Ciclo academico eliminado.');
    }
}
