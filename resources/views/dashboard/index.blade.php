@extends('layouts.app')

@section('title', 'Dashboard')

@section('content')
    <section class="rounded-2xl bg-gradient-to-br from-blue-800 to-blue-950 p-6 text-white shadow-xl shadow-blue-950/20">
        <p class="text-xs font-bold uppercase tracking-[0.18em] text-blue-100/80">Panel general</p>
        <h1 class="mt-3 text-3xl font-black">Bienvenido, {{ auth()->user()->name }}</h1>
        <p class="mt-2 max-w-2xl text-sm leading-relaxed text-blue-50/80">
            Este dashboard sera el punto de entrada del sistema. Mas adelante aqui podemos agregar indicadores, alertas, accesos rapidos y casos pendientes.
        </p>
    </section>

    <section class="mt-6 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
        @can('acceder modulo personal')
            <article class="rounded-xl bg-white p-5 shadow-sm">
                <h2 class="text-lg font-black text-slate-950">Modulo Personal</h2>
                <p class="mt-1 text-sm text-slate-500">Usuarios, trabajadores, roles y permisos.</p>
                <div class="mt-5 grid grid-cols-2 gap-3 text-sm">
                    <div class="rounded-lg bg-slate-50 p-3"><span class="block text-2xl font-black text-blue-700">{{ $resumen['trabajadores'] }}</span>Trabajadores</div>
                    <div class="rounded-lg bg-slate-50 p-3"><span class="block text-2xl font-black text-blue-700">{{ $resumen['usuarios'] }}</span>Usuarios</div>
                </div>
                <a href="{{ route('personal.trabajadores.index') }}" class="mt-5 inline-flex rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">
                    Entrar a Personal
                </a>
            </article>
        @endcan

        @can('acceder modulo institucional')
            <article class="rounded-xl bg-white p-5 shadow-sm">
                <h2 class="text-lg font-black text-slate-950">Modulo Institucional</h2>
                <p class="mt-1 text-sm text-slate-500">Sedes, grupos, facultades y carreras.</p>
                <div class="mt-5 grid grid-cols-2 gap-3 text-sm">
                    <div class="rounded-lg bg-slate-50 p-3"><span class="block text-2xl font-black text-blue-700">{{ $resumen['sedes'] }}</span>Sedes</div>
                    <div class="rounded-lg bg-slate-50 p-3"><span class="block text-2xl font-black text-blue-700">{{ $resumen['carreras'] }}</span>Carreras</div>
                </div>
                <a href="{{ route('institucional.sedes.index') }}" class="mt-5 inline-flex rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">
                    Entrar a Institucional
                </a>
            </article>
        @endcan

        <article class="rounded-xl bg-white p-5 shadow-sm">
            <h2 class="text-lg font-black text-slate-950">Resumen academico</h2>
            <p class="mt-1 text-sm text-slate-500">Datos base del catalogo institucional.</p>
            <div class="mt-5 grid grid-cols-2 gap-3 text-sm">
                <div class="rounded-lg bg-slate-50 p-3"><span class="block text-2xl font-black text-blue-700">{{ $resumen['gruposAcademicos'] }}</span>Grupos</div>
                <div class="rounded-lg bg-slate-50 p-3"><span class="block text-2xl font-black text-blue-700">{{ $resumen['facultades'] }}</span>Facultades</div>
            </div>
        </article>
    </section>

    <section class="mt-6 rounded-xl border border-dashed border-slate-300 bg-white p-5">
        <h2 class="text-lg font-black text-slate-950">Pendiente de definir</h2>
        <p class="mt-1 text-sm text-slate-500">
            Aqui podemos colocar luego los casos que quieras controlar: inscripciones pendientes, pagos por revisar, alumnos por sede, alertas academicas o reportes rapidos.
        </p>
    </section>
@endsection
