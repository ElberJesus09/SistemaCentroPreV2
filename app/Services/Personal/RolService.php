<?php

namespace App\Services\Personal;

use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;

class RolService
{
    /**
     * @param  array<string, mixed>  $datos
     */
    public function crearRol(array $datos): Role
    {
        return DB::transaction(function () use ($datos): Role {
            $rol = Role::query()->create([
                'name' => $datos['name'],
                'guard_name' => 'web',
            ]);

            $rol->syncPermissions($datos['permissions'] ?? []);

            return $rol;
        });
    }

    /**
     * @param  array<string, mixed>  $datos
     */
    public function actualizarRol(Role $rol, array $datos): Role
    {
        return DB::transaction(function () use ($rol, $datos): Role {
            $rol->update(['name' => $datos['name']]);
            $rol->syncPermissions($datos['permissions'] ?? []);

            return $rol->refresh();
        });
    }

    public function eliminarRol(Role $rol): void
    {
        DB::transaction(fn () => $rol->delete());
    }
}
