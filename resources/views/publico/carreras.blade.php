@extends('layouts.publico')

@section('title', 'Carreras | '.($configuracion?->nombre ?? 'Centro Preuniversitario UNPRG'))
@section('meta_description', 'Explora las carreras disponibles para postular mediante el Centro Preuniversitario.')

@php
    $imagenes = [
        'MED' => 'medicina-humana.png',
        'ICV' => 'ingenieria-civil.png',
        'ISI' => 'ingenieria-sistemas.png',
        'ICI' => 'ingenieria-computacion.png',
        'ARC' => 'arquitectura.png',
        'CBB' => 'biologia.png',
        'MVE' => 'medicina-veterinaria.png',
        'DER' => 'derecho.png',
        'ENF' => 'enfermeria.png',
        'PSI' => 'psicologia.png',
        'IAG' => 'ingenieria-agricola.png',
    ];

    $descripciones = [
        'MED' => 'Refuerza biologia, quimica y razonamiento cientifico para postular a una carrera enfocada en salud.',
        'ICV' => 'Preparate en matematica, fisica y analisis espacial para disenar infraestructura al servicio de la comunidad.',
        'ISI' => 'Fortalece logica, algoritmos y pensamiento analitico para crear sistemas que resuelvan problemas reales.',
        'ICI' => 'Desarrolla bases en computacion, programacion y redes para construir soluciones digitales seguras.',
        'ARC' => 'Potencia creatividad, geometria y vision espacial para proyectar espacios funcionales y humanos.',
        'CBB' => 'Refuerza biologia, investigacion cientifica y analisis de sistemas vivos para postular con bases solidas.',
        'MVE' => 'Afianza ciencias naturales y vocacion de servicio para cuidar la salud animal y el bienestar productivo.',
        'DER' => 'Entrena comprension lectora, argumentacion y analisis social para formarte en justicia publica.',
        'ENF' => 'Consolida biologia, comunicacion y criterio humano para una profesion centrada en el cuidado.',
        'PSI' => 'Refuerza lectura critica, biologia y ciencias sociales para comprender la conducta humana.',
        'IAG' => 'Preparate en matematica, fisica y ciencias agrarias para optimizar agua, suelos y tecnologia.',
    ];
@endphp

