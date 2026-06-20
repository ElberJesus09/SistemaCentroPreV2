@extends('layouts.app')

@section('title', 'Detalle usuario')

@section('content')
    @include('personal.partials.errors')

    <div class="rounded-xl bg-white p-6 shadow-sm">
        <h1 class="text-2xl font-bold">{{ $usuario->name }}</h1>
        <dl class="mt-6 grid gap-4 md:grid-cols-2">
            <div><dt class="text-sm font-semibold">Correo</dt><dd>{{ $usuario->email }}</dd></div>
            <div><dt class="text-sm font-semibold">Estado</dt><dd>{{ $usuario->estado ? 'Activo' : 'Inactivo' }}</dd></div>
            <div><dt class="text-sm font-semibold">Roles</dt><dd>{{ $usuario->roles->pluck('name')->join(', ') ?: 'Sin roles' }}</dd></div>
            <div><dt class="text-sm font-semibold">Trabajador asociado</dt><dd>{{ $usuario->trabajador?->nombres ? $usuario->trabajador->nombres.' '.$usuario->trabajador->apellidos : 'Sin trabajador asociado' }}</dd></div>
        </dl>
        <a href="{{ route('personal.usuarios.index') }}" class="mt-6 inline-block rounded-lg border px-4 py-2">Volver</a>
    </div>

    <div class="mt-6 grid gap-6 lg:grid-cols-[0.9fr_1.1fr]">
        @can('asignar permisos')
            <section class="rounded-xl bg-white p-6 shadow-sm">
                <h2 class="text-lg font-bold">Asignar permiso temporal</h2>
                <p class="mt-1 text-sm text-slate-500">Usalo para casos puntuales: por ejemplo, dar a Juan un permiso especifico hasta una fecha concreta.</p>

                <form action="{{ route('personal.usuarios.permisos-temporales.store', $usuario) }}" method="POST" class="mt-5 space-y-4">
                    @csrf
                    <div>
                        <label class="block text-sm font-semibold">Permiso</label>
                        <select name="permission_id" class="mt-1 w-full">
                            <option value="">Seleccione</option>
                            @foreach ($permissions as $permission)
                                <option value="{{ $permission->id }}" @selected(old('permission_id') == $permission->id)>{{ $permission->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-semibold">Vence el</label>
                        <input name="expires_at" type="datetime-local" value="{{ old('expires_at') }}" class="mt-1 w-full">
                    </div>
                    <div>
                        <label class="block text-sm font-semibold">Motivo</label>
                        <input name="reason" value="{{ old('reason') }}" class="mt-1 w-full" placeholder="Ej. apoyo temporal en registro">
                    </div>
                    <button class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Asignar temporalmente</button>
                </form>
            </section>
        @endcan

        <section class="rounded-xl bg-white p-6 shadow-sm">
            <h2 class="text-lg font-bold">Permisos temporales</h2>
            <div class="mt-4 overflow-hidden rounded-lg border border-slate-200">
                <table class="w-full text-left text-sm">
                    <thead class="bg-slate-50 text-xs uppercase text-slate-500">
                        <tr>
                            <th class="px-4 py-3">Permiso</th>
                            <th class="px-4 py-3">Vence</th>
                            <th class="px-4 py-3">Estado</th>
                            <th class="px-4 py-3"></th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        @forelse ($usuario->permisosTemporales->sortByDesc('created_at') as $permisoTemporal)
                            @php
                                $activo = is_null($permisoTemporal->revoked_at) && $permisoTemporal->expires_at->isFuture();
                            @endphp
                            <tr>
                                <td class="px-4 py-3">
                                    <div class="font-semibold">{{ $permisoTemporal->permission?->name }}</div>
                                    <div class="text-xs text-slate-500">{{ $permisoTemporal->reason ?: 'Sin motivo registrado' }}</div>
                                </td>
                                <td class="px-4 py-3">{{ $permisoTemporal->expires_at->format('d/m/Y H:i') }}</td>
                                <td class="px-4 py-3">{{ $activo ? 'Activo' : 'Vencido o revocado' }}</td>
                                <td class="px-4 py-3 text-right">
                                    @if ($activo)
                                        <form action="{{ route('personal.usuarios.permisos-temporales.destroy', [$usuario, $permisoTemporal]) }}" method="POST" data-confirm-title="Revocar permiso temporal" data-confirm="¿Estas seguro de revocar este permiso temporal? El usuario perdera este acceso inmediatamente.">
                                            @csrf
                                            @method('DELETE')
                                            <button class="text-red-700 hover:underline">Revocar</button>
                                        </form>
                                    @endif
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="px-4 py-8 text-center text-slate-500">No hay permisos temporales registrados.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </section>
    </div>
@endsection
