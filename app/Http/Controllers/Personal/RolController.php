<?php

namespace App\Http\Controllers\Personal;

use App\Http\Controllers\Controller;
use App\Http\Requests\Personal\RolStoreRequest;
use App\Http\Requests\Personal\RolUpdateRequest;
use App\Services\Personal\RolService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Gate;
use Illuminate\View\View;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RolController extends Controller
{
    public function __construct(private readonly RolService $rolService)
    {
    }

    public function index(): View
    {
        Gate::authorize('viewAny', Role::class);

        return view('personal.roles.index', [
            'roles' => Role::query()->withCount('permissions')->where('guard_name', 'web')->latest()->paginate(10),
        ]);
    }

    public function create(): View
    {
        Gate::authorize('create', Role::class);

        return view('personal.roles.create', $this->formData());
    }

    public function store(RolStoreRequest $request): RedirectResponse
    {
        $this->rolService->crearRol($request->validated());

        return redirect()
            ->route('personal.roles.index')
            ->with('status', 'Rol registrado correctamente.');
    }

    public function show(Role $role): View
    {
        Gate::authorize('view', $role);

        return view('personal.roles.show', [
            'role' => $role->load('permissions'),
        ]);
    }

    public function edit(Role $role): View
    {
        Gate::authorize('update', $role);

        return view('personal.roles.edit', $this->formData() + [
            'role' => $role->load('permissions'),
        ]);
    }

    public function update(RolUpdateRequest $request, Role $role): RedirectResponse
    {
        $this->rolService->actualizarRol($role, $request->validated());

        return redirect()
            ->route('personal.roles.index')
            ->with('status', 'Rol actualizado correctamente.');
    }

    public function destroy(Role $role): RedirectResponse
    {
        Gate::authorize('delete', $role);

        $this->rolService->eliminarRol($role);

        return redirect()
            ->route('personal.roles.index')
            ->with('status', 'Rol eliminado correctamente.');
    }

    /**
     * @return array<string, mixed>
     */
    private function formData(): array
    {
        return [
            'permissions' => Permission::query()->where('guard_name', 'web')->orderBy('name')->get(),
        ];
    }
}
