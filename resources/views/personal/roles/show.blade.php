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
                'Pagos' => ['ver pagos', 'asociar pagos', 'observar pagos', 'rechazar pagos', 'anular pagos'],
                'Codigos externos' => ['gestionar codigos externos de pago'],
                'Ciclos academicos' => ['ver ciclos academicos', 'gestionar ciclos academicos'],
                'Turnos' => ['ver turnos', 'gestionar turnos'],
                'Ofertas academicas' => ['ver ofertas academicas', 'gestionar ofertas academicas'],
                'Alumnos' => ['ver alumnos', 'crear alumnos', 'editar alumnos', 'desactivar alumnos', 'enviar correos alumnos', 'registrar alumnos sin pagos'],
                'Inscripciones' => ['ver inscripciones', 'crear inscripciones'],
                'Matriculas' => ['ver matriculas', 'crear matriculas'],
            ],
        ];
        $permissionLabels = [
            'acceder dashboard' => 'Acceder al dashboard',
            'acceder modulo personal' => 'Acceder al módulo personal',
            'acceder modulo institucional' => 'Acceder al módulo institucional',
            'acceder modulo ingresos admision' => 'Acceder al módulo ingresos y admisión',
            'gestionar codigos externos de pago' => 'Gestionar códigos externos',
            'ver ciclos academicos' => 'Ver ciclos académicos',
            'gestionar ciclos academicos' => 'Gestionar ciclos académicos',
            'ver ofertas academicas' => 'Ver ofertas académicas',
            'gestionar ofertas academicas' => 'Gestionar ofertas académicas',
            'enviar correos alumnos' => 'Enviar correos a alumnos',
            'registrar alumnos sin pagos' => 'Registrar alumnos sin pagos',
            'asociar pagos' => 'Asociar pagos',
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
                                <div class="mt-3 grid gap-2 sm:grid-cols-2 xl:grid-cols-3">
                                    @foreach ($permissionNames as $permissionName)
                                        <label @class([
                                            'flex min-h-11 items-center gap-3 rounded-lg border px-3 py-2 text-sm font-semibold',
                                            'border-blue-200 bg-blue-50 text-blue-800' => in_array($permissionName, $selectedPermissions, true),
                                            'border-slate-200 bg-white text-slate-400' => ! in_array($permissionName, $selectedPermissions, true),
                                        ])>
                                            <input class="h-4 w-4 shrink-0 accent-blue-700" type="checkbox" @checked(in_array($permissionName, $selectedPermissions, true)) disabled>
                                            <span class="leading-snug">{{ $permissionLabels[$permissionName] ?? ucfirst($permissionName) }}</span>
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
