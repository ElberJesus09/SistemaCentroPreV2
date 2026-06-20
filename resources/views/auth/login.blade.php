@extends('layouts.app')

@section('title', 'Iniciar sesion')

@section('content')
    <div class="w-full max-w-md rounded-xl border border-white/10 bg-white p-7 shadow-2xl shadow-black/30">
        <div class="mb-6">
            <p class="text-xs font-bold uppercase tracking-[0.18em] text-blue-700">Centro Pre</p>
            <h1 class="mt-2 text-2xl font-black text-slate-950">Iniciar sesion</h1>
            <p class="mt-1 text-sm text-slate-600">Acceso para usuarios del sistema administrativo.</p>
        </div>

        @include('personal.partials.errors')

        <form action="{{ route('login.store') }}" method="POST" class="mt-6 space-y-4">
            @csrf
            <div>
                <label class="block text-sm font-semibold text-slate-700">Correo</label>
                <input name="email" type="email" value="{{ old('email') }}" class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2.5 outline-none transition focus:border-blue-600 focus:ring-4 focus:ring-blue-100" autofocus>
            </div>
            <div>
                <label class="block text-sm font-semibold text-slate-700">Contrasena</label>
                <input name="password" type="password" class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2.5 outline-none transition focus:border-blue-600 focus:ring-4 focus:ring-blue-100">
            </div>
            <label class="flex items-center gap-2 text-sm text-slate-600">
                <input type="checkbox" name="remember" value="1">
                Recordarme
            </label>
            <button class="w-full rounded-lg bg-blue-700 px-4 py-2.5 font-bold text-white shadow-lg shadow-blue-900/20 transition hover:bg-blue-800">Ingresar</button>
        </form>

        <p class="mt-5 rounded-lg bg-slate-50 p-3 text-xs text-slate-600">
            Usuario inicial: admin@centropre.test / password
        </p>
    </div>
@endsection
