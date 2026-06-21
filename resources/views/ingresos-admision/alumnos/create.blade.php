@extends('layouts.app')

@section('title', 'Registrar alumno')

@section('content')
    @php
        $locations = config('peru_locations', []);
    @endphp

    <form
        method="POST"
        action="{{ route('ingresos-admision.alumnos.store') }}"
        class="space-y-6"
        data-confirm-title="Confirmar registro"
        data-confirm="Se creara el alumno, la inscripcion, la matricula y se asociaran los pagos oficiales indicados."
    >
        @csrf
        @include('personal.partials.errors')

        <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <div>
                <h1 class="text-2xl font-black text-slate-950">Registro privado de alumno</h1>
                <p class="mt-1 text-sm text-slate-500">Datos iguales al registro anterior, con tipo de documento en alumno y apoderado.</p>
            </div>
            <a href="{{ route('ingresos-admision.alumnos.index') }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Volver</a>
        </div>

        <section class="rounded-xl bg-white p-6 shadow-sm">
            <h2 class="text-lg font-black text-slate-950">Datos personales</h2>
            <div class="mt-4 grid gap-4 md:grid-cols-3">
                <div>
                    <label class="block text-sm font-semibold">Tipo documento</label>
                    <select name="tipo_documento_id" class="mt-1 w-full">
                        <option value="">Seleccione</option>
                        @foreach ($tiposDocumento as $tipo)
                            <option value="{{ $tipo->id }}" @selected(old('tipo_documento_id') == $tipo->id)>{{ $tipo->nombre }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Numero documento</label>
                    <input name="numero_documento" value="{{ old('numero_documento') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Fecha de nacimiento</label>
                    <input type="date" name="fecha_nacimiento" value="{{ old('fecha_nacimiento') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Nombres</label>
                    <input name="nombres" value="{{ old('nombres') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Apellido paterno</label>
                    <input name="apellido_paterno" value="{{ old('apellido_paterno') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Apellido materno</label>
                    <input name="apellido_materno" value="{{ old('apellido_materno') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Genero</label>
                    <select name="genero" class="mt-1 w-full">
                        <option value="">Seleccione</option>
                        <option value="masculino" @selected(old('genero') === 'masculino')>Masculino</option>
                        <option value="femenino" @selected(old('genero') === 'femenino')>Femenino</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Celular</label>
                    <input name="telefono" value="{{ old('telefono') }}" class="mt-1 w-full" placeholder="9 digitos">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Correo</label>
                    <input type="email" name="correo" value="{{ old('correo') }}" class="mt-1 w-full">
                </div>
            </div>

            <div class="mt-4 grid gap-4 border-t border-slate-100 pt-4 md:grid-cols-3" data-peru-address data-locations='@json($locations)'>
                <div>
                    <label class="block text-sm font-semibold">Departamento</label>
                    <select name="departamento" class="mt-1 w-full" data-address-department data-selected="{{ old('departamento') }}">
                        <option value="">Seleccione</option>
                        @foreach ($locations as $department => $provinces)
                            <option value="{{ $department }}" @selected(old('departamento') === $department)>{{ $department }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Provincia</label>
                    <select name="provincia" class="mt-1 w-full" data-address-province data-selected="{{ old('provincia') }}">
                        <option value="">Seleccione</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Distrito</label>
                    <select name="distrito" class="mt-1 w-full" data-address-district data-selected="{{ old('distrito') }}">
                        <option value="">Seleccione</option>
                    </select>
                </div>
                <div class="md:col-span-3">
                    <label class="block text-sm font-semibold">Calle, jiron, avenida o referencia</label>
                    <input name="direccion" value="{{ old('direccion') }}" class="mt-1 w-full">
                </div>
            </div>
        </section>

        <section class="rounded-xl bg-white p-6 shadow-sm">
            <h2 class="text-lg font-black text-slate-950">Apoderado</h2>
            <p class="mt-1 text-sm text-slate-500">Obligatorio para menores de 18 anos. Para mayores, completalo solo si corresponde.</p>
            <div class="mt-4 grid gap-4 md:grid-cols-3">
                <div>
                    <label class="block text-sm font-semibold">Tipo documento</label>
                    <select name="apoderado_tipo_documento_id" class="mt-1 w-full">
                        <option value="">Seleccione</option>
                        @foreach ($tiposDocumento as $tipo)
                            <option value="{{ $tipo->id }}" @selected(old('apoderado_tipo_documento_id') == $tipo->id)>{{ $tipo->nombre }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Numero documento</label>
                    <input name="apoderado_numero_documento" value="{{ old('apoderado_numero_documento') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Parentesco</label>
                    <select name="parentesco" class="mt-1 w-full">
                        <option value="">Seleccione</option>
                        @foreach (['padre' => 'Padre', 'madre' => 'Madre', 'tio' => 'Tio', 'tia' => 'Tia', 'tutor' => 'Apoderado'] as $value => $label)
                            <option value="{{ $value }}" @selected(old('parentesco') === $value)>{{ $label }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Nombres</label>
                    <input name="apoderado_nombres" value="{{ old('apoderado_nombres') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Apellido paterno</label>
                    <input name="apoderado_apellido_paterno" value="{{ old('apoderado_apellido_paterno') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Apellido materno</label>
                    <input name="apoderado_apellido_materno" value="{{ old('apoderado_apellido_materno') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Telefono</label>
                    <input name="apoderado_telefono" value="{{ old('apoderado_telefono') }}" class="mt-1 w-full">
                </div>
            </div>
        </section>

        <section class="rounded-xl bg-white p-6 shadow-sm">
            <h2 class="text-lg font-black text-slate-950">Colegio de procedencia</h2>
            <div class="mt-4 grid gap-4 md:grid-cols-2" data-peru-address data-locations='@json($locations)'>
                <div>
                    <label class="block text-sm font-semibold">Nombre del colegio</label>
                    <input name="colegio_nombre" value="{{ old('colegio_nombre') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Ano de egreso</label>
                    <input type="number" name="anio_egreso" value="{{ old('anio_egreso') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Departamento</label>
                    <select name="colegio_departamento" class="mt-1 w-full" data-address-department data-selected="{{ old('colegio_departamento') }}">
                        <option value="">Seleccione</option>
                        @foreach ($locations as $department => $provinces)
                            <option value="{{ $department }}" @selected(old('colegio_departamento') === $department)>{{ $department }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Provincia</label>
                    <select name="colegio_provincia" class="mt-1 w-full" data-address-province data-selected="{{ old('colegio_provincia') }}">
                        <option value="">Seleccione</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Distrito</label>
                    <select name="colegio_distrito" class="mt-1 w-full" data-address-district data-selected="{{ old('colegio_distrito') }}">
                        <option value="">Seleccione</option>
                    </select>
                </div>
            </div>
        </section>

        <section class="rounded-xl bg-white p-6 shadow-sm">
            <h2 class="text-lg font-black text-slate-950">Datos academicos</h2>
            <div class="mt-4 grid gap-4 md:grid-cols-2">
                <div>
                    <label class="block text-sm font-semibold">Carrera postulante</label>
                    <select name="carrera_id" class="mt-1 w-full">
                        <option value="">Seleccione</option>
                        @foreach ($carreras as $carrera)
                            <option value="{{ $carrera->id }}" @selected(old('carrera_id') == $carrera->id)>{{ $carrera->nombre }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Ciclo, sede y turno</label>
                    <select name="oferta_academica_id" class="mt-1 w-full">
                        <option value="">Seleccione</option>
                        @foreach ($ofertas as $oferta)
                            <option value="{{ $oferta->id }}" @selected(old('oferta_academica_id') == $oferta->id)>
                                {{ $oferta->cicloAcademico?->nombre }} - {{ $oferta->sede?->nombre }} - {{ $oferta->turno?->nombre }} ({{ $oferta->vacantesDisponibles() }} vacantes)
                            </option>
                        @endforeach
                    </select>
                </div>
            </div>
        </section>

        <section class="rounded-xl bg-white p-6 shadow-sm">
            <div class="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
                <div>
                    <h2 class="text-lg font-black text-slate-950">Pagos oficiales</h2>
                    <p class="mt-1 text-sm text-slate-500">Ingresa voucher, agencia y fecha para verificar pagos importados antes de guardar.</p>
                </div>
                <button
                    type="button"
                    class="rounded-lg border border-blue-200 px-4 py-2 text-sm font-bold text-blue-700 hover:bg-blue-50"
                    data-verify-payments
                    data-verify-payments-url="{{ route('ingresos-admision.alumnos.verificar-pagos') }}"
                >
                    Verificar pagos
                </button>
            </div>
            <div class="mt-4 grid gap-4 md:grid-cols-3">
                <div class="md:col-span-3">
                    <p class="text-xs font-black uppercase tracking-wide text-slate-500">Pago de matricula</p>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Voucher</label>
                    <input name="voucher_matricula" value="{{ old('voucher_matricula') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Agencia</label>
                    <input name="agencia_matricula" value="{{ old('agencia_matricula') }}" class="mt-1 w-full" maxlength="4">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Fecha de pago</label>
                    <input type="date" name="fecha_pago_matricula" value="{{ old('fecha_pago_matricula') }}" class="mt-1 w-full">
                </div>

                <div class="md:col-span-3 border-t border-slate-100 pt-4">
                    <p class="text-xs font-black uppercase tracking-wide text-slate-500">Pago de pension</p>
                </div>
                <div>
                    <label class="block text-sm font-semibold">Voucher</label>
                    <input name="voucher_pension" value="{{ old('voucher_pension') }}" class="mt-1 w-full">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Agencia</label>
                    <input name="agencia_pension" value="{{ old('agencia_pension') }}" class="mt-1 w-full" maxlength="4">
                </div>
                <div>
                    <label class="block text-sm font-semibold">Fecha de pago</label>
                    <input type="date" name="fecha_pago_pension" value="{{ old('fecha_pago_pension') }}" class="mt-1 w-full">
                </div>
                <div class="md:col-span-3">
                    <label class="block text-sm font-semibold">Observacion</label>
                    <textarea name="observacion" rows="3" class="mt-1 w-full">{{ old('observacion') }}</textarea>
                </div>
            </div>
            <div data-payment-verification-result></div>
        </section>

        <div class="flex justify-end gap-3">
            <a href="{{ route('ingresos-admision.alumnos.index') }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Cancelar</a>
            <button class="rounded-lg bg-blue-700 px-5 py-2 text-sm font-bold text-white hover:bg-blue-800">Registrar alumno</button>
        </div>
    </form>
@endsection
