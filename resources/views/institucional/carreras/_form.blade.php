@include('personal.partials.errors')
@csrf
@isset($carrera) @method('PUT') @endisset
<div class="grid gap-5 md:grid-cols-2">
    <div><label class="block text-sm font-semibold">Codigo</label><input name="codigo" value="{{ old('codigo', $carrera->codigo ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Nombre</label><input name="nombre" value="{{ old('nombre', $carrera->nombre ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Grupo academico</label><select name="grupo_academico_id" class="mt-1 w-full"><option value="">Seleccione</option>@foreach($gruposAcademicos as $grupo)<option value="{{ $grupo->id }}" @selected(old('grupo_academico_id', $carrera->grupo_academico_id ?? '') == $grupo->id)>{{ $grupo->nombre }}</option>@endforeach</select></div>
    <div><label class="block text-sm font-semibold">Facultad</label><select name="facultad_id" class="mt-1 w-full"><option value="">Seleccione</option>@foreach($facultades as $facultad)<option value="{{ $facultad->id }}" @selected(old('facultad_id', $carrera->facultad_id ?? '') == $facultad->id)>{{ $facultad->sigla }} - {{ $facultad->nombre }}</option>@endforeach</select></div>
    <div class="md:col-span-2"><label class="block text-sm font-semibold">Enlace</label><input name="enlace" value="{{ old('enlace', $carrera->enlace ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Destacada</label><select name="es_destacada" class="mt-1 w-full"><option value="1" @selected(old('es_destacada', $carrera->es_destacada ?? false) == 1)>Si</option><option value="0" @selected(old('es_destacada', $carrera->es_destacada ?? false) == 0)>No</option></select></div>
    <div><label class="block text-sm font-semibold">Estado</label><select name="estado" class="mt-1 w-full"><option value="1" @selected(old('estado', $carrera->estado ?? true) == 1)>Activo</option><option value="0" @selected(old('estado', $carrera->estado ?? true) == 0)>Inactivo</option></select></div>
</div>
<div class="mt-6 flex gap-3"><button class="rounded-lg bg-blue-700 px-4 py-2 font-bold text-white">Guardar</button><a href="{{ route('institucional.carreras.index') }}" class="rounded-lg border px-4 py-2">Cancelar</a></div>
