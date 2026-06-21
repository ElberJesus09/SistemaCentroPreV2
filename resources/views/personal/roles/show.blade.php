@extends('layouts.app')

@section('title', 'Detalle rol')

@section('content')
    @php
        $selectedPermissions = $role->permissions->pluck('name')->all();
        $groups = [
            'Dashboard' => [
                'Acceso general' => ['acceder dashboard'],
            ],
            'Modulo Personal' => [
                'Acceso general' => ['acceder modulo personal'],
                'Trabajadores' => ['ver trabajadores', 'crear trabajadores', 'editar trabajadores', 'eliminar trabajadores'],
                'Usuarios' => ['ver usuarios', 'crear usuarios', 'editar usuarios', 'eliminar usuarios', 'asignar roles', 'asignar permisos'],
                'Roles' => ['ver roles', 'crear roles', 'editar roles', 'eliminar roles'],
            ],
            'Modulo Institucional' => [
                'Acceso general' => ['acceder modulo institucional'],
                'Configuracion' => ['ver institucional', 'editar institucional'],
                'Sedes' => ['ver sedes', 'crear sedes', 'editar sedes', 'eliminar sedes'],
                'Grupos academicos' => ['ver grupos academicos', 'crear grupos academicos', 'editar grupos academicos', 'eliminar grupos academicos'],
                'Facultades' => ['ver facultades', 'crear facultades', 'editar facultades', 'eliminar facultades'],
                'Carreras' => ['ver carreras', 'crear carreras', 'editar carreras', 'eliminar carreras'],
            ],
            'Modulo Ingresos y Admision' => [
                'Acceso general' => ['acceder modulo ingresos admision'],
                'Pagos' => ['ver pagos', 'observar pagos', 'rechazar pagos', 'anular pagos'],
                'Importaciones' => ['ver importaciones de pagos', 'importar pagos', 'descargar archivos de pagos', 'ver detalles de importacion', 'reprocesar pagos observados'],
                'Codigos externos' => ['gestionar codigos externos de pago'],
            ],
        ];
    @endphp

    <div class="rounded-xl bg-white p-6 shadow-sm">
        <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <div>
                <h1 class="text-2xl font-bold">{{ $role->name }}</h1>
                <p class="mt-1 text-sm text-slate-500">Permisos permanentes asignados por rol.</p>
            </div>
            <a href="{{ route('personal.roles.edit', $role) }}" class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Modificar permisos</a>
        </div>

        <div class="mt-6 space-y-4 rounded-xl border border-slate-200 bg-slate-50 p-4">
            @foreach ($groups as $moduleName => $sections)
                <section class="rounded-lg bg-white p-4 shadow-sm">
                    <h2 class="font-bold text-slate-900">{{ $moduleName }}</h2>
                    <div class="mt-4 space-y-4">
                        @foreach ($sections as $sectionName => $permissionNames)
                            <div class="rounded-lg border border-slate-100 p-3">
                                <h3 class="text-sm font-bold text-blue-800">{{ $sectionName }}</h3>
                                <div class="mt-3 grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
                                    @foreach ($permissionNames as $permissionName)
                                        <label class="flex items-center gap-2 text-sm text-slate-700">
                                            <input type="checkbox" @checked(in_array($permissionName, $selectedPermissions, true)) disabled>
                                            <span>{{ ucfirst($permissionName) }}</span>
                                        </label>
                                    @endforeach
                                </div>
                            </div>
                        @endforeach
                    </div>
                </section>
            @endforeach
        </div>

        <a href="{{ route('personal.roles.index') }}" class="mt-6 inline-block rounded-lg border px-4 py-2">Volver</a>
    </div>
@endsection
