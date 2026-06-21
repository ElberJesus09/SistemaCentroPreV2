@extends('layouts.publico')

@section('title', ($configuracion?->nombre ?? 'Centro Preuniversitario UNPRG').' | Inicio')
@section('meta_description', $configuracion?->proposito_portal ?? 'Portal publico del Centro Preuniversitario para consultar carreras y sedes.')

@push('head')
    <link rel="preload" as="image" href="{{ asset('images/public/inicio-hero.webp') }}" type="image/webp" fetchpriority="high">
@endpush

@section('content')
    <section class="relative left-1/2 right-1/2 -ml-[50vw] -mr-[50vw] -mt-6 w-screen overflow-hidden bg-primary text-on-primary lg:-mt-10">
        <div class="absolute inset-0">
            <picture class="block h-full w-full">
                <source srcset="{{ asset('images/public/inicio-hero.webp') }}" type="image/webp">
                <img
                    src="{{ asset('images/public/inicio-hero.png') }}"
                    alt="Campus de la Universidad Nacional Pedro Ruiz Gallo"
                    class="h-full w-full object-cover"
                    width="1600"
                    height="1000"
                    loading="eager"
                    fetchpriority="high"
                    decoding="async"
                >
            </picture>
            <div class="absolute inset-0 bg-primary/60"></div>
        </div>

        <div class="relative mx-auto flex min-h-[calc(100vh-7rem)] max-w-7xl flex-col justify-end px-margin-mobile pb-12 pt-24 lg:min-h-[38rem] lg:px-margin-desktop lg:pb-16">
            <div class="max-w-4xl">
                <div class="mb-5 inline-flex items-center gap-2 rounded-full border border-white/30 bg-white/10 px-4 py-2 text-xs font-bold uppercase tracking-[0.18em] text-secondary-fixed backdrop-blur">
                    <span class="material-symbols-outlined text-base" style="font-variation-settings: 'FILL' 1">workspace_premium</span>
                    Admision {{ date('Y') }}
                </div>
                <h1 class="font-display text-4xl font-bold leading-[1.05] text-white drop-shadow md:text-6xl lg:text-7xl">
                    {{ $configuracion?->nombre ?? 'Centro Preuniversitario Juan Francisco Aguinaga Castro' }}
                </h1>
                <p class="mt-6 max-w-2xl text-base leading-relaxed text-primary-fixed md:text-xl">
                    {{ $configuracion?->descripcion_publica ?? 'Preparate con una guia clara, docentes comprometidos y un entorno pensado para avanzar con confianza hacia la Universidad Nacional Pedro Ruiz Gallo.' }}
                </p>
                <div class="mt-8 flex flex-wrap gap-3">
                    <a href="{{ route('publico.carreras') }}" class="inline-flex items-center justify-center gap-2 rounded-xl bg-secondary-container px-6 py-3 text-sm font-bold text-on-secondary-container shadow-lg shadow-black/20 transition hover:bg-secondary-fixed active:scale-[0.98]">
                        <span class="material-symbols-outlined text-lg">school</span>
                        Ver carreras
                    </a>
                    <a href="{{ route('publico.sedes') }}" class="inline-flex items-center justify-center gap-2 rounded-xl border border-white/40 bg-white/10 px-6 py-3 text-sm font-bold text-white backdrop-blur transition hover:bg-white/20 active:scale-[0.98]">
                        <span class="material-symbols-outlined text-lg">location_on</span>
                        Ver sedes
                    </a>
                </div>
            </div>
        </div>
    </section>

    <section class="relative z-10 -mt-8 grid gap-4 md:grid-cols-3">
        <article class="rounded-xl border border-outline-variant/60 bg-surface-container-lowest p-6 shadow-lg shadow-primary/5">
            <div class="flex items-center gap-3">
                <span class="flex h-12 w-12 items-center justify-center rounded-xl bg-primary-fixed text-primary">
                    <span class="material-symbols-outlined text-2xl">account_balance</span>
                </span>
                <div>
                    <p class="font-display text-2xl font-bold text-primary">{{ $totalSedes }}</p>
                    <p class="text-sm font-semibold text-on-surface-variant">Sedes activas</p>
                </div>
            </div>
        </article>
        <article class="rounded-xl border border-outline-variant/60 bg-surface-container-lowest p-6 shadow-lg shadow-primary/5">
            <div class="flex items-center gap-3">
                <span class="flex h-12 w-12 items-center justify-center rounded-xl bg-secondary-container text-secondary">
                    <span class="material-symbols-outlined text-2xl">workspace_premium</span>
                </span>
                <div>
                    <p class="font-display text-2xl font-bold text-primary">{{ $totalCarreras }}</p>
                    <p class="text-sm font-semibold text-on-surface-variant">Carreras disponibles</p>
                </div>
            </div>
        </article>
        <article class="rounded-xl border border-outline-variant/60 bg-surface-container-lowest p-6 shadow-lg shadow-primary/5">
            <div class="flex items-center gap-3">
                <span class="flex h-12 w-12 items-center justify-center rounded-xl bg-tertiary-fixed text-on-tertiary-fixed-variant">
                    <span class="material-symbols-outlined text-2xl">trending_up</span>
                </span>
                <div>
                    <p class="font-display text-2xl font-bold text-primary">{{ $carrerasDestacadas->count() }}</p>
                    <p class="text-sm font-semibold text-on-surface-variant">Carreras destacadas</p>
                </div>
            </div>
        </article>
    </section>

    <section class="mt-16 grid gap-10 lg:grid-cols-[0.95fr_1.05fr] lg:items-center">
        <div class="space-y-6">
            <span class="inline-flex items-center gap-2 rounded-full bg-primary-fixed px-4 py-2 text-xs font-bold uppercase tracking-[0.14em] text-primary">
                <span class="material-symbols-outlined text-base">verified</span>
                Preparacion enfocada
            </span>
            <h2 class="font-display text-3xl font-bold leading-tight text-primary md:text-4xl">
                Una preparacion con historia, respaldo universitario y compromiso con tu futuro
            </h2>
            <p class="text-base leading-relaxed text-on-surface-variant">
                El portal publico centraliza la informacion institucional del Centro Preuniversitario: carreras, sedes y datos base administrados desde el modulo Institucional.
            </p>
            <div class="grid gap-3 sm:grid-cols-2">
                @foreach ([
                    ['history_edu', 'Trayectoria preuniversitaria'],
                    ['account_balance', 'Respaldo institucional UNPRG'],
                    ['groups', 'Comunidad de postulantes'],
                    ['psychology', 'Mentalidad universitaria'],
                ] as [$icon, $label])
                    <div class="flex items-center gap-3 rounded-xl border border-outline-variant/50 bg-surface-container-lowest px-4 py-3">
                        <span class="material-symbols-outlined text-secondary" style="font-variation-settings: 'FILL' 1">{{ $icon }}</span>
                        <span class="text-sm font-semibold text-on-surface">{{ $label }}</span>
                    </div>
                @endforeach
            </div>
        </div>

        <div class="grid grid-cols-12 gap-4">
            <img src="{{ asset('images/public/inicio-centropre.png') }}" alt="Centro preuniversitario" class="col-span-7 aspect-[4/5] w-full rounded-xl object-cover shadow-xl" loading="lazy" decoding="async">
            <div class="col-span-5 flex flex-col gap-4 pt-8">
                <img src="{{ asset('images/public/inicio-alumnos.png') }}" alt="Alumnos del centro preuniversitario" class="aspect-[3/4] w-full rounded-xl object-cover shadow-lg" loading="lazy" decoding="async">
                <div class="rounded-xl bg-primary p-5 text-on-primary shadow-lg">
                    <span class="material-symbols-outlined text-secondary-fixed">school</span>
                    <p class="mt-3 text-sm font-semibold leading-relaxed">
                        Acompanamiento orientado al examen de admision UNPRG.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <section class="relative left-1/2 right-1/2 -ml-[50vw] -mr-[50vw] mb-[-3.5rem] mt-20 w-screen bg-surface-container-low py-14 md:py-16 lg:mb-[-4.5rem]">
        <div class="mx-auto max-w-7xl px-margin-mobile lg:px-margin-desktop">
            <div class="mb-8 flex flex-col gap-3 md:flex-row md:items-end md:justify-between">
                <div>
                    <span class="inline-flex items-center gap-2 rounded-full bg-secondary-container px-4 py-2 text-xs font-bold uppercase tracking-[0.14em] text-on-secondary-container">
                        <span class="material-symbols-outlined text-base">workspace_premium</span>
                        Beneficios
                    </span>
                    <h2 class="mt-4 max-w-3xl font-display text-3xl font-bold leading-tight text-primary md:text-4xl">
                        Ventajas de prepararte en el Centro Preuniversitario UNPRG
                    </h2>
                </div>
                <p class="max-w-xl text-sm leading-relaxed text-on-surface-variant">
                    Una preparacion pensada para fortalecer tu rendimiento academico y acercarte con mayor confianza al proceso de admision.
                </p>
            </div>

            <div class="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
                @foreach ([
                    ['school', 'Docentes de primer nivel', 'Clases a cargo de profesores preparados para orientar tu aprendizaje hacia el examen.'],
                    ['target', 'Preparacion enfocada', 'Refuerzo constante en los cursos y temas clave para postular a la UNPRG.'],
                    ['emoji_events', 'Ingreso directo', 'Oportunidad de ingreso directo para los primeros puestos, segun disposiciones vigentes.'],
                    ['support_agent', 'Acompanamiento academico', 'Seguimiento y apoyo durante tu proceso de preparacion preuniversitaria.'],
                ] as [$icon, $title, $description])
                    <article class="rounded-xl border border-outline-variant/60 bg-surface-container-lowest p-5 shadow-sm shadow-primary/5">
                        <span class="flex h-11 w-11 items-center justify-center rounded-xl bg-primary-fixed text-primary">
                            <span class="material-symbols-outlined text-2xl" style="font-variation-settings: 'FILL' 1">{{ $icon }}</span>
                        </span>
                        <h3 class="mt-4 font-display text-lg font-bold text-primary">{{ $title }}</h3>
                        <p class="mt-2 text-sm leading-relaxed text-on-surface-variant">{{ $description }}</p>
                    </article>
                @endforeach
            </div>
        </div>
    </section>
@endsection
