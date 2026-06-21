@php
    $routeName = request()->route()?->getName() ?? '';
    $siteName = $configuracion?->nombre ?? 'Centro Preuniversitario Juan Francisco Aguinaga Castro';
    $current = match (true) {
        $routeName === 'publico.carreras' => 'carreras',
        $routeName === 'publico.sedes' => 'sedes',
        default => 'inicio',
    };
    $linkBase = 'rounded-full px-3 py-2 text-sm font-semibold transition-all duration-200';
    $linkIdle = 'text-on-surface-variant hover:bg-surface-container-low hover:text-primary';
    $linkActive = 'bg-primary-fixed text-primary shadow-sm';
    $socialLinks = [
        ['label' => 'Universidad', 'icon' => 'university', 'url' => $configuracion?->sitio_web ?: 'https://www.unprg.edu.pe/'],
        ['label' => 'Instagram', 'icon' => 'instagram', 'url' => 'https://www.instagram.com/unprg_oficial/'],
        ['label' => 'YouTube', 'icon' => 'youtube', 'url' => 'https://www.youtube.com/UniversidadNacionalPedroRuizGallo'],
        ['label' => 'Facebook', 'icon' => 'facebook', 'url' => 'https://www.facebook.com/unprgimageninstitucional/'],
    ];
@endphp

