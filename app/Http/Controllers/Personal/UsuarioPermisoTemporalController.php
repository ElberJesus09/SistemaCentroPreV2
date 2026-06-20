<?php

namespace App\Http\Controllers\Personal;

use App\Http\Controllers\Controller;
use App\Http\Requests\Personal\PermisoTemporalStoreRequest;
use App\Models\User;
use App\Models\PermisoTemporalUsuario;
use App\Services\Personal\UsuarioService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Gate;

class UsuarioPermisoTemporalController extends Controller
{
    public function __construct(private readonly UsuarioService $usuarioService)
    {
    }

    public function store(PermisoTemporalStoreRequest $request, User $usuario): RedirectResponse
    {
        Gate::authorize('update', $usuario);

        $this->usuarioService->asignarPermisoTemporal(
            $usuario,
            $request->user(),
            $request->validated(),
        );

        return redirect()
            ->route('personal.usuarios.show', $usuario)
            ->with('status', 'Permiso temporal asignado correctamente.');
    }

    public function destroy(User $usuario, PermisoTemporalUsuario $permisoTemporal): RedirectResponse
    {
        Gate::authorize('update', $usuario);
        Gate::authorize('asignar permisos');

        abort_unless($permisoTemporal->user_id === $usuario->id, 404);

        $this->usuarioService->revocarPermisoTemporal($permisoTemporal);

        return redirect()
            ->route('personal.usuarios.show', $usuario)
            ->with('status', 'Permiso temporal revocado correctamente.');
    }
}