@section('content')
    <section class="grid gap-8 rounded-xl border border-outline-variant/50 bg-surface-container-lowest p-6 shadow-sm md:p-8 lg:grid-cols-[0.9fr_1.1fr] lg:items-end">
        <div>
            <span class="inline-flex items-center gap-2 rounded-full bg-secondary-container px-4 py-2 text-xs font-bold uppercase tracking-[0.14em] text-on-secondary-container">
                <span class="material-symbols-outlined text-base">workspace_premium</span>
                Catalogo UNPRG
            </span>
            <h1 class="mt-5 font-display text-4xl font-bold leading-tight text-primary md:text-5xl">
                Carreras para elegir con claridad
            </h1>
            <p class="mt-4 max-w-2xl text-base leading-relaxed text-on-surface-variant md:text-lg">
                Conoce las carreras disponibles y elige con mas seguridad el camino que quieres seguir. La informacion se administra desde el modulo Institucional.
            </p>
        </div>
        <div class="grid gap-3 sm:grid-cols-3">
            <div class="rounded-xl bg-primary p-5 text-on-primary">
                <span class="material-symbols-outlined text-secondary-fixed">school</span>
                <p class="mt-6 font-display text-3xl font-bold">{{ $destacadas->count() }}</p>
                <p class="text-xs font-semibold uppercase tracking-wide text-primary-fixed/85">Destacadas</p>
            </div>
            <div class="rounded-xl bg-secondary-container p-5 text-on-secondary-container">
                <span class="material-symbols-outlined">format_list_bulleted</span>
                <p class="mt-6 font-display text-3xl font-bold">{{ $otras->count() }}</p>
                <p class="text-xs font-semibold uppercase tracking-wide">Adicionales</p>
            </div>
            <a href="{{ route('publico.sedes') }}" class="group rounded-xl border border-outline-variant/70 bg-surface-container-low p-5 text-primary transition hover:border-primary hover:bg-primary-fixed">
                <span class="material-symbols-outlined transition group-hover:translate-x-1">location_on</span>
                <p class="mt-6 text-sm font-bold">Ver sede principal</p>
            </a>
        </div>
    </section>

    @if ($destacadas->isEmpty() && $otras->isEmpty())
        <p class="mt-10 rounded-xl border border-secondary-container/40 bg-secondary-container/15 px-5 py-4 text-sm text-on-secondary-container">
            No hay carreras activas registradas.
        </p>
    @else
        <section class="mt-10 grid grid-cols-1 items-stretch gap-5 md:grid-cols-2 xl:grid-cols-3">
            @foreach ($destacadas as $carrera)
                @php
                    $imagen = $imagenes[$carrera->codigo] ?? null;
                    $descripcion = $descripciones[$carrera->codigo] ?? 'Preparate con contenidos clave para postular con mas seguridad a esta carrera de la UNPRG.';
                @endphp
                <article class="group flex h-full flex-col overflow-hidden rounded-xl border border-outline-variant/50 bg-surface-container-lowest shadow-sm transition duration-300 hover:-translate-y-1 hover:border-primary/50 hover:shadow-xl">
                    <div class="relative aspect-[16/10] overflow-hidden bg-surface-variant">
                        @if ($imagen)
                            <img src="{{ asset('images/careers/'.$imagen) }}" alt="{{ $carrera->nombre }}" class="h-full w-full object-cover transition duration-500 group-hover:scale-105" loading="lazy" decoding="async">
                        @else
                            <div class="absolute inset-0 flex items-center justify-center bg-primary-fixed">
                                <span class="material-symbols-outlined text-6xl text-primary">school</span>
                            </div>
                        @endif
                    </div>
                    <div class="flex min-h-80 flex-1 flex-col p-6">
                        <h2 class="font-display text-xl font-bold leading-tight text-primary">{{ $carrera->nombre }}</h2>
                        <p class="mt-3 flex-1 text-sm leading-relaxed text-on-surface-variant">{{ $descripcion }}</p>
                        <dl class="mt-5 space-y-3 border-t border-outline-variant/50 pt-4">
                            <div>
                                <dt class="text-[0.68rem] font-bold uppercase tracking-wide text-secondary">Facultad</dt>
                                <dd class="mt-1 text-sm font-semibold leading-snug text-on-surface">{{ $carrera->facultad?->nombre ?? 'Universidad Nacional Pedro Ruiz Gallo' }}</dd>
                            </div>
                            <div>
                                <dt class="text-[0.68rem] font-bold uppercase tracking-wide text-secondary">Grupo academico</dt>
                                <dd class="mt-1 text-sm text-on-surface-variant">{{ $carrera->grupoAcademico?->nombre ?? 'Catalogo UNPRG' }}</dd>
                            </div>
                        </dl>
                        <div class="mt-5 flex flex-wrap items-center justify-between gap-3">
                            @if ($carrera->enlace)
                                <a href="{{ $carrera->enlace }}" target="_blank" rel="noopener noreferrer" class="inline-flex items-center gap-1.5 text-sm font-bold text-secondary transition hover:text-primary">
                                    Ver facultad
                                    <span class="material-symbols-outlined text-lg">open_in_new</span>
                                </a>
                            @else
                                <span class="text-sm font-bold text-on-surface-variant">{{ $carrera->codigo }}</span>
                            @endif
                        </div>
                    </div>
                </article>
            @endforeach
        </section>

        @if ($otras->isNotEmpty())
            <section class="mt-14 grid gap-8 lg:grid-cols-[0.8fr_1.2fr] lg:items-start">
                <div class="space-y-4">
                    <span class="inline-flex items-center gap-2 rounded-full bg-primary-fixed px-4 py-2 text-xs font-bold uppercase tracking-[0.14em] text-primary">
                        <span class="material-symbols-outlined text-base">search</span>
                        Catalogo completo
                    </span>
                    <h2 class="font-display text-3xl font-bold text-primary">Mas alternativas para postular</h2>
                    <p class="text-sm leading-relaxed text-on-surface-variant md:text-base">
                        El Centro Preuniversitario prepara postulantes en facultades de ciencias, ingenierias, salud, humanidades y educacion.
                    </p>
                    <a href="{{ route('publico.sedes') }}" class="inline-flex items-center gap-2 rounded-xl border border-secondary px-5 py-3 text-sm font-bold text-secondary transition hover:bg-secondary-container active:scale-[0.98]">
                        <span class="material-symbols-outlined text-lg">location_on</span>
                        Ver sede principal
                    </a>
                </div>

                <div class="max-h-[28rem] overflow-y-auto rounded-xl border border-outline-variant/50 bg-surface-container-lowest p-3 shadow-inner">
                    <div class="grid gap-2 sm:grid-cols-2">
                        @foreach ($otras as $carrera)
                            <div class="flex min-w-0 items-start gap-3 rounded-lg border border-outline-variant/40 bg-surface-container-low px-3 py-2.5" title="{{ $carrera->nombre }}">
                                <div class="min-w-0 flex-1">
                                    <span class="block truncate text-sm font-semibold text-on-surface">{{ $carrera->nombre }}</span>
                                    <span class="mt-1 block truncate text-xs text-on-surface-variant">{{ $carrera->facultad?->nombre ?? 'Universidad Nacional Pedro Ruiz Gallo' }}</span>
                                    <span class="mt-1 block text-[0.68rem] font-bold uppercase tracking-wide text-secondary">{{ $carrera->grupoAcademico?->nombre ?? 'Catalogo UNPRG' }}</span>
                                </div>
                                @if ($carrera->enlace)
                                    <a href="{{ $carrera->enlace }}" target="_blank" rel="noopener noreferrer" class="shrink-0 rounded-full p-1 text-secondary transition hover:bg-secondary-container hover:text-on-secondary-container" aria-label="Ver facultad de {{ $carrera->nombre }}">
                                        <span class="material-symbols-outlined text-lg">open_in_new</span>
                                    </a>
                                @endif
                            </div>
                        @endforeach
                    </div>
                </div>
            </section>
        @endif
    @endif
@endsection
