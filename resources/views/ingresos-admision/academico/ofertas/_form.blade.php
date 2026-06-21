@include('personal.partials.errors')

<div class="grid gap-4 md:grid-cols-3">
    <div>
        <label class="block text-sm font-semibold">Ciclo</label>
        <select name="ciclo_academico_id" class="mt-1 w-full">
            <option value="">Seleccione</option>
            @foreach ($ciclos as $ciclo)
                <option value="{{ $ciclo->id }}" @selected(old('ciclo_academico_id', $oferta->ciclo_academico_id) == $ciclo->id)>
                    {{ $ciclo->nombre }}
                </option>
            @endforeach
        </select>
    </div>
    <div>
        <label class="block text-sm font-semibold">Sede</label>
        <select name="sede_id" class="mt-1 w-full">
            <option value="">Seleccione</option>
            @foreach ($sedes as $sede)
                <option value="{{ $sede->id }}" @selected(old('sede_id', $oferta->sede_id) == $sede->id)>
                    {{ $sede->nombre }}
                </option>
            @endforeach
        </select>
    </div>
    <div>
        <label class="block text-sm font-semibold">Turno</label>
        <select name="turno_id" class="mt-1 w-full">
            <option value="">Seleccione</option>
            @foreach ($turnos as $turno)
                <option value="{{ $turno->id }}" @selected(old('turno_id', $oferta->turno_id) == $turno->id)>
                    {{ $turno->nombre }}
                </option>
            @endforeach
        </select>
    </div>
    <div>
        <label class="block text-sm font-semibold">Capacidad</label>
        <input type="number" min="1" name="capacidad" value="{{ old('capacidad', $oferta->capacidad) }}" class="mt-1 w-full">
    </div>
    <div>
        <label class="block text-sm font-semibold">Costo matricula</label>
        <input type="number" step="0.01" min="0" name="costo_matricula" value="{{ old('costo_matricula', $oferta->costo_matricula) }}" class="mt-1 w-full">
    </div>
    <div>
        <label class="block text-sm font-semibold">Costo pension</label>
        <input type="number" step="0.01" min="0" name="costo_pension" value="{{ old('costo_pension', $oferta->costo_pension) }}" class="mt-1 w-full">
    </div>
    <div>
        <label class="block text-sm font-semibold">Inicio inscripcion</label>
        <input type="date" name="fecha_inicio_inscripcion" value="{{ old('fecha_inicio_inscripcion', $oferta->fecha_inicio_inscripcion?->toDateString()) }}" class="mt-1 w-full">
    </div>
    <div>
        <label class="block text-sm font-semibold">Fin inscripcion</label>
        <input type="date" name="fecha_fin_inscripcion" value="{{ old('fecha_fin_inscripcion', $oferta->fecha_fin_inscripcion?->toDateString()) }}" class="mt-1 w-full">
    </div>
    <div>
        <label class="block text-sm font-semibold">Estado</label>
        <select name="estado" class="mt-1 w-full">
            <option value="1" @selected(old('estado', $oferta->estado ?? true))>Activa</option>
            <option value="0" @selected(! old('estado', $oferta->estado ?? true))>Inactiva</option>
        </select>
    </div>
</div>

<div class="mt-6 flex gap-3">
    <button class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">{{ $submit }}</button>
    <a href="{{ route('ingresos-admision.ofertas.index') }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Cancelar</a>
</div>
