@include('personal.partials.errors')

<div class="grid gap-4 md:grid-cols-2">
    <div>
        <label class="block text-sm font-semibold">Codigo</label>
        <input name="codigo" value="{{ old('codigo', $turno->codigo) }}" class="mt-1 w-full" placeholder="MANANA">
    </div>
    <div>
        <label class="block text-sm font-semibold">Nombre</label>
        <input name="nombre" value="{{ old('nombre', $turno->nombre) }}" class="mt-1 w-full" placeholder="Mañana">
    </div>
    <div>
        <label class="block text-sm font-semibold">Hora inicio</label>
        <input type="time" name="hora_inicio" value="{{ old('hora_inicio', $turno->hora_inicio?->format('H:i')) }}" class="mt-1 w-full">
    </div>
    <div>
        <label class="block text-sm font-semibold">Hora fin</label>
        <input type="time" name="hora_fin" value="{{ old('hora_fin', $turno->hora_fin?->format('H:i')) }}" class="mt-1 w-full">
    </div>
    <div>
        <label class="block text-sm font-semibold">Estado</label>
        <select name="estado" class="mt-1 w-full">
            <option value="1" @selected(old('estado', $turno->estado ?? true))>Activo</option>
            <option value="0" @selected(! old('estado', $turno->estado ?? true))>Inactivo</option>
        </select>
    </div>
</div>

<div class="mt-6 flex gap-3">
    <button class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">{{ $submit }}</button>
    <a href="{{ route('ingresos-admision.turnos.index') }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Cancelar</a>
</div>
