<?php

namespace App\Http\Controllers\Institucional;

use App\Http\Controllers\Controller;
use App\Http\Requests\Institucional\GrupoAcademicoStoreRequest;
use App\Http\Requests\Institucional\GrupoAcademicoUpdateRequest;
use App\Models\GrupoAcademico;
use App\Services\Institucional\GrupoAcademicoService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class GrupoAcademicoController extends Controller
{
    public function __construct(private readonly GrupoAcademicoService $service)
    {
        $this->authorizeResource(GrupoAcademico::class, 'grupoAcademico');
    }

    public function index(): View
    {
        return view('institucional.grupos-academicos.index', ['grupos' => GrupoAcademico::query()->latest()->paginate(10)]);
    }

    public function create(): View
    {
        return view('institucional.grupos-academicos.create');
    }

    public function store(GrupoAcademicoStoreRequest $request): RedirectResponse
    {
        $this->service->crear($request->validated());

        return redirect()->route('institucional.grupos-academicos.index')->with('status', 'Grupo academico registrado.');
    }

    public function show(GrupoAcademico $grupoAcademico): View
    {
        return view('institucional.grupos-academicos.show', compact('grupoAcademico'));
    }

    public function edit(GrupoAcademico $grupoAcademico): View
    {
        return view('institucional.grupos-academicos.edit', compact('grupoAcademico'));
    }

    public function update(GrupoAcademicoUpdateRequest $request, GrupoAcademico $grupoAcademico): RedirectResponse
    {
        $this->service->actualizar($grupoAcademico, $request->validated());

        return redirect()->route('institucional.grupos-academicos.index')->with('status', 'Grupo academico actualizado.');
    }

    public function destroy(GrupoAcademico $grupoAcademico): RedirectResponse
    {
        $this->service->desactivar($grupoAcademico);

        return redirect()->route('institucional.grupos-academicos.index')->with('status', 'Grupo academico desactivado.');
    }
}
