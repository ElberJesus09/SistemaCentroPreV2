@include('personal.partials.errors')

<div class="grid gap-4 md:grid-cols-2">
    <div>
        <label class="block text-sm font-semibold">Codigo</label>
        <input name="codigo" value="{{ old('codigo', $ciclo->codigo) }}" class="mt-1 w-full" placeholder="2026-I">
    </div>
    <div>
        <label class="block text-sm font-semibold">Nombre</label>
        <input name="nombre" value="{{ old('nombre', $ciclo->nombre) }}" class="mt-1 w-full" placeholder="Ciclo 2026-I">
    </div>
    <div>
        <label class="block text-sm font-semibold">Fecha inicio</label>
        <input type="date" name="fecha_inicio" value="{{ old('fecha_inicio', $ciclo->fecha_inicio?->toDateString()) }}" class="mt-1 w-full">
    </div>
    <div>
        <label class="block text-sm font-semibold">Fecha fin</label>
        <input type="date" name="fecha_fin" value="{{ old('fecha_fin', $ciclo->fecha_fin?->toDateString()) }}" class="mt-1 w-full">
    </div>
    <div>
        <label class="block text-sm font-semibold">Inicio inscripcion</label>
        <input type="date" name="fecha_inicio_inscripcion" value="{{ old('fecha_inicio_inscripcion', $ciclo->fecha_inicio_inscripcion?->toDateString()) }}" class="mt-1 w-full">
    </div>
    <div>
        <label class="block text-sm font-semibold">Fin inscripcion</label>
        <input type="date" name="fecha_fin_inscripcion" value="{{ old('fecha_fin_inscripcion', $ciclo->fecha_fin_inscripcion?->toDateString()) }}" class="mt-1 w-full">
    </div>
    <div>
        <label class="block text-sm font-semibold">Estado</label>
        <select name="estado" class="mt-1 w-full">
            <option value="1" @selected(old('estado', $ciclo->estado ?? true))>Activo</option>
            <option value="0" @selected(! old('estado', $ciclo->estado ?? true))>Inactivo</option>
        </select>
    </div>
</div>

<div class="mt-6 flex gap-3">
    <button class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">{{ $submit }}</button>
    <a href="{{ route('ingresos-admision.ciclos.index') }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Cancelar</a>
</div>
