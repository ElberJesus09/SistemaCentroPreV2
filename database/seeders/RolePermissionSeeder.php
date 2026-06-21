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
        'acceder dashboard',
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
        'acceder modulo institucional',
        'ver institucional',
        'editar institucional',
        'ver sedes',
        'crear sedes',
        'editar sedes',
        'eliminar sedes',
        'ver grupos academicos',
        'crear grupos academicos',
        'editar grupos academicos',
        'eliminar grupos academicos',
        'ver facultades',
        'crear facultades',
        'editar facultades',
        'eliminar facultades',
        'ver carreras',
        'crear carreras',
        'editar carreras',
        'eliminar carreras',
        'acceder modulo ingresos admision',
        'ver pagos',
        'ver importaciones de pagos',
        'importar pagos',
        'descargar archivos de pagos',
        'ver detalles de importacion',
        'reprocesar pagos observados',
        'observar pagos',
        'rechazar pagos',
        'anular pagos',
        'gestionar codigos externos de pago',
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
        $docente = Role::query()->firstOrCreate(['name' => 'Docente', 'guard_name' => 'web']);

        $superadmin->syncPermissions($this->permisos);
        $administrador->syncPermissions($this->permisos);
        $secretaria->syncPermissions([
            'acceder dashboard',
            'acceder modulo personal',
            'ver trabajadores',
            'crear trabajadores',
            'editar trabajadores',
            'ver usuarios',
            'acceder modulo institucional',
            'ver institucional',
            'ver sedes',
            'ver grupos academicos',
            'ver facultades',
            'ver carreras',
            'acceder modulo ingresos admision',
            'ver pagos',
            'ver importaciones de pagos',
            'ver detalles de importacion',
        ]);
        $docente->syncPermissions([
            'acceder dashboard',
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
