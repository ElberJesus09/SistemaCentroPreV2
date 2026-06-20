@php
    $currentRoute = request()->route()?->getName() ?? '';
    $navigation = [
        ['label' => 'Trabajadores', 'route' => 'personal.trabajadores.index', 'match' => 'personal.trabajadores.', 'permission' => 'ver trabajadores'],
        ['label' => 'Usuarios', 'route' => 'personal.usuarios.index', 'match' => 'personal.usuarios.', 'permission' => 'ver usuarios'],
        ['label' => 'Roles', 'route' => 'personal.roles.index', 'match' => 'personal.roles.', 'permission' => 'ver roles'],
    ];
@endphp

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', 'Centro Pre')</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="min-h-screen bg-slate-100 font-sans text-slate-900 antialiased">
    @auth
        <div class="flex min-h-screen">
            <aside class="fixed inset-y-0 left-0 z-30 hidden w-64 flex-col border-r border-blue-900/30 bg-blue-950 text-white shadow-xl lg:flex">
                <div class="border-b border-white/10 px-5 py-5">
                    <a href="{{ route('personal.trabajadores.index') }}" class="block text-base font-black tracking-wide">
                        Centro Pre
                    </a>
                    <p class="mt-1 text-xs font-medium text-blue-100/75">Modulo Personal</p>
                </div>

                <nav class="flex flex-1 flex-col gap-2 p-3 text-sm">
                    @can('acceder modulo personal')
                        <div class="rounded-xl bg-white/10 p-2" data-sidebar-group>
                            <button
                                type="button"
                                class="flex w-full items-center justify-between rounded-lg px-3 py-2 text-left font-black text-white transition hover:bg-white/10"
                                data-sidebar-toggle
                                aria-expanded="{{ str_starts_with($currentRoute, 'personal.') ? 'true' : 'false' }}"
                            >
                                <span>Modulo Personal</span>
                                <span class="text-xs text-blue-100/70 transition" data-sidebar-chevron>▾</span>
                            </button>

                            <div
                                class="mt-1 space-y-1 border-l border-white/15 pl-3"
                                data-sidebar-panel
                                @if (! str_starts_with($currentRoute, 'personal.')) hidden @endif
                            >
                                @foreach ($navigation as $item)
                                    @can($item['permission'])
                                        <a
                                            href="{{ route($item['route']) }}"
                                            @class([
                                                'block rounded-lg px-3 py-2 font-semibold transition',
                                                'bg-white/15 text-white shadow-sm' => str_starts_with($currentRoute, $item['match']),
                                                'text-blue-50/80 hover:bg-white/10 hover:text-white' => ! str_starts_with($currentRoute, $item['match']),
                                            ])
                                        >
                                            {{ $item['label'] }}
                                        </a>
                                    @endcan
                                @endforeach
                            </div>
                        </div>
                    @endcan
                </nav>

                <div class="border-t border-white/10 p-4">
                    <p class="truncate text-sm font-semibold">{{ auth()->user()->name }}</p>
                    <p class="truncate text-xs text-blue-100/70">{{ auth()->user()->email }}</p>
                    <form action="{{ route('logout') }}" method="POST" class="mt-3">
                        @csrf
                        <button class="w-full rounded-lg border border-white/15 px-3 py-2 text-left text-sm font-semibold text-blue-50/90 transition hover:bg-white/10 hover:text-white">
                            Cerrar sesion
                        </button>
                    </form>
                </div>
            </aside>

            <div class="flex min-w-0 flex-1 flex-col lg:pl-64">
                <header class="sticky top-0 z-20 border-b border-slate-200 bg-white/90 backdrop-blur">
                    <div class="flex items-center justify-between gap-4 px-4 py-4 lg:px-8">
                        <div>
                            <p class="text-xs font-bold uppercase tracking-[0.18em] text-blue-700">Centro Pre</p>
                            <h1 class="text-lg font-bold text-slate-950">@yield('title', 'Administracion')</h1>
                        </div>
                        <form action="{{ route('logout') }}" method="POST" class="lg:hidden">
                            @csrf
                            <button class="rounded-lg border border-slate-200 px-3 py-2 text-sm font-semibold text-slate-700">Salir</button>
                        </form>
                    </div>
                    <nav class="border-t border-slate-100 px-4 py-2 text-sm lg:hidden">
                        @can('acceder modulo personal')
                            <p class="mb-2 text-xs font-black uppercase tracking-wide text-blue-700">Modulo Personal</p>
                            <div class="flex gap-2 overflow-x-auto">
                                @foreach ($navigation as $item)
                                    @can($item['permission'])
                                        <a
                                            href="{{ route($item['route']) }}"
                                            @class([
                                                'shrink-0 rounded-lg px-3 py-2 font-semibold',
                                                'bg-blue-700 text-white' => str_starts_with($currentRoute, $item['match']),
                                                'text-slate-600' => ! str_starts_with($currentRoute, $item['match']),
                                            ])
                                        >
                                            {{ $item['label'] }}
                                        </a>
                                    @endcan
                                @endforeach
                            </div>
                        @endcan
                    </nav>
                </header>

                <main class="flex-1 px-4 py-6 lg:px-8 lg:py-8">
                    @if (session('status'))
                        <div class="mb-6 rounded-lg border border-blue-200 bg-blue-50 px-4 py-3 text-sm font-medium text-blue-800">
                            {{ session('status') }}
                        </div>
                    @endif

                    @yield('content')
                </main>
            </div>
        </div>
    @else
        <main class="flex min-h-screen items-center justify-center bg-gradient-to-br from-blue-950 via-blue-900 to-slate-950 px-4 py-10">
            @yield('content')
        </main>
    @endauth
    @auth
        <script>
            document.querySelectorAll('[data-sidebar-group]').forEach((group) => {
                const toggle = group.querySelector('[data-sidebar-toggle]');
                const panel = group.querySelector('[data-sidebar-panel]');
                const chevron = group.querySelector('[data-sidebar-chevron]');

                if (!toggle || !panel) {
                    return;
                }

                const sync = () => {
                    const expanded = toggle.getAttribute('aria-expanded') === 'true';
                    panel.hidden = !expanded;
                    if (chevron) {
                        chevron.style.transform = expanded ? 'rotate(0deg)' : 'rotate(-90deg)';
                    }
                };

                toggle.addEventListener('click', () => {
                    const expanded = toggle.getAttribute('aria-expanded') === 'true';
                    toggle.setAttribute('aria-expanded', expanded ? 'false' : 'true');
                    sync();
                });

                sync();
            });
        </script>
    @endauth
</body>
</html>
