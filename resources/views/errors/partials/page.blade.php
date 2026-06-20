@php
    $hint = $hint ?? null;
@endphp

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ $code }} | {{ config('app.name', 'Centro Pre') }}</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="min-h-screen bg-slate-100 text-slate-900 antialiased">
    <main class="flex min-h-screen items-center justify-center px-4 py-10">
        <section class="w-full max-w-2xl rounded-2xl border border-slate-200 bg-white p-8 text-center shadow-xl shadow-slate-200/70">
            <p class="mx-auto flex h-16 w-16 items-center justify-center rounded-2xl bg-blue-50 text-2xl font-black text-blue-700">
                {{ $code }}
            </p>
            <h1 class="mt-6 text-3xl font-black text-slate-950">{{ $title }}</h1>
            <p class="mx-auto mt-3 max-w-xl text-sm leading-relaxed text-slate-600">{{ $message }}</p>

            @if ($hint)
                <p class="mx-auto mt-3 max-w-xl rounded-lg bg-slate-50 px-4 py-3 text-sm text-slate-500">
                    {{ $hint }}
                </p>
            @endif

            <div class="mt-7 flex flex-wrap justify-center gap-3">
                @auth
                    <a href="{{ url()->previous() }}" class="rounded-lg border border-slate-200 px-4 py-2 text-sm font-bold text-slate-700 hover:bg-slate-50">
                        Volver
                    </a>
                    @can('acceder dashboard')
                        <a href="{{ route('dashboard') }}" class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">
                            Ir al dashboard
                        </a>
                    @endcan
                @else
                    <a href="{{ route('login') }}" class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">
                        Iniciar sesion
                    </a>
                @endauth
            </div>
        </section>
    </main>
</body>
</html>
