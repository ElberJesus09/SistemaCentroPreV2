@extends('layouts.app')

@section('title', 'Nuevo ciclo')

@section('content')
    <div class="max-w-3xl rounded-xl bg-white p-6 shadow-sm">
        <h1 class="text-2xl font-black text-slate-950">Nuevo ciclo academico</h1>
        <form method="POST" action="{{ route('ingresos-admision.ciclos.store') }}" class="mt-6">
            @csrf
            @include('ingresos-admision.academico.ciclos._form', ['submit' => 'Guardar ciclo'])
        </form>
    </div>
@endsection
