<?php

namespace App\Http\Controllers\Personal;

use App\Http\Controllers\Controller;
use App\Http\Requests\Personal\UsuarioStoreRequest;
use App\Http\Requests\Personal\UsuarioUpdateRequest;
use App\Models\User;
use App\Services\Personal\UsuarioService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Gate;
use Illuminate\View\View;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class UsuarioController extends Controller
{
    public function __construct(private readonly UsuarioService $usuarioService)
    {
    }

    public function index(): View
    {
        Gate::authorize('viewAny', User::class);

        return view('personal.usuarios.index', [
            'usuarios' => User::query()->with(['roles', 'permissions', 'trabajador'])->latest()->paginate(10),
        ]);
    }

    public function create(): View
    {
        Gate::authorize('create', User::class);

        return view('personal.usuarios.create', $this->formData());
    }

    public function store(UsuarioStoreRequest $request): RedirectResponse
    {
        $this->usuarioService->crearUsuario($request->validated());

        return redirect()
            ->route('personal.usuarios.index')
            ->with('status', 'Usuario registrado correctamente.');
    }

    public function show(User $usuario): View
    {
        Gate::authorize('view', $usuario);

        return view('personal.usuarios.show', [
            'usuario' => $usuario->load([
                'roles',
                'trabajador',
                'permisosTemporales.permission',
                'permisosTemporales.grantedBy',
            ]),
            'permissions' => Permission::query()->where('guard_name', 'web')->orderBy('name')->get(),
        ]);
    }

    public function edit(User $usuario): View
    {
        Gate::authorize('update', $usuario);

        return view('personal.usuarios.edit', $this->formData() + [
            'usuario' => $usuario->load('roles'),
        ]);
    }

    public function update(UsuarioUpdateRequest $request, User $usuario): RedirectResponse
    {
        $this->usuarioService->actualizarUsuario($usuario, $request->validated());

        return redirect()
            ->route('personal.usuarios.index')
            ->with('status', 'Usuario actualizado correctamente.');
    }

    public function destroy(User $usuario): RedirectResponse
    {
        Gate::authorize('delete', $usuario);

        $this->usuarioService->desactivarUsuario($usuario);

        return redirect()
            ->route('personal.usuarios.index')
            ->with('status', 'Usuario desactivado correctamente.');
    }

    /**
     * @return array<string, mixed>
     */
    private function formData(): array
    {
        return [
            'roles' => Role::query()->where('guard_name', 'web')->orderBy('name')->get(),
        ];
    }
}
