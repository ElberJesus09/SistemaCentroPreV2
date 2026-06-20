<?php

namespace App\Http\Controllers\Personal;

use App\Http\Controllers\Controller;
use App\Http\Requests\Personal\TrabajadorStoreRequest;
use App\Http\Requests\Personal\TrabajadorUpdateRequest;
use App\Models\Sede;
use App\Models\TipoDocumento;
use App\Models\Trabajador;
use App\Models\User;
use App\Services\Personal\TrabajadorService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Gate;
use Illuminate\View\View;

class TrabajadorController extends Controller
{
    public function __construct(private readonly TrabajadorService $trabajadorService)
    {
    }

    public function index(): View
    {
        Gate::authorize('viewAny', Trabajador::class);

        return view('personal.trabajadores.index', [
            'trabajadores' => Trabajador::query()
                ->with(['tipoDocumento', 'sede', 'user'])
                ->latest()
                ->paginate(10),
        ]);
    }

    public function create(): View
    {
        Gate::authorize('create', Trabajador::class);

        return view('personal.trabajadores.create', $this->formData());
    }

    public function store(TrabajadorStoreRequest $request): RedirectResponse
    {
        $this->trabajadorService->crearTrabajador($request->validated());

        return redirect()
            ->route('personal.trabajadores.index')
            ->with('status', 'Trabajador registrado correctamente.');
    }

    public function show(Trabajador $trabajador): View
    {
        Gate::authorize('view', $trabajador);

        return view('personal.trabajadores.show', [
            'trabajador' => $trabajador->load(['tipoDocumento', 'sede', 'user']),
        ]);
    }

    public function edit(Trabajador $trabajador): View
    {
        Gate::authorize('update', $trabajador);

        return view('personal.trabajadores.edit', $this->formData() + [
            'trabajador' => $trabajador,
        ]);
    }

    public function update(TrabajadorUpdateRequest $request, Trabajador $trabajador): RedirectResponse
    {
        $this->trabajadorService->actualizarTrabajador($trabajador, $request->validated());

        return redirect()
            ->route('personal.trabajadores.index')
            ->with('status', 'Trabajador actualizado correctamente.');
    }

    public function destroy(Trabajador $trabajador): RedirectResponse
    {
        Gate::authorize('delete', $trabajador);

        $this->trabajadorService->desactivarTrabajador($trabajador);

        return redirect()
            ->route('personal.trabajadores.index')
            ->with('status', 'Trabajador desactivado correctamente.');
    }

    /**
     * @return array<string, mixed>
     */
    private function formData(): array
    {
        return [
            'tiposDocumento' => TipoDocumento::query()->where('estado', true)->orderBy('nombre')->get(),
            'sedes' => Sede::query()->where('estado', true)->orderBy('nombre')->get(),
            'usuarios' => User::query()->where('estado', true)->orderBy('name')->get(),
        ];
    }
}
