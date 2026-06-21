@php
    $currentRoute = request()->route()?->getName() ?? '';
    $navigation = [
        ['label' => 'Trabajadores', 'route' => 'personal.trabajadores.index', 'match' => 'personal.trabajadores.', 'permission' => 'ver trabajadores'],
        ['label' => 'Usuarios', 'route' => 'personal.usuarios.index', 'match' => 'personal.usuarios.', 'permission' => 'ver usuarios'],
        ['label' => 'Roles', 'route' => 'personal.roles.index', 'match' => 'personal.roles.', 'permission' => 'ver roles'],
    ];
    $institutionalNavigation = [
        ['label' => 'Configuracion', 'route' => 'institucional.configuracion.edit', 'match' => 'institucional.configuracion.', 'permission' => 'editar institucional'],
        ['label' => 'Sedes', 'route' => 'institucional.sedes.index', 'match' => 'institucional.sedes.', 'permission' => 'ver sedes'],
        ['label' => 'Grupos academicos', 'route' => 'institucional.grupos-academicos.index', 'match' => 'institucional.grupos-academicos.', 'permission' => 'ver grupos academicos'],
        ['label' => 'Facultades', 'route' => 'institucional.facultades.index', 'match' => 'institucional.facultades.', 'permission' => 'ver facultades'],
        ['label' => 'Carreras', 'route' => 'institucional.carreras.index', 'match' => 'institucional.carreras.', 'permission' => 'ver carreras'],
    ];
    $incomeAdmissionNavigation = [
        ['label' => 'Pagos', 'route' => 'ingresos-admision.pagos.index', 'match' => 'ingresos-admision.pagos.show', 'permission' => 'ver pagos'],
        ['label' => 'Importaciones', 'route' => 'ingresos-admision.pagos.importaciones.index', 'match' => 'ingresos-admision.pagos.importaciones.', 'permission' => 'ver importaciones de pagos'],
        ['label' => 'Codigos externos', 'route' => 'ingresos-admision.pagos.codigos-externos.index', 'match' => 'ingresos-admision.pagos.codigos-externos.', 'permission' => 'gestionar codigos externos de pago'],
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
                    <a href="{{ auth()->user()->can('acceder dashboard') ? route('dashboard') : '#' }}" class="block text-base font-black tracking-wide">
                        Centro Pre
                    </a>
                    <p class="mt-1 text-xs font-medium text-blue-100/75">Panel administrativo</p>
                </div>

                <nav class="flex flex-1 flex-col gap-2 p-3 text-sm">
                    @can('acceder dashboard')
                        <a
                            href="{{ route('dashboard') }}"
                            @class([
                                'rounded-xl px-4 py-3 font-black transition',
                                'bg-white/15 text-white shadow-sm' => $currentRoute === 'dashboard',
                                'text-blue-50/80 hover:bg-white/10 hover:text-white' => $currentRoute !== 'dashboard',
                            ])
                        >
                            Dashboard
                        </a>
                    @endcan

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
                    @can('acceder modulo institucional')
                        <div class="rounded-xl bg-white/10 p-2" data-sidebar-group>
                            <button
                                type="button"
                                class="flex w-full items-center justify-between rounded-lg px-3 py-2 text-left font-black text-white transition hover:bg-white/10"
                                data-sidebar-toggle
                                aria-expanded="{{ str_starts_with($currentRoute, 'institucional.') ? 'true' : 'false' }}"
                            >
                                <span>Modulo Institucional</span>
                                <span class="text-xs text-blue-100/70 transition" data-sidebar-chevron>▾</span>
                            </button>

                            <div
                                class="mt-1 space-y-1 border-l border-white/15 pl-3"
                                data-sidebar-panel
                                @if (! str_starts_with($currentRoute, 'institucional.')) hidden @endif
                            >
                                @foreach ($institutionalNavigation as $item)
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
                    @can('acceder modulo ingresos admision')
                        <div class="rounded-xl bg-white/10 p-2" data-sidebar-group>
                            <button
                                type="button"
                                class="flex w-full items-center justify-between rounded-lg px-3 py-2 text-left font-black text-white transition hover:bg-white/10"
                                data-sidebar-toggle
                                aria-expanded="{{ str_starts_with($currentRoute, 'ingresos-admision.') ? 'true' : 'false' }}"
                            >
                                <span>Ingresos y Admision</span>
                                <span class="text-xs text-blue-100/70 transition" data-sidebar-chevron>▾</span>
                            </button>

                            <div
                                class="mt-1 space-y-1 border-l border-white/15 pl-3"
                                data-sidebar-panel
                                @if (! str_starts_with($currentRoute, 'ingresos-admision.')) hidden @endif
                            >
                                @foreach ($incomeAdmissionNavigation as $item)
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
                        @can('acceder dashboard')
                            <a
                                href="{{ route('dashboard') }}"
                                @class([
                                    'mb-2 inline-flex rounded-lg px-3 py-2 font-semibold',
                                    'bg-blue-700 text-white' => $currentRoute === 'dashboard',
                                    'text-slate-600' => $currentRoute !== 'dashboard',
                                ])
                            >
                                Dashboard
                            </a>
                        @endcan

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
                        @can('acceder modulo institucional')
                            <p class="mb-2 mt-3 text-xs font-black uppercase tracking-wide text-blue-700">Modulo Institucional</p>
                            <div class="flex gap-2 overflow-x-auto">
                                @foreach ($institutionalNavigation as $item)
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
                        @can('acceder modulo ingresos admision')
                            <p class="mb-2 mt-3 text-xs font-black uppercase tracking-wide text-blue-700">Ingresos y Admision</p>
                            <div class="flex gap-2 overflow-x-auto">
                                @foreach ($incomeAdmissionNavigation as $item)
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
        <div
            id="confirm-modal"
            class="fixed inset-0 z-50 hidden items-center justify-center bg-slate-950/60 px-4"
            aria-hidden="true"
        >
            <div class="w-full max-w-md rounded-2xl bg-white p-6 shadow-2xl">
                <div class="flex items-start gap-4">
                    <div class="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-red-50 text-xl font-black text-red-700">
                        !
                    </div>
                    <div>
                        <h2 id="confirm-modal-title" class="text-lg font-black text-slate-950">Confirmar accion</h2>
                        <p id="confirm-modal-message" class="mt-2 text-sm leading-relaxed text-slate-600">
                            Esta accion necesita confirmacion antes de continuar.
                        </p>
                    </div>
                </div>
                <div class="mt-6 flex justify-end gap-3">
                    <button type="button" id="confirm-modal-cancel" class="rounded-lg border border-slate-200 px-4 py-2 text-sm font-bold text-slate-700 hover:bg-slate-50">
                        Cancelar
                    </button>
                    <button type="button" id="confirm-modal-accept" class="rounded-lg bg-red-700 px-4 py-2 text-sm font-bold text-white hover:bg-red-800">
                        Si, continuar
                    </button>
                </div>
            </div>
        </div>
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

            (() => {
                const modal = document.getElementById('confirm-modal');
                const title = document.getElementById('confirm-modal-title');
                const message = document.getElementById('confirm-modal-message');
                const cancel = document.getElementById('confirm-modal-cancel');
                const accept = document.getElementById('confirm-modal-accept');
                let pendingForm = null;

                if (!modal || !title || !message || !cancel || !accept) {
                    return;
                }

                document.querySelectorAll('form[data-confirm]').forEach((form) => {
                    form.addEventListener('submit', (event) => {
                        if (form.dataset.confirmed === 'true') {
                            return;
                        }

                        event.preventDefault();
                        pendingForm = form;
                        title.textContent = form.dataset.confirmTitle || 'Confirmar accion';
                        message.textContent = form.dataset.confirm || 'Esta accion necesita confirmacion antes de continuar.';
                        modal.classList.remove('hidden');
                        modal.classList.add('flex');
                        modal.setAttribute('aria-hidden', 'false');
                    });
                });

                const close = () => {
                    modal.classList.add('hidden');
                    modal.classList.remove('flex');
                    modal.setAttribute('aria-hidden', 'true');
                    pendingForm = null;
                };

                cancel.addEventListener('click', close);
                modal.addEventListener('click', (event) => {
                    if (event.target === modal) {
                        close();
                    }
                });

                accept.addEventListener('click', () => {
                    if (!pendingForm) {
                        close();
                        return;
                    }

                    pendingForm.dataset.confirmed = 'true';
                    pendingForm.submit();
                });
            })();
        </script>
    @endauth
</body>
</html>