<!DOCTYPE html>
<html class="light" lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', $siteName)</title>
    <meta name="description" content="@yield('meta_description', $configuracion?->descripcion_publica ?? 'Portal publico del Centro Preuniversitario.')" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" rel="stylesheet">
    @stack('head')
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="min-h-screen overflow-x-hidden bg-surface font-sans text-on-surface antialiased">
    <header class="sticky top-0 z-50 border-b border-outline-variant/70 bg-surface/90 shadow-sm backdrop-blur-xl" role="banner">
        <div class="mx-auto flex max-w-7xl flex-wrap items-center justify-between gap-4 px-margin-mobile py-3 lg:px-margin-desktop">
            <a href="{{ route('inicio') }}" class="group flex items-center gap-3">
                <span class="flex h-12 w-12 items-center justify-center overflow-hidden rounded-xl bg-surface-container-lowest ring-1 ring-outline-variant/60 shadow-md shadow-primary/15">
                    <span class="font-display text-sm font-bold text-primary">CPU</span>
                </span>
                <span>
                    <span class="block font-display text-base font-bold leading-tight text-primary sm:text-lg">{{ $siteName }}</span>
                    <span class="text-xs font-semibold text-on-surface-variant">{{ $configuracion?->institucion_relacionada ?? 'Universidad Nacional Pedro Ruiz Gallo' }}</span>
                </span>
            </a>

            <nav class="hidden flex-wrap items-center gap-1 rounded-full border border-outline-variant/60 bg-surface-container-lowest/80 p-1 shadow-sm md:flex" aria-label="Principal">
                <a href="{{ route('inicio') }}" class="{{ $linkBase }} {{ $current === 'inicio' ? $linkActive : $linkIdle }}">Inicio</a>
                <a href="{{ route('publico.carreras') }}" class="{{ $linkBase }} {{ $current === 'carreras' ? $linkActive : $linkIdle }}">Carreras</a>
                <a href="{{ route('publico.sedes') }}" class="{{ $linkBase }} {{ $current === 'sedes' ? $linkActive : $linkIdle }}">Sedes</a>
            </nav>

            <div class="flex items-center gap-3">
                <div class="hidden items-center gap-2 md:flex" aria-label="Enlaces institucionales">
                    @foreach ($socialLinks as $socialLink)
                        <a
                            href="{{ $socialLink['url'] }}"
                            target="_blank"
                            rel="noopener noreferrer"
                            aria-label="{{ $socialLink['label'] }}"
                            title="{{ $socialLink['label'] }}"
                            class="inline-flex h-10 w-10 items-center justify-center rounded-xl border border-outline-variant bg-surface-container-lowest text-primary shadow-sm transition hover:bg-primary-fixed active:scale-[0.98]"
                        >
                            <x-publico.icono :name="$socialLink['icon']" class="h-5 w-5" />
                        </a>
                    @endforeach
                </div>

                <details class="relative md:hidden">
                    <summary class="flex cursor-pointer list-none items-center justify-center rounded-xl border border-outline-variant bg-surface-container-lowest p-2 text-primary shadow-sm [&::-webkit-details-marker]:hidden" aria-label="Abrir menu">
                        <span class="material-symbols-outlined text-2xl">menu</span>
                    </summary>
                    <div class="absolute right-0 z-50 mt-2 min-w-[13rem] overflow-hidden rounded-xl border border-outline-variant bg-surface-container-lowest py-2 shadow-xl">
                        <a href="{{ route('inicio') }}" class="block px-4 py-2.5 text-sm font-medium text-on-surface hover:bg-surface-container-high">Inicio</a>
                        <a href="{{ route('publico.carreras') }}" class="block px-4 py-2.5 text-sm font-medium text-on-surface hover:bg-surface-container-high">Carreras</a>
                        <a href="{{ route('publico.sedes') }}" class="block px-4 py-2.5 text-sm font-medium text-on-surface hover:bg-surface-container-high">Sedes</a>
                        <div class="mx-2 mt-2 border-t border-outline-variant pt-2">
                            @foreach ($socialLinks as $socialLink)
                                <a
                                    href="{{ $socialLink['url'] }}"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    class="flex items-center gap-2 rounded-lg px-3 py-2 text-sm font-medium text-on-surface hover:bg-surface-container-high"
                                >
                                    <x-publico.icono :name="$socialLink['icon']" class="h-5 w-5 text-primary" />
                                    {{ $socialLink['label'] }}
                                </a>
                            @endforeach
                        </div>
                    </div>
                </details>
            </div>
        </div>
    </header>

    <main class="mx-auto w-full max-w-7xl px-margin-mobile py-6 lg:px-margin-desktop lg:py-10">
        @yield('content')
    </main>

    <footer class="mt-8 border-t border-outline-variant bg-primary py-12 text-on-primary">
        <div class="mx-auto flex max-w-7xl flex-col gap-8 px-margin-mobile lg:flex-row lg:justify-between lg:px-margin-desktop">
            <div class="max-w-sm">
                <p class="font-display text-lg font-bold text-on-primary">{{ $siteName }}</p>
                <p class="mt-2 text-sm leading-relaxed text-primary-fixed/90">
                    {{ $configuracion?->descripcion_publica ?? 'Centro Preuniversitario Juan Francisco Aguinaga Castro - preparacion hacia la UNPRG.' }}
                </p>
            </div>
            <div class="flex flex-wrap gap-8 text-sm">
                <div>
                    <p class="mb-2 font-semibold text-secondary-fixed">Institucional</p>
                    <a href="{{ route('publico.carreras') }}" class="block text-primary-fixed/85 hover:text-secondary-fixed-dim">Carreras</a>
                    <a href="{{ route('publico.sedes') }}" class="mt-1 block text-primary-fixed/85 hover:text-secondary-fixed-dim">Sedes</a>
                </div>
                <div>
                    <p class="mb-2 font-semibold text-secondary-fixed">Enlaces</p>
                    <a href="{{ route('inicio') }}" class="block text-primary-fixed/85 hover:text-secondary-fixed-dim">Inicio</a>
                    @foreach ($socialLinks as $socialLink)
                        <a href="{{ $socialLink['url'] }}" target="_blank" rel="noopener noreferrer" class="mt-1 block text-primary-fixed/85 hover:text-secondary-fixed-dim">{{ $socialLink['label'] }}</a>
                    @endforeach
                </div>
            </div>
        </div>
        <p class="mx-auto mt-10 max-w-7xl border-t border-white/20 px-margin-mobile pt-6 text-center text-xs text-primary-fixed/70 lg:px-margin-desktop lg:text-left">
            (c) {{ date('Y') }} {{ $siteName }}. Todos los derechos reservados.
        </p>
    </footer>
    @stack('scripts')
</body>
</html>
