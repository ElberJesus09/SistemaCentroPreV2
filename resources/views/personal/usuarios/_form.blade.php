@include('personal.partials.errors')

@csrf
@isset($usuario)
    @method('PUT')
@endisset

<div class="grid gap-5 md:grid-cols-2">
    <div>
        <label class="block text-sm font-medium">Nombre</label>
        <input name="name" value="{{ old('name', $usuario->name ?? '') }}" class="mt-1 w-full rounded border-gray-300">
    </div>
    <div>
        <label class="block text-sm font-medium">Correo</label>
        <input name="email" type="email" value="{{ old('email', $usuario->email ?? '') }}" class="mt-1 w-full rounded border-gray-300">
    </div>
    <div>
        <label class="block text-sm font-medium">Contrasena</label>
        <input name="password" type="password" class="mt-1 w-full rounded border-gray-300">
    </div>
    <div>
        <label class="block text-sm font-medium">Confirmar contrasena</label>
        <input name="password_confirmation" type="password" class="mt-1 w-full rounded border-gray-300">
    </div>
    <div>
        <label class="block text-sm font-medium">Estado</label>
        <select name="estado" class="mt-1 w-full rounded border-gray-300">
            <option value="1" @selected(old('estado', $usuario->estado ?? true) == true)>Activo</option>
            <option value="0" @selected(old('estado', $usuario->estado ?? true) == false)>Inactivo</option>
        </select>
    </div>
</div>

<div class="mt-6">
    <div>
        <h2 class="font-semibold">Roles</h2>
        <p class="mt-1 text-sm text-slate-500">Los accesos permanentes se controlan por rol. Los permisos excepcionales se asignan temporalmente desde el detalle del usuario.</p>
        <div class="mt-3 grid gap-2 sm:grid-cols-2 lg:grid-cols-4">
            @foreach ($roles as $role)
                <label class="flex items-center gap-2 text-sm">
                    <input type="checkbox" name="roles[]" value="{{ $role->name }}" @checked(in_array($role->name, old('roles', isset($usuario) ? $usuario->roles->pluck('name')->all() : []), true))>
                    {{ $role->name }}
                </label>
            @endforeach
        </div>
    </div>
</div>

<div class="mt-6 flex gap-3">
    <button class="rounded bg-blue-700 px-4 py-2 text-white hover:bg-blue-800">Guardar</button>
    <a href="{{ route('personal.usuarios.index') }}" class="rounded border px-4 py-2 text-gray-700 hover:bg-gray-100">Cancelar</a>
</div>
