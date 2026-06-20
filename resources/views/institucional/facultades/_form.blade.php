@include('personal.partials.errors')
@csrf
@isset($facultad) @method('PUT') @endisset
<div class="grid gap-5 md:grid-cols-2">
    <div><label class="block text-sm font-semibold">Nombre</label><input name="nombre" value="{{ old('nombre', $facultad->nombre ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Sigla</label><input name="sigla" value="{{ old('sigla', $facultad->sigla ?? '') }}" class="mt-1 w-full"></div>
    <div class="md:col-span-2"><label class="block text-sm font-semibold">Enlace</label><input name="enlace" value="{{ old('enlace', $facultad->enlace ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Estado</label><select name="estado" class="mt-1 w-full"><option value="1" @selected(old('estado', $facultad->estado ?? true) == 1)>Activo</option><option value="0" @selected(old('estado', $facultad->estado ?? true) == 0)>Inactivo</option></select></div>
</div>
<div class="mt-6 flex gap-3"><button class="rounded-lg bg-blue-700 px-4 py-2 font-bold text-white">Guardar</button><a href="{{ route('institucional.facultades.index') }}" class="rounded-lg border px-4 py-2">Cancelar</a></div>
