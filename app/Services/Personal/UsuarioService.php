<?php

namespace App\Services\Personal;

use App\Models\User;
use App\Models\PermisoTemporalUsuario;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;

class UsuarioService
{
    /**
     * @param  array<string, mixed>  $datos
     */
    public function crearUsuario(array $datos): User
    {
        return DB::transaction(function () use ($datos): User {
            $usuario = User::query()->create(Arr::only($datos, [
                'name',
                'email',
                'password',
                'estado',
            ]));

            $this->sincronizarAccesos($usuario, $datos);

            return $usuario;
        });
    }

    /**
     * @param  array<string, mixed>  $datos
     */
    public function actualizarUsuario(User $usuario, array $datos): User
    {
        return DB::transaction(function () use ($usuario, $datos): User {
            $payload = Arr::only($datos, ['name', 'email', 'estado']);

            if (! empty($datos['password'])) {
                $payload['password'] = $datos['password'];
            }

            $usuario->update($payload);
            $this->sincronizarAccesos($usuario, $datos);

            return $usuario->refresh();
        });
    }

    public function desactivarUsuario(User $usuario): void
    {
        DB::transaction(fn () => $usuario->update(['estado' => false]));
    }

    /**
     * @param  array<string, mixed>  $datos
     */
    public function asignarPermisoTemporal(User $usuario, User $otorgadoPor, array $datos): PermisoTemporalUsuario
    {
        return DB::transaction(fn (): PermisoTemporalUsuario => PermisoTemporalUsuario::query()->create([
            'user_id' => $usuario->id,
            'permission_id' => $datos['permission_id'],
            'granted_by' => $otorgadoPor->id,
            'starts_at' => now(),
            'expires_at' => $datos['expires_at'],
            'reason' => $datos['reason'] ?? null,
        ]));
    }

    public function revocarPermisoTemporal(PermisoTemporalUsuario $permisoTemporal): void
    {
        DB::transaction(fn () => $permisoTemporal->update(['revoked_at' => now()]));
    }

    /**
     * @param  array<string, mixed>  $datos
     */
    private function sincronizarAccesos(User $usuario, array $datos): void
    {
        if (array_key_exists('roles', $datos)) {
            $usuario->syncRoles($datos['roles'] ?? []);
        }

    }
}
