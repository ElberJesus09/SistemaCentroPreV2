<?php

namespace App\Http\Controllers\IngresosAdmision\Academico;

use App\Http\Controllers\Controller;
use App\Http\Requests\IngresosAdmision\Academico\OfertaAcademicaStoreRequest;
use App\Http\Requests\IngresosAdmision\Academico\OfertaAcademicaUpdateRequest;
use App\Models\CicloAcademico;
use App\Models\OfertaAcademica;
use App\Models\Sede;
use App\Models\Turno;
use App\Services\IngresosAdmision\Academico\AcademicoAdmisionService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class OfertaAcademicaController extends Controller
{
    public function index(): View
    {
        $ofertas = OfertaAcademica::query()
            ->with(['cicloAcademico', 'sede', 'turno'])
            ->latest()
            ->paginate(20);

        return view('ingresos-admision.academico.ofertas.index', compact('ofertas'));
    }

    public function create(): View
    {
        return view('ingresos-admision.academico.ofertas.create', $this->formData(new OfertaAcademica()));
    }

    public function store(OfertaAcademicaStoreRequest $request): RedirectResponse
    {
        OfertaAcademica::query()->create($request->validated());

        return redirect()->route('ingresos-admision.ofertas.index')->with('status', 'Oferta academica creada.');
    }

    public function edit(OfertaAcademica $oferta): View
    {
        return view('ingresos-admision.academico.ofertas.edit', $this->formData($oferta));
    }

    public function update(OfertaAcademicaUpdateRequest $request, OfertaAcademica $oferta): RedirectResponse
    {
        $oferta->update($request->validated());

        return redirect()->route('ingresos-admision.ofertas.index')->with('status', 'Oferta academica actualizada.');
    }

    public function destroy(OfertaAcademica $oferta, AcademicoAdmisionService $service): RedirectResponse
    {
        $service->deleteOferta($oferta);

        return redirect()->route('ingresos-admision.ofertas.index')->with('status', 'Oferta academica eliminada.');
    }

    private function formData(OfertaAcademica $oferta): array
    {
        return [
            'oferta' => $oferta,
            'ciclos' => CicloAcademico::query()->orderByDesc('fecha_inicio')->get(),
            'sedes' => Sede::query()->where('estado', true)->orderBy('nombre')->get(),
            'turnos' => Turno::query()->orderBy('nombre')->get(),
        ];
    }
}
