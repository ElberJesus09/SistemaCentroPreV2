@extends('layouts.app')

@section('title', 'Editar ciclo')

@section('content')
    <div class="max-w-3xl rounded-xl bg-white p-6 shadow-sm">
        <h1 class="text-2xl font-black text-slate-950">Editar ciclo academico</h1>
        <form method="POST" action="{{ route('ingresos-admision.ciclos.update', $ciclo) }}" class="mt-6">
            @csrf @method('PUT')
            @include('ingresos-admision.academico.ciclos._form', ['submit' => 'Actualizar ciclo'])
        </form>
    </div>
@endsection
