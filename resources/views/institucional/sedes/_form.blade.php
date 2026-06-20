@include('personal.partials.errors')
@csrf
@isset($sede) @method('PUT') @endisset
<div class="grid gap-5 md:grid-cols-2">
    <div><label class="block text-sm font-semibold">Nombre</label><input name="nombre" value="{{ old('nombre', $sede->nombre ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Tipo</label><select name="tipo" class="mt-1 w-full">@foreach(['principal'=>'Principal','secundaria'=>'Secundaria','subsede'=>'Subsede'] as $value=>$label)<option value="{{ $value }}" @selected(old('tipo', $sede->tipo ?? 'principal') === $value)>{{ $label }}</option>@endforeach</select></div>
    <div class="md:col-span-2"><label class="block text-sm font-semibold">Direccion</label><input name="direccion" value="{{ old('direccion', $sede->direccion ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Distrito</label><input name="distrito" value="{{ old('distrito', $sede->distrito ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Provincia</label><input name="provincia" value="{{ old('provincia', $sede->provincia ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Departamento</label><input name="departamento" value="{{ old('departamento', $sede->departamento ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Pais</label><input name="pais" value="{{ old('pais', $sede->pais ?? 'Peru') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Correo</label><input name="correo" type="email" value="{{ old('correo', $sede->correo ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Telefono</label><input name="telefono" value="{{ old('telefono', $sede->telefono ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Horario</label><input name="horario" value="{{ old('horario', $sede->horario ?? '') }}" class="mt-1 w-full"></div>
    <div class="md:col-span-2"><label class="block text-sm font-semibold">Mapa URL</label><input name="mapa_url" value="{{ old('mapa_url', $sede->mapa_url ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Sede principal</label><select name="es_principal" class="mt-1 w-full"><option value="1" @selected(old('es_principal', $sede->es_principal ?? false) == 1)>Si</option><option value="0" @selected(old('es_principal', $sede->es_principal ?? false) == 0)>No</option></select></div>
    <div><label class="block text-sm font-semibold">Acceso al sistema</label><select name="permite_acceso_sistema" class="mt-1 w-full"><option value="1" @selected(old('permite_acceso_sistema', $sede->permite_acceso_sistema ?? true) == 1)>Si</option><option value="0" @selected(old('permite_acceso_sistema', $sede->permite_acceso_sistema ?? true) == 0)>No</option></select></div>
    <div><label class="block text-sm font-semibold">Estado</label><select name="estado" class="mt-1 w-full"><option value="1" @selected(old('estado', $sede->estado ?? true) == 1)>Activo</option><option value="0" @selected(old('estado', $sede->estado ?? true) == 0)>Inactivo</option></select></div>
</div>
<div class="mt-6 flex gap-3"><button class="rounded-lg bg-blue-700 px-4 py-2 font-bold text-white hover:bg-blue-800">Guardar</button><a href="{{ route('institucional.sedes.index') }}" class="rounded-lg border px-4 py-2">Cancelar</a></div>
