@extends('layouts.app')

@section('title', 'Detalle rol')

@section('content')
    @php
        $selectedPermissions = $role->permissions->pluck('name')->all();
        $groups = [
            'Modulo Personal' => ['acceder modulo personal'],
            'Trabajadores' => ['ver trabajadores', 'crear trabajadores', 'editar trabajadores', 'eliminar trabajadores'],
            'Usuarios' => ['ver usuarios', 'crear usuarios', 'editar usuarios', 'eliminar usuarios', 'asignar roles', 'asignar permisos'],
            'Roles' => ['ver roles', 'crear roles', 'editar roles', 'eliminar roles'],
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
            @foreach ($groups as $groupName => $permissionNames)
                <section class="rounded-lg bg-white p-4 shadow-sm">
                    <h2 class="font-bold text-slate-900">{{ $groupName }}</h2>
                    <div class="mt-3 grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
                        @foreach ($permissionNames as $permissionName)
                            <label class="flex items-center gap-2 text-sm text-slate-700">
                                <input type="checkbox" @checked(in_array($permissionName, $selectedPermissions, true)) disabled>
                                <span>{{ ucfirst($permissionName) }}</span>
                            </label>
                        @endforeach
                    </div>
                </section>
            @endforeach
        </div>

        <a href="{{ route('personal.roles.index') }}" class="mt-6 inline-block rounded-lg border px-4 py-2">Volver</a>
    </div>
@endsection
