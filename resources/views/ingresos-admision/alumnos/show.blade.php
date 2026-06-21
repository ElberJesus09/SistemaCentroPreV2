@extends('layouts.app')

@section('title', 'Ver alumno')

@section('content')
    @php
        $apoderado = $alumno->apoderados->first();
        $colegio = $alumno->colegios->first();
        $inscripcion = $alumno->inscripciones->sortByDesc('id')->first();
        $matricula = $alumno->matriculas->sortByDesc('id')->first();
    @endphp

    @include('personal.partials.errors')

    <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
            <h1 class="text-2xl font-black text-slate-950">{{ $alumno->nombreCompleto() }}</h1>
            <p class="mt-1 text-sm text-slate-500">
                {{ $alumno->tipoDocumento?->codigo }} {{ $alumno->numero_documento }} - Estado {{ $alumno->estado->value }}
            </p>
        </div>
        <div class="flex flex-wrap gap-2">
            @can('editar alumnos')
                <a href="{{ route('ingresos-admision.alumnos.edit', $alumno) }}" class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Editar</a>
            @endcan
            <a href="{{ route('ingresos-admision.alumnos.index') }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Volver</a>
        </div>
    </div>

    <div class="grid gap-6 xl:grid-cols-3">
        <section class="rounded-xl bg-white p-6 shadow-sm xl:col-span-3">
            <div class="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
                <div>
                    <h2 class="text-lg font-black text-slate-950">Documentos y correos</h2>
                    <p class="mt-1 text-sm text-slate-500">Ficha completa, reglamento y avisos enviados manualmente al alumno.</p>
                </div>
                <div class="rounded-full bg-blue-50 px-3 py-1 text-xs font-black uppercase tracking-wide text-blue-700">
                    {{ $alumno->correo }}
                </div>
            </div>

            <div class="mt-5 grid gap-4 lg:grid-cols-[0.85fr_1.15fr]">
                <div class="rounded-lg border border-slate-200 bg-slate-50 p-4">
                    <p class="text-sm font-black text-slate-950">Documentos del alumno</p>
                    <p class="mt-1 text-xs leading-relaxed text-slate-500">La ficha incluye datos del alumno y declaración jurada. El envío adjunta ficha completa y reglamento.</p>
                    <div class="mt-4 flex flex-wrap gap-2">
                        <a href="{{ route('ingresos-admision.alumnos.documentos.download', [$alumno, 'ficha']) }}" class="rounded-lg border border-blue-200 bg-white px-4 py-2 text-sm font-bold text-blue-700 hover:bg-blue-50">Descargar ficha completa</a>
                        <a href="{{ route('ingresos-admision.alumnos.documentos.download', [$alumno, 'reglamento']) }}" class="rounded-lg border border-blue-200 bg-white px-4 py-2 text-sm font-bold text-blue-700 hover:bg-blue-50">Descargar reglamento</a>
                        @can('enviar correos alumnos')
                            <form
                                method="POST"
                                action="{{ route('ingresos-admision.alumnos.correos.documentos', $alumno) }}"
                                data-confirm-title="Enviar documentos"
                                data-confirm="Se enviara la ficha completa y el reglamento al correo {{ $alumno->correo }}."
                                data-confirm-button="Si, enviar"
                            >
                                @csrf
                                <button class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Enviar documentos</button>
                            </form>
                        @endcan
                    </div>
                </div>

                @can('enviar correos alumnos')
                    <form method="POST" action="{{ route('ingresos-admision.alumnos.correos.aviso', $alumno) }}" class="rounded-lg border border-slate-200 p-4">
                        @csrf
                        <p class="text-sm font-black text-slate-950">Aviso personalizado</p>
                        <div class="mt-3 grid gap-3 md:grid-cols-3">
                            <div>
                                <label class="block text-sm font-semibold">Asunto</label>
                                <input name="asunto" value="{{ old('asunto') }}" class="mt-1 w-full" placeholder="Ej. Recordatorio">
                            </div>
                            <div class="md:col-span-2">
                                <label class="block text-sm font-semibold">Mensaje para el alumno</label>
                                <textarea name="mensaje" rows="3" class="mt-1 w-full" placeholder="Escribe aqui el aviso especifico para este alumno.">{{ old('mensaje') }}</textarea>
                            </div>
                        </div>
                        <div class="mt-3 flex justify-end">
                            <button class="rounded-lg border border-blue-200 px-4 py-2 text-sm font-bold text-blue-700 hover:bg-blue-50">Enviar aviso</button>
                        </div>
                    </form>
                @endcan
            </div>
        </section>

        <section class="rounded-xl bg-white p-6 shadow-sm xl:col-span-2">
            <h2 class="text-lg font-black text-slate-950">Datos personales</h2>
            <dl class="mt-4 grid gap-4 md:grid-cols-2">
                <div>
                    <dt class="text-xs font-black uppercase tracking-wide text-slate-500">Documento</dt>
                    <dd class="mt-1 font-semibold">{{ $alumno->numero_documento }}</dd>
                </div>
                <div>
                    <dt class="text-xs font-black uppercase tracking-wide text-slate-500">Nacimiento</dt>
                    <dd class="mt-1 font-semibold">{{ $alumno->fecha_nacimiento?->format('d/m/Y') ?? '-' }}</dd>
                </div>
                <div>
                    <dt class="text-xs font-black uppercase tracking-wide text-slate-500">Género</dt>
                    <dd class="mt-1 font-semibold">{{ ucfirst((string) $alumno->genero) }}</dd>
                </div>
                <div>
                    <dt class="text-xs font-black uppercase tracking-wide text-slate-500">Contacto</dt>
                    <dd class="mt-1 font-semibold">{{ $alumno->telefono }} - {{ $alumno->correo }}</dd>
                </div>
                <div class="md:col-span-2">
                    <dt class="text-xs font-black uppercase tracking-wide text-slate-500">Dirección</dt>
                    <dd class="mt-1 font-semibold">{{ $alumno->departamento }} / {{ $alumno->provincia }} / {{ $alumno->distrito }} - {{ $alumno->direccion }}</dd>
                </div>
            </dl>
        </section>

        <section class="rounded-xl bg-white p-6 shadow-sm">
            <h2 class="text-lg font-black text-slate-950">Apoderado</h2>
            @if ($apoderado)
                <dl class="mt-4 space-y-3">
                    <div>
                        <dt class="text-xs font-black uppercase tracking-wide text-slate-500">Nombre</dt>
                        <dd class="mt-1 font-semibold">{{ trim("{$apoderado->apellido_paterno} {$apoderado->apellido_materno} {$apoderado->nombres}") }}</dd>
                    </div>
                    <div>
                        <dt class="text-xs font-black uppercase tracking-wide text-slate-500">Documento</dt>
                        <dd class="mt-1 font-semibold">{{ $apoderado->numero_documento }}</dd>
                    </div>
                    <div>
                        <dt class="text-xs font-black uppercase tracking-wide text-slate-500">Teléfono</dt>
                        <dd class="mt-1 font-semibold">{{ $apoderado->telefono ?? '-' }}</dd>
                    </div>
                    <div>
                        <dt class="text-xs font-black uppercase tracking-wide text-slate-500">Parentesco</dt>
                        <dd class="mt-1 font-semibold">{{ $apoderado->pivot?->parentesco ?? '-' }}</dd>
                    </div>
                </dl>
            @else
                <p class="mt-4 text-sm text-slate-500">No se registro apoderado.</p>
            @endif
        </section>

        <section class="rounded-xl bg-white p-6 shadow-sm">
            <h2 class="text-lg font-black text-slate-950">Colegio</h2>
            @if ($colegio)
                <dl class="mt-4 space-y-3">
                    <div>
                        <dt class="text-xs font-black uppercase tracking-wide text-slate-500">Nombre</dt>
                        <dd class="mt-1 font-semibold">{{ $colegio->nombre }}</dd>
                    </div>
                    <div>
                        <dt class="text-xs font-black uppercase tracking-wide text-slate-500">Ubicación</dt>
                        <dd class="mt-1 font-semibold">{{ $colegio->departamento }} / {{ $colegio->provincia }} / {{ $colegio->distrito }}</dd>
                    </div>
                    <div>
                        <dt class="text-xs font-black uppercase tracking-wide text-slate-500">Año egreso</dt>
                        <dd class="mt-1 font-semibold">{{ $colegio->pivot?->anio_egreso ?? '-' }}</dd>
                    </div>
                </dl>
            @else
                <p class="mt-4 text-sm text-slate-500">No se registro colegio.</p>
            @endif
        </section>

        <section class="rounded-xl bg-white p-6 shadow-sm xl:col-span-2">
            <h2 class="text-lg font-black text-slate-950">Inscripción y matrícula</h2>
            <div class="mt-4 grid gap-4 md:grid-cols-2">
                <div class="rounded-lg border border-slate-200 p-4">
                    <p class="text-xs font-black uppercase tracking-wide text-slate-500">Inscripción</p>
                    @if ($inscripcion)
                        <dl class="mt-2 space-y-2 text-sm">
                            <div>
                                <dt class="font-black text-slate-500">Carrera</dt>
                                <dd class="font-semibold text-slate-950">{{ $inscripcion->carrera?->nombre ?? '-' }}</dd>
                            </div>
                        </dl>
                    @else
                        <p class="mt-2 text-sm text-slate-500">Sin inscripción.</p>
                    @endif
                </div>
                <div class="rounded-lg border border-slate-200 p-4">
                    <p class="text-xs font-black uppercase tracking-wide text-slate-500">Matrícula</p>
                    @if ($matricula)
                        <dl class="mt-2 grid gap-2 text-sm sm:grid-cols-2">
                            <div>
                                <dt class="font-black text-slate-500">Ciclo</dt>
                                <dd class="font-semibold text-slate-950">{{ $matricula->ofertaAcademica?->cicloAcademico?->nombre ?? '-' }}</dd>
                            </div>
                            <div>
                                <dt class="font-black text-slate-500">Turno</dt>
                                <dd class="font-semibold text-slate-950">{{ $matricula->ofertaAcademica?->turno?->nombre ?? '-' }}</dd>
                            </div>
                            <div class="sm:col-span-2">
                                <dt class="font-black text-slate-500">Sede</dt>
                                <dd class="font-semibold text-slate-950">{{ $matricula->ofertaAcademica?->sede?->nombre ?? '-' }}</dd>
                            </div>
                        </dl>
                    @else
                        <p class="mt-2 text-sm text-slate-500">Sin matrícula.</p>
                    @endif
                </div>
            </div>
        </section>

        <section class="rounded-xl bg-white p-6 shadow-sm xl:col-span-3">
            <h2 class="text-lg font-black text-slate-950">Pagos asociados</h2>
            <div class="mt-4 overflow-x-auto">
                <table class="w-full min-w-[680px] text-left text-sm">
                    <thead class="bg-slate-50 text-xs uppercase text-slate-500">
                        <tr>
                            <th class="px-4 py-3">Concepto</th>
                            <th class="px-4 py-3">Voucher</th>
                            <th class="px-4 py-3">Agencia</th>
                            <th class="px-4 py-3">Fecha</th>
                            <th class="px-4 py-3">Estado</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y">
                        @forelse (($matricula?->pagos ?? collect()) as $pago)
                            <tr>
                                <td class="px-4 py-3 font-semibold">{{ $pago->conceptoPago?->nombre ?? '-' }}</td>
                                <td class="px-4 py-3">{{ $pago->voucher }}</td>
                                <td class="px-4 py-3">{{ $pago->agencia }}</td>
                                <td class="px-4 py-3">{{ $pago->fecha_pago?->format('d/m/Y') ?? '-' }}</td>
                                <td class="px-4 py-3">{{ $pago->estado->value }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="px-4 py-6 text-center text-slate-500">No hay pagos asociados a la matricula.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </section>
    </div>
@endsection
