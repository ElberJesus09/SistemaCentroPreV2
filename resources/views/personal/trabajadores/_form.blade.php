@include('personal.partials.errors')

@csrf
@isset($trabajador)
    @method('PUT')
@endisset

<div class="grid gap-5 md:grid-cols-2">
    <div>
        <label class="block text-sm font-medium">Tipo de documento</label>
        <select name="tipo_documento_id" class="mt-1 w-full rounded border-gray-300">
            <option value="">Seleccione</option>
            @foreach ($tiposDocumento as $tipoDocumento)
                <option value="{{ $tipoDocumento->id }}" @selected(old('tipo_documento_id', $trabajador->tipo_documento_id ?? '') == $tipoDocumento->id)>
                    {{ $tipoDocumento->nombre }} ({{ $tipoDocumento->codigo }})
                </option>
            @endforeach
        </select>
    </div>
    <div>
        <label class="block text-sm font-medium">Numero de documento</label>
        <input name="numero_documento" value="{{ old('numero_documento', $trabajador->numero_documento ?? '') }}" class="mt-1 w-full rounded border-gray-300">
    </div>
    <div>
        <label class="block text-sm font-medium">Nombres</label>
        <input name="nombres" value="{{ old('nombres', $trabajador->nombres ?? '') }}" class="mt-1 w-full rounded border-gray-300">
    </div>
    <div>
        <label class="block text-sm font-medium">Apellidos</label>
        <input name="apellidos" value="{{ old('apellidos', $trabajador->apellidos ?? '') }}" class="mt-1 w-full rounded border-gray-300">
    </div>
    <div>
        <label class="block text-sm font-medium">Telefono</label>
        <input name="telefono" value="{{ old('telefono', $trabajador->telefono ?? '') }}" placeholder="987654321" class="mt-1 w-full rounded border-gray-300">
    </div>
    <div>
        <label class="block text-sm font-medium">Correo</label>
        <input name="correo" type="email" value="{{ old('correo', $trabajador->correo ?? '') }}" class="mt-1 w-full rounded border-gray-300">
    </div>
    <div>
        <label class="block text-sm font-medium">Sede</label>
        <select name="sede_id" class="mt-1 w-full rounded border-gray-300">
            <option value="">Sin sede</option>
            @foreach ($sedes as $sede)
                <option value="{{ $sede->id }}" @selected(old('sede_id', $trabajador->sede_id ?? '') == $sede->id)>{{ $sede->nombre }}</option>
            @endforeach
        </select>
    </div>
    <div>
        <label class="block text-sm font-medium">Usuario asociado</label>
        <select name="user_id" class="mt-1 w-full rounded border-gray-300">
            <option value="">Sin usuario</option>
            @foreach ($usuarios as $usuario)
                <option value="{{ $usuario->id }}" @selected(old('user_id', $trabajador->user_id ?? '') == $usuario->id)>{{ $usuario->name }} - {{ $usuario->email }}</option>
            @endforeach
        </select>
    </div>
    <div class="md:col-span-2">
        <label class="block text-sm font-medium">Direccion</label>
        <input name="direccion" value="{{ old('direccion', $trabajador->direccion ?? '') }}" class="mt-1 w-full rounded border-gray-300">
    </div>
    <div>
        <label class="block text-sm font-medium">Estado</label>
        <select name="estado" class="mt-1 w-full rounded border-gray-300">
            <option value="1" @selected(old('estado', $trabajador->estado ?? true) == true)>Activo</option>
            <option value="0" @selected(old('estado', $trabajador->estado ?? true) == false)>Inactivo</option>
        </select>
    </div>
</div>

<div class="mt-6 flex gap-3">
    <button class="rounded bg-blue-700 px-4 py-2 text-white hover:bg-blue-800">Guardar</button>
    <a href="{{ route('personal.trabajadores.index') }}" class="rounded border px-4 py-2 text-gray-700 hover:bg-gray-100">Cancelar</a>
</div>
