@extends('layouts.app')

@section('title', 'Editar alumno')

@section('content')
    @php
        $locations = config('peru_locations', []);
    @endphp

    <form method="POST" action="{{ route('ingresos-admision.alumnos.update', $alumno) }}" class="space-y-6">
        @csrf
        @method('PUT')
        @include('personal.partials.errors')

        <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <div>
                <h1 class="text-2xl font-black text-slate-950">Editar alumno</h1>
                <p class="mt-1 text-sm text-slate-500">{{ $alumno->nombreCompleto() }}</p>
            </div>
            <div class="flex gap-2">
                <a href="{{ route('ingresos-admision.alumnos.show', $alumno) }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Ver ficha</a>
                <a href="{{ route('ingresos-admision.alumnos.index') }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Volver</a>
            </div>
        </div>

        <section class="rounded-xl bg-white p-6 shadow-sm">
            <h2 class="text-lg font-black text-slate-950">Datos personales</h2>
            <div class="mt-4 grid gap-4 md:grid-cols-3">
                <div>
                    <label class="block text-sm font-semibold">Tipo documento</label>
                    <select name="tipo_documento_id" class="mt-1 w-full">
                        <option value="">Seleccione</option>
                        @foreach ($tiposDocumento as $tipo)
                            <option value="{{ $tipo->id }}" @selected(old('tipo_documento_id', $alumno->tipo_documento_id) == $tipo->id)>{{ $tipo->nombre }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Numero documento</label>
                    <input name="numero_documento" value="{{ old('numero_documento', $alumno->numero_documento) }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Fecha de nacimiento</label>
                    <input type="date" name="fecha_nacimiento" value="{{ old('fecha_nacimiento', $alumno->fecha_nacimiento?->format('Y-m-d')) }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Nombres</label>
                    <input name="nombres" value="{{ old('nombres', $alumno->nombres) }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Apellido paterno</label>
                    <input name="apellido_paterno" value="{{ old('apellido_paterno', $alumno->apellido_paterno) }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Apellido materno</label>
                    <input name="apellido_materno" value="{{ old('apellido_materno', $alumno->apellido_materno) }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Genero</label>
                    <select name="genero" class="mt-1 w-full">
                        <option value="">Seleccione</option>
                        <option value="masculino" @selected(old('genero', $alumno->genero) === 'masculino')>Masculino</option>
                        <option value="femenino" @selected(old('genero', $alumno->genero) === 'femenino')>Femenino</option>
                        <option value="otro" @selected(old('genero', $alumno->genero) === 'otro')>Otro</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Celular</label>
                    <input name="telefono" value="{{ old('telefono', $alumno->telefono) }}" class="mt-1 w-full" placeholder="9 digitos">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Correo</label>
                    <input type="email" name="correo" value="{{ old('correo', $alumno->correo) }}" class="mt-1 w-full">
                </div>
            </div>

            <div class="mt-4 grid gap-4 border-t border-slate-100 pt-4 md:grid-cols-3" data-peru-address data-locations='@json($locations)'>
                <div>
                    <label class="block text-sm font-semibold">Departamento</label>
                    <select name="departamento" class="mt-1 w-full" data-address-department data-selected="{{ old('departamento', $alumno->departamento) }}">
                        <option value="">Seleccione</option>
                        @foreach ($locations as $department => $provinces)
                            <option value="{{ $department }}" @selected(old('departamento', $alumno->departamento) === $department)>{{ $department }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Provincia</label>
                    <select name="provincia" class="mt-1 w-full" data-address-province data-selected="{{ old('provincia', $alumno->provincia) }}">
                        <option value="">Seleccione</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Distrito</label>
                    <select name="distrito" class="mt-1 w-full" data-address-district data-selected="{{ old('distrito', $alumno->distrito) }}">
                        <option value="">Seleccione</option>
                    </select>
                </div>
                <div class="md:col-span-3">
                    <label class="block text-sm font-semibold">Calle, jiron, avenida o referencia</label>
                    <input name="direccion" value="{{ old('direccion', $alumno->direccion) }}" class="mt-1 w-full">
                </div>
            </div>
        </section>

        <section class="rounded-xl bg-white p-6 shadow-sm">
            <h2 class="text-lg font-black text-slate-950">Apoderado</h2>
            <p class="mt-1 text-sm text-slate-500">Puedes actualizar el apoderado principal o dejarlo vacío si no corresponde.</p>
            <div class="mt-4 grid gap-4 md:grid-cols-3">
                <div>
                    <label class="block text-sm font-semibold">Tipo documento</label>
                    <select name="apoderado_tipo_documento_id" class="mt-1 w-full">
                        <option value="">Seleccione</option>
                        @foreach ($tiposDocumento as $tipo)
                            <option value="{{ $tipo->id }}" @selected(old('apoderado_tipo_documento_id', $apoderado?->tipo_documento_id) == $tipo->id)>{{ $tipo->nombre }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Número documento</label>
                    <input name="apoderado_numero_documento" value="{{ old('apoderado_numero_documento', $apoderado?->numero_documento) }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Parentesco</label>
                    <select name="parentesco" class="mt-1 w-full">
                        <option value="">Seleccione</option>
                        @foreach (['padre' => 'Padre', 'madre' => 'Madre', 'tio' => 'Tío', 'tia' => 'Tía', 'hermano' => 'Hermano', 'hermana' => 'Hermana', 'tutor' => 'Tutor', 'otro' => 'Otro'] as $value => $label)
                            <option value="{{ $value }}" @selected(old('parentesco', $apoderado?->pivot?->parentesco) === $value)>{{ $label }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Nombres</label>
                    <input name="apoderado_nombres" value="{{ old('apoderado_nombres', $apoderado?->nombres) }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Apellido paterno</label>
                    <input name="apoderado_apellido_paterno" value="{{ old('apoderado_apellido_paterno', $apoderado?->apellido_paterno) }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Apellido materno</label>
                    <input name="apoderado_apellido_materno" value="{{ old('apoderado_apellido_materno', $apoderado?->apellido_materno) }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Teléfono</label>
                    <input name="apoderado_telefono" value="{{ old('apoderado_telefono', $apoderado?->telefono) }}" class="mt-1 w-full" placeholder="9 dígitos">
                </div>
            </div>
        </section>

        <section class="rounded-xl bg-white p-6 shadow-sm">
            <h2 class="text-lg font-black text-slate-950">Colegio de procedencia</h2>
            <div class="mt-4 grid gap-4 md:grid-cols-2" data-peru-address data-locations='@json($locations)'>
                <div>
                    <label class="block text-sm font-semibold">Nombre del colegio</label>
                    <input name="colegio_nombre" value="{{ old('colegio_nombre', $colegio?->nombre) }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Año de egreso</label>
                    <input type="number" name="anio_egreso" value="{{ old('anio_egreso', $colegio?->pivot?->anio_egreso) }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Departamento</label>
                    <select name="colegio_departamento" class="mt-1 w-full" data-address-department data-selected="{{ old('colegio_departamento', $colegio?->departamento) }}">
                        <option value="">Seleccione</option>
                        @foreach ($locations as $department => $provinces)
                            <option value="{{ $department }}" @selected(old('colegio_departamento', $colegio?->departamento) === $department)>{{ $department }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Provincia</label>
                    <select name="colegio_provincia" class="mt-1 w-full" data-address-province data-selected="{{ old('colegio_provincia', $colegio?->provincia) }}">
                        <option value="">Seleccione</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Distrito</label>
                    <select name="colegio_distrito" class="mt-1 w-full" data-address-district data-selected="{{ old('colegio_distrito', $colegio?->distrito) }}">
                        <option value="">Seleccione</option>
                    </select>
                </div>
            </div>
        </section>

        <div class="flex justify-end gap-3">
            <a href="{{ route('ingresos-admision.alumnos.show', $alumno) }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Cancelar</a>
            <button class="rounded-lg bg-blue-700 px-5 py-2 text-sm font-bold text-white hover:bg-blue-800">Guardar cambios</button>
        </div>
    </form>
@endsection
