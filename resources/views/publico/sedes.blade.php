@extends('layouts.publico')

@section('title', 'Sedes | '.($configuracion?->nombre ?? 'Centro Preuniversitario UNPRG'))
@section('meta_description', 'Consulta la sede principal y sedes activas del Centro Preuniversitario.')

@php
    $mapaFallback = 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d832.8989196118165!2d-79.84621234365474!3d-6.7750537240223245!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x904cef26c7cf7125%3A0xb25f96c9c4a3c9d4!2sCentro%20Preuniversitario%20%22Francisco%20Aguinaga%20Castro%22!5e0!3m2!1ses!2spe!4v1778890974801!5m2!1ses!2spe';
    $mapaUrl = $sedePrincipal?->mapa_url;
    $mapaUrl = $mapaUrl && str_contains($mapaUrl, '!2m3!1f0!2f0!3f0') ? $mapaUrl : $mapaFallback;
@endphp

@section('content')
    <section class="grid gap-8 lg:grid-cols-[0.95fr_1.05fr] lg:items-center">
        <div>
            <span class="inline-flex items-center gap-2 rounded-full bg-primary-fixed px-4 py-2 text-xs font-bold uppercase tracking-[0.14em] text-primary">
                <span class="material-symbols-outlined text-base" style="font-variation-settings: 'FILL' 1">account_balance</span>
                Sede principal
            </span>
            <h1 class="mt-5 font-display text-4xl font-bold leading-tight text-primary md:text-5xl">
                Sede principal del Centro Preuniversitario
            </h1>
            <p class="mt-4 max-w-2xl text-base leading-relaxed text-on-surface-variant md:text-lg">
                Consulta direccion, horario, contacto y ubicacion registrada desde el modulo Institucional.
            </p>
        </div>
        <div class="overflow-hidden rounded-xl border border-outline-variant/50 bg-surface-container-lowest shadow-xl">
            <img src="{{ asset('images/public/sedes-principal.png') }}" alt="Centro Preuniversitario Juan Francisco Aguinaga Castro" class="aspect-[16/10] w-full object-cover" loading="eager" decoding="async">
        </div>
    </section>

    @if ($sedes->isEmpty())
        <p class="mt-10 rounded-xl border border-secondary-container/40 bg-secondary-container/15 px-5 py-4 text-sm text-on-secondary-container">
            No hay sedes registradas.
        </p>
    @else
        <section class="mt-10 grid gap-6 lg:grid-cols-12">
            <article class="rounded-xl border border-outline-variant/50 bg-surface-container-lowest p-6 shadow-sm lg:col-span-5 lg:p-8">
                <div class="flex items-start gap-4">
                    <span class="flex h-14 w-14 shrink-0 items-center justify-center rounded-xl bg-primary text-on-primary shadow-md">
                        <span class="material-symbols-outlined text-3xl" style="font-variation-settings: 'FILL' 1">account_balance</span>
                    </span>
                    <div>
                        <p class="text-xs font-bold uppercase tracking-[0.16em] text-secondary">{{ $sedePrincipal?->es_principal ? 'Sede principal' : 'Sede activa' }}</p>
                        <h2 class="mt-1 font-display text-2xl font-bold leading-tight text-primary">{{ $sedePrincipal->nombre }}</h2>
                    </div>
                </div>

                <div class="mt-8 space-y-4">
                    <div class="flex gap-3 rounded-xl border border-outline-variant/50 bg-surface-container-low p-4">
                        <span class="material-symbols-outlined mt-0.5 text-primary">location_on</span>
                        <div>
                            <p class="text-sm font-bold text-primary">Direccion</p>
                            <p class="mt-1 text-sm leading-relaxed text-on-surface-variant">{{ $sedePrincipal->direccion ?: 'Direccion pendiente' }}</p>
                        </div>
                    </div>
                    <div class="flex gap-3 rounded-xl border border-outline-variant/50 bg-surface-container-low p-4">
                        <span class="material-symbols-outlined mt-0.5 text-primary">schedule</span>
                        <div>
                            <p class="text-sm font-bold text-primary">Horario de atencion</p>
                            <p class="mt-1 text-sm leading-relaxed text-on-surface-variant">{{ $sedePrincipal->horario ?: 'Horario pendiente' }}</p>
                        </div>
                    </div>
                    <div class="flex gap-3 rounded-xl border border-outline-variant/50 bg-surface-container-low p-4">
                        <span class="material-symbols-outlined mt-0.5 text-primary">alternate_email</span>
                        <div>
                            <p class="text-sm font-bold text-primary">Contacto</p>
                            <p class="mt-1 text-sm leading-relaxed text-on-surface-variant">{{ $sedePrincipal->correo ?: $configuracion?->correo ?: 'Correo pendiente' }}</p>
                            @if ($sedePrincipal->telefono || $configuracion?->telefono)
                                <p class="mt-1 text-sm leading-relaxed text-on-surface-variant">{{ $sedePrincipal->telefono ?: $configuracion->telefono }}</p>
                            @endif
                        </div>
                    </div>
                </div>
            </article>

            <div class="overflow-hidden rounded-xl border border-outline-variant/50 bg-surface-container-lowest shadow-xl lg:col-span-7">
                @if ($mapaUrl)
                    <iframe src="{{ $mapaUrl }}" width="900" height="560" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade" class="h-[28rem] w-full lg:h-full" title="Mapa de {{ $sedePrincipal->nombre }}"></iframe>
                @else
                    <div class="flex h-[28rem] w-full items-center justify-center bg-primary-fixed px-6 text-center text-sm font-semibold text-primary">
                        Mapa pendiente de configurar.
                    </div>
                @endif
            </div>
        </section>

        @if ($sedes->count() > 1)
            <section class="mt-12 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
                @foreach ($sedes as $sede)
                    <article class="rounded-xl border border-outline-variant/50 bg-surface-container-lowest p-5 shadow-sm">
                        <p class="text-xs font-bold uppercase tracking-[0.16em] text-secondary">{{ $sede->tipo }}</p>
                        <h3 class="mt-2 font-display text-lg font-bold text-primary">{{ $sede->nombre }}</h3>
                        <p class="mt-2 text-sm leading-relaxed text-on-surface-variant">{{ $sede->direccion }}</p>
                    </article>
                @endforeach
            </section>
        @endif

        <section class="mt-12 rounded-xl bg-primary p-6 text-on-primary md:p-8">
            <div class="grid gap-6 md:grid-cols-[1fr_auto] md:items-center">
                <div>
                    <h2 class="font-display text-2xl font-bold">Atencion virtual disponible</h2>
                    <p class="mt-2 max-w-2xl text-sm leading-relaxed text-primary-fixed/90">
                        Para consultas sobre sedes, horarios o informacion institucional, comunicate con el equipo de atencion.
                    </p>
                </div>
                <div class="rounded-xl bg-secondary-container px-5 py-4 text-sm font-semibold text-on-secondary-container shadow-sm">
                    <p>Correo: {{ $sedePrincipal->correo ?: $configuracion?->correo ?: 'Pendiente' }}</p>
                    @if ($sedePrincipal->telefono || $configuracion?->telefono)
                        <p class="mt-1">Telefono: {{ $sedePrincipal->telefono ?: $configuracion->telefono }}</p>
                    @endif
                </div>
            </div>
        </section>
    @endif
@endsection
