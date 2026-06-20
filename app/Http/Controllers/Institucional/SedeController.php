<?php

namespace App\Http\Controllers\Institucional;

use App\Http\Controllers\Controller;
use App\Http\Requests\Institucional\SedeStoreRequest;
use App\Http\Requests\Institucional\SedeUpdateRequest;
use App\Models\Sede;
use App\Services\Institucional\SedeService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class SedeController extends Controller
{
    public function __construct(private readonly SedeService $service)
    {
        $this->authorizeResource(Sede::class, 'sede');
    }

    public function index(): View
    {
        return view('institucional.sedes.index', ['sedes' => Sede::query()->latest()->paginate(10)]);
    }

    public function create(): View
    {
        return view('institucional.sedes.create');
    }

    public function store(SedeStoreRequest $request): RedirectResponse
    {
        $this->service->crear($request->validated());

        return redirect()->route('institucional.sedes.index')->with('status', 'Sede registrada correctamente.');
    }

    public function show(Sede $sede): View
    {
        return view('institucional.sedes.show', compact('sede'));
    }

    public function edit(Sede $sede): View
    {
        return view('institucional.sedes.edit', compact('sede'));
    }

    public function update(SedeUpdateRequest $request, Sede $sede): RedirectResponse
    {
        $this->service->actualizar($sede, $request->validated());

        return redirect()->route('institucional.sedes.index')->with('status', 'Sede actualizada correctamente.');
    }

    public function destroy(Sede $sede): RedirectResponse
    {
        $this->service->desactivar($sede);

        return redirect()->route('institucional.sedes.index')->with('status', 'Sede desactivada correctamente.');
    }
}
