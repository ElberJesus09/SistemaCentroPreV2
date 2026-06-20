<?php

namespace App\Http\Controllers\Institucional;

use App\Http\Controllers\Controller;
use App\Http\Requests\Institucional\CarreraStoreRequest;
use App\Http\Requests\Institucional\CarreraUpdateRequest;
use App\Models\Carrera;
use App\Models\Facultad;
use App\Models\GrupoAcademico;
use App\Services\Institucional\CarreraService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class CarreraController extends Controller
{
    public function __construct(private readonly CarreraService $service)
    {
        $this->authorizeResource(Carrera::class, 'carrera');
    }

    public function index(): View
    {
        return view('institucional.carreras.index', [
            'carreras' => Carrera::query()->with(['grupoAcademico', 'facultad'])->latest()->paginate(10),
        ]);
    }

    public function create(): View
    {
        return view('institucional.carreras.create', $this->formData());
    }

    public function store(CarreraStoreRequest $request): RedirectResponse
    {
        $this->service->crear($request->validated());

        return redirect()->route('institucional.carreras.index')->with('status', 'Carrera registrada.');
    }

    public function show(Carrera $carrera): View
    {
        return view('institucional.carreras.show', ['carrera' => $carrera->load(['grupoAcademico', 'facultad'])]);
    }

    public function edit(Carrera $carrera): View
    {
        return view('institucional.carreras.edit', $this->formData() + compact('carrera'));
    }

    public function update(CarreraUpdateRequest $request, Carrera $carrera): RedirectResponse
    {
        $this->service->actualizar($carrera, $request->validated());

        return redirect()->route('institucional.carreras.index')->with('status', 'Carrera actualizada.');
    }

    public function destroy(Carrera $carrera): RedirectResponse
    {
        $this->service->desactivar($carrera);

        return redirect()->route('institucional.carreras.index')->with('status', 'Carrera desactivada.');
    }

    private function formData(): array
    {
        return [
            'gruposAcademicos' => GrupoAcademico::query()->where('estado', true)->orderBy('nombre')->get(),
            'facultades' => Facultad::query()->where('estado', true)->orderBy('nombre')->get(),
        ];
    }
}
