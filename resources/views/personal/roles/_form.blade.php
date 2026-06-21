@include('personal.partials.errors')

@csrf
@isset($role)
    @method('PUT')
@endisset

<div>
    <label class="block text-sm font-medium">Nombre del rol</label>
    <input name="name" value="{{ old('name', $role->name ?? '') }}" class="mt-1 w-full rounded border-gray-300">
</div>

<div class="mt-6">
    <h2 class="font-semibold">Permisos del rol</h2>
    <p class="mt-1 text-sm text-slate-500">Marca los accesos que tendra este rol. Los permisos se crean por seeder y aqui solo se asignan al rol.</p>

    @php
        $selectedPermissions = old('permissions', isset($role) ? $role->permissions->pluck('name')->all() : []);
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
                'Importaciones' => ['ver importaciones de pagos', 'importar pagos', 'descargar archivos de pagos', 'ver detalles de importacion', 'reprocesar pagos observados'],
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
            'ver importaciones de pagos' => 'Ver importaciones',
            'ver detalles de importacion' => 'Ver detalles de importación',
            'reprocesar pagos observados' => 'Reprocesar pagos observados',
            'descargar archivos de pagos' => 'Descargar archivos de pagos',
            'asociar pagos' => 'Asociar pagos',
        ];
    @endphp

    <div class="mt-4 space-y-4 rounded-xl border border-slate-200 bg-slate-50 p-4">
        @foreach ($groups as $moduleName => $sections)
            <section class="rounded-lg bg-white p-4 shadow-sm">
                <h3 class="font-bold text-slate-900">{{ $moduleName }}</h3>
                <div class="mt-4 space-y-4">
                    @foreach ($sections as $sectionName => $permissionNames)
                        <div class="rounded-lg border border-slate-100 p-3">
                            <h4 class="text-sm font-bold text-blue-800">{{ $sectionName }}</h4>
                            <div class="mt-3 grid gap-2 sm:grid-cols-2 xl:grid-cols-3">
                                @foreach ($permissionNames as $permissionName)
                                    @if ($permissions->firstWhere('name', $permissionName))
                                        <label class="flex min-h-11 cursor-pointer items-center gap-3 rounded-lg border border-slate-200 bg-white px-3 py-2 text-sm font-semibold text-slate-700 transition hover:border-blue-200 hover:bg-blue-50">
                                            <input class="h-4 w-4 shrink-0 accent-blue-700" type="checkbox" name="permissions[]" value="{{ $permissionName }}" @checked(in_array($permissionName, $selectedPermissions, true))>
                                            <span class="leading-snug">{{ $permissionLabels[$permissionName] ?? ucfirst($permissionName) }}</span>
                                        </label>
                                    @endif
                                @endforeach
                            </div>
                        </div>
                    @endforeach
                </div>
            </section>
        @endforeach
    </div>
</div>

<div class="mt-6 flex gap-3">
    <button class="rounded bg-blue-700 px-4 py-2 text-white hover:bg-blue-800">Guardar</button>
    <a href="{{ route('personal.roles.index') }}" class="rounded border px-4 py-2 text-gray-700 hover:bg-gray-100">Cancelar</a>
</div>
