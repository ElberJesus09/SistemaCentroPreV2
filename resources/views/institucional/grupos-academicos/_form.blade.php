@include('personal.partials.errors')
@csrf
@isset($grupoAcademico) @method('PUT') @endisset
<div class="grid gap-5 md:grid-cols-2">
    <div><label class="block text-sm font-semibold">Codigo</label><input name="codigo" value="{{ old('codigo', $grupoAcademico->codigo ?? '') }}" class="mt-1 w-full"></div>
    <div><label class="block text-sm font-semibold">Nombre</label><input name="nombre" value="{{ old('nombre', $grupoAcademico->nombre ?? '') }}" class="mt-1 w-full"></div>
    <div class="md:col-span-2"><label class="block text-sm font-semibold">Descripcion</label><textarea name="descripcion" class="mt-1 w-full">{{ old('descripcion', $grupoAcademico->descripcion ?? '') }}</textarea></div>
    <div><label class="block text-sm font-semibold">Estado</label><select name="estado" class="mt-1 w-full"><option value="1" @selected(old('estado', $grupoAcademico->estado ?? true) == 1)>Activo</option><option value="0" @selected(old('estado', $grupoAcademico->estado ?? true) == 0)>Inactivo</option></select></div>
</div>
<div class="mt-6 flex gap-3"><button class="rounded-lg bg-blue-700 px-4 py-2 font-bold text-white">Guardar</button><a href="{{ route('institucional.grupos-academicos.index') }}" class="rounded-lg border px-4 py-2">Cancelar</a></div>
