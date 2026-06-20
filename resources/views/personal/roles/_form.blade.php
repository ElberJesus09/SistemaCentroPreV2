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
    <p class="mt-1 text-sm text-slate-500">Marca los accesos que tendra este rol dentro del modulo Personal.</p>

    @php
        $selectedPermissions = old('permissions', isset($role) ? $role->permissions->pluck('name')->all() : []);
        $groups = [
            'Modulo Personal' => ['acceder modulo personal'],
            'Trabajadores' => ['ver trabajadores', 'crear trabajadores', 'editar trabajadores', 'eliminar trabajadores'],
            'Usuarios' => ['ver usuarios', 'crear usuarios', 'editar usuarios', 'eliminar usuarios', 'asignar roles', 'asignar permisos'],
            'Roles' => ['ver roles', 'crear roles', 'editar roles', 'eliminar roles'],
        ];
    @endphp

    <div class="mt-4 space-y-4 rounded-xl border border-slate-200 bg-slate-50 p-4">
        @foreach ($groups as $groupName => $permissionNames)
            <section class="rounded-lg bg-white p-4 shadow-sm">
                <h3 class="font-bold text-slate-900">{{ $groupName }}</h3>
                <div class="mt-3 grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
                    @foreach ($permissionNames as $permissionName)
                        @if ($permissions->firstWhere('name', $permissionName))
                            <label class="flex items-center gap-2 text-sm">
                                <input type="checkbox" name="permissions[]" value="{{ $permissionName }}" @checked(in_array($permissionName, $selectedPermissions, true))>
                                <span>{{ ucfirst($permissionName) }}</span>
                            </label>
                        @endif
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
