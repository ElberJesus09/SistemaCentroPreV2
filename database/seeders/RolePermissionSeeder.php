<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Spatie\Permission\PermissionRegistrar;

class RolePermissionSeeder extends Seeder
{
    /**
     * @var list<string>
     */
    private array $permisos = [
        'acceder modulo personal',
        'ver trabajadores',
        'crear trabajadores',
        'editar trabajadores',
        'eliminar trabajadores',
        'ver usuarios',
        'crear usuarios',
        'editar usuarios',
        'eliminar usuarios',
        'asignar roles',
        'asignar permisos',
        'ver roles',
        'crear roles',
        'editar roles',
        'eliminar roles',
    ];

    public function run(): void
    {
        app(PermissionRegistrar::class)->forgetCachedPermissions();

        foreach ($this->permisos as $permiso) {
            Permission::query()->firstOrCreate([
                'name' => $permiso,
                'guard_name' => 'web',
            ]);
        }

        Permission::query()
            ->where('guard_name', 'web')
            ->whereNotIn('name', $this->permisos)
            ->delete();

        $superadmin = Role::query()->firstOrCreate(['name' => 'Superadmin', 'guard_name' => 'web']);
        $administrador = Role::query()->firstOrCreate(['name' => 'Administrador', 'guard_name' => 'web']);
        $secretaria = Role::query()->firstOrCreate(['name' => 'Secretaria', 'guard_name' => 'web']);
        Role::query()->firstOrCreate(['name' => 'Docente', 'guard_name' => 'web']);

        $superadmin->syncPermissions($this->permisos);
        $administrador->syncPermissions($this->permisos);
        $secretaria->syncPermissions([
            'acceder modulo personal',
            'ver trabajadores',
            'crear trabajadores',
            'editar trabajadores',
            'ver usuarios',
        ]);

        $admin = User::query()->firstOrCreate(
            ['email' => 'admin@centropre.test'],
            [
                'name' => 'Administrador del sistema',
                'password' => Hash::make('password'),
                'estado' => true,
            ],
        );

        $admin->syncRoles([$superadmin]);
        app(PermissionRegistrar::class)->forgetCachedPermissions();
    }
}
