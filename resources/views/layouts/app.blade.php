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
        ['label' => 'Codigos externos', 'route' => 'ingresos-admision.pagos.codigos-externos.index', 'match' => 'ingresos-admision.pagos.codigos-externos.', 'permission' => 'gestionar codigos externos de pago'],
        ['label' => 'Ciclos academicos', 'route' => 'ingresos-admision.ciclos.index', 'match' => 'ingresos-admision.ciclos.', 'permission' => 'ver ciclos academicos'],
        ['label' => 'Turnos', 'route' => 'ingresos-admision.turnos.index', 'match' => 'ingresos-admision.turnos.', 'permission' => 'ver turnos'],
        ['label' => 'Ofertas academicas', 'route' => 'ingresos-admision.ofertas.index', 'match' => 'ingresos-admision.ofertas.', 'permission' => 'ver ofertas academicas'],
        ['label' => 'Alumnos', 'route' => 'ingresos-admision.alumnos.index', 'match' => 'ingresos-admision.alumnos.', 'permission' => 'ver alumnos'],
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
                    <nav class="border-t border-slate-100 px-4 py-3 text-sm lg:hidden">
                        <details class="group">
                            <summary class="flex cursor-pointer list-none items-center justify-between rounded-lg bg-blue-700 px-4 py-2.5 font-black text-white shadow-sm">
                                <span>Menu del sistema</span>
                                <span class="text-xs text-blue-100 transition group-open:rotate-180">v</span>
                            </summary>
                            <div class="mt-3 space-y-4 rounded-lg border border-slate-200 bg-white p-3 shadow-sm">
                                @can('acceder dashboard')
                                    <a
                                        href="{{ route('dashboard') }}"
                                        @class([
                                            'block rounded-lg px-3 py-2 font-bold',
                                            'bg-blue-700 text-white' => $currentRoute === 'dashboard',
                                            'text-slate-700 hover:bg-slate-50' => $currentRoute !== 'dashboard',
                                        ])
                                    >
                                        Dashboard
                                    </a>
                                @endcan

                                @can('acceder modulo personal')
                                    <div>
                                        <p class="px-1 text-[11px] font-black uppercase tracking-wide text-blue-700">Modulo Personal</p>
                                        <div class="mt-2 flex flex-wrap gap-2">
                                            @foreach ($navigation as $item)
                                                @can($item['permission'])
                                                    <a
                                                        href="{{ route($item['route']) }}"
                                                        @class([
                                                            'rounded-lg px-3 py-2 font-semibold',
                                                            'bg-blue-700 text-white' => str_starts_with($currentRoute, $item['match']),
                                                            'bg-slate-50 text-slate-700 hover:bg-slate-100' => ! str_starts_with($currentRoute, $item['match']),
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
                                    <div>
                                        <p class="px-1 text-[11px] font-black uppercase tracking-wide text-blue-700">Modulo Institucional</p>
                                        <div class="mt-2 flex flex-wrap gap-2">
                                            @foreach ($institutionalNavigation as $item)
                                                @can($item['permission'])
                                                    <a
                                                        href="{{ route($item['route']) }}"
                                                        @class([
                                                            'rounded-lg px-3 py-2 font-semibold',
                                                            'bg-blue-700 text-white' => str_starts_with($currentRoute, $item['match']),
                                                            'bg-slate-50 text-slate-700 hover:bg-slate-100' => ! str_starts_with($currentRoute, $item['match']),
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
                                    <div>
                                        <p class="px-1 text-[11px] font-black uppercase tracking-wide text-blue-700">Ingresos y Admision</p>
                                        <div class="mt-2 flex flex-wrap gap-2">
                                            @foreach ($incomeAdmissionNavigation as $item)
                                                @can($item['permission'])
                                                    <a
                                                        href="{{ route($item['route']) }}"
                                                        @class([
                                                            'rounded-lg px-3 py-2 font-semibold',
                                                            'bg-blue-700 text-white' => str_starts_with($currentRoute, $item['match']),
                                                            'bg-slate-50 text-slate-700 hover:bg-slate-100' => ! str_starts_with($currentRoute, $item['match']),
                                                        ])
                                                    >
                                                        {{ $item['label'] }}
                                                    </a>
                                                @endcan
                                            @endforeach
                                        </div>
                                    </div>
                                @endcan
                            </div>
                        </details>
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
        <dialog
            id="app-confirm-dialog"
            class="fixed inset-0 z-50 m-auto w-[calc(100%-2rem)] max-w-md overflow-hidden rounded-xl border border-slate-200 bg-white p-0 text-left text-slate-900 shadow-2xl backdrop:bg-slate-950/55 backdrop:backdrop-blur-[2px]"
            aria-labelledby="app-confirm-dialog-title"
            aria-describedby="app-confirm-dialog-message"
            onclick="if (event.target === this) this.close()"
        >
            <div class="flex items-start gap-4 p-5 sm:p-6">
                <div class="flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-blue-50 text-xl font-black text-blue-700">
                    ?
                </div>
                <div class="min-w-0 flex-1">
                    <div class="flex items-start justify-between gap-3">
                        <div>
                            <h2 id="app-confirm-dialog-title" class="text-lg font-black text-slate-950">Confirmar accion</h2>
                            <p id="app-confirm-dialog-message" class="mt-1 text-sm leading-relaxed text-slate-600">Deseas continuar?</p>
                        </div>
                        <button
                            type="button"
                            class="-mr-2 -mt-2 inline-flex h-9 w-9 shrink-0 items-center justify-center rounded-full text-slate-400 transition hover:bg-slate-100 hover:text-slate-700 focus:outline-none focus:ring-2 focus:ring-blue-600"
                            data-confirm-cancel
                            aria-label="Cerrar modal"
                        >
                            x
                        </button>
                    </div>
                </div>
            </div>

            <div class="flex flex-col-reverse gap-2 border-t border-slate-200 bg-slate-50 px-5 py-4 sm:flex-row sm:justify-end sm:px-6">
                <button
                    type="button"
                    class="inline-flex items-center justify-center rounded-lg border border-slate-200 bg-white px-4 py-2.5 text-sm font-bold text-slate-700 transition hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-blue-600"
                    data-confirm-cancel
                >
                    Cancelar
                </button>
                <button
                    type="button"
                    class="inline-flex items-center justify-center rounded-lg bg-blue-700 px-4 py-2.5 text-sm font-bold text-white shadow-sm transition hover:bg-blue-800 focus:outline-none focus:ring-2 focus:ring-blue-600"
                    data-confirm-accept
                >
                    Confirmar
                </button>
            </div>
        </dialog>
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
                const modal = document.getElementById('app-confirm-dialog');
                const title = document.getElementById('app-confirm-dialog-title');
                const message = document.getElementById('app-confirm-dialog-message');
                const accept = modal?.querySelector('[data-confirm-accept]');
                const cancelButtons = modal?.querySelectorAll('[data-confirm-cancel]') ?? [];
                let pendingForm = null;

                if (!modal || !title || !message || !accept) {
                    return;
                }

                document.addEventListener('submit', (event) => {
                    const form = event.target;
                    const submitter = event.submitter instanceof HTMLElement ? event.submitter : null;

                    if (!(form instanceof HTMLFormElement) || form.dataset.confirmed === 'true') {
                        return;
                    }

                    const confirmMessage = submitter?.dataset.confirmMessage
                        || form.dataset.confirmMessage
                        || submitter?.dataset.confirm
                        || form.dataset.confirm;

                    if (!confirmMessage) {
                        return;
                    }

                    event.preventDefault();
                    pendingForm = form;
                    title.textContent = submitter?.dataset.confirmTitle || form.dataset.confirmTitle || 'Confirmar accion';
                    message.textContent = confirmMessage;
                    accept.textContent = submitter?.dataset.confirmButton || form.dataset.confirmButton || 'Si, continuar';
                    modal.showModal();
                });

                const close = () => {
                    modal.close();
                    pendingForm = null;
                };

                cancelButtons.forEach((button) => button.addEventListener('click', close));

                accept.addEventListener('click', () => {
                    if (!pendingForm) {
                        close();
                        return;
                    }

                    pendingForm.dataset.confirmed = 'true';
                    modal.close();
                    pendingForm.requestSubmit();
                    pendingForm = null;
                });
            })();
        </script>
    @endauth
</body>
</html>
