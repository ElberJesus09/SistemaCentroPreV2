<?php

namespace App\Http\Controllers\Institucional;

use App\Http\Controllers\Controller;
use App\Http\Requests\Institucional\FacultadStoreRequest;
use App\Http\Requests\Institucional\FacultadUpdateRequest;
use App\Models\Facultad;
use App\Services\Institucional\FacultadService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class FacultadController extends Controller
{
    public function __construct(private readonly FacultadService $service)
    {
        $this->authorizeResource(Facultad::class, 'facultad');
    }

    public function index(): View
    {
        return view('institucional.facultades.index', ['facultades' => Facultad::query()->latest()->paginate(10)]);
    }

    public function create(): View
    {
        return view('institucional.facultades.create');
    }

    public function store(FacultadStoreRequest $request): RedirectResponse
    {
        $this->service->crear($request->validated());

        return redirect()->route('institucional.facultades.index')->with('status', 'Facultad registrada.');
    }

    public function show(Facultad $facultad): View
    {
        return view('institucional.facultades.show', compact('facultad'));
    }

    public function edit(Facultad $facultad): View
    {
        return view('institucional.facultades.edit', compact('facultad'));
    }

    public function update(FacultadUpdateRequest $request, Facultad $facultad): RedirectResponse
    {
        $this->service->actualizar($facultad, $request->validated());

        return redirect()->route('institucional.facultades.index')->with('status', 'Facultad actualizada.');
    }

    public function destroy(Facultad $facultad): RedirectResponse
    {
        $this->service->desactivar($facultad);

        return redirect()->route('institucional.facultades.index')->with('status', 'Facultad desactivada.');
    }
}
