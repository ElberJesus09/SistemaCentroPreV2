@extends('layouts.app')

@section('title', 'Editar oferta')

@section('content')
    <div class="rounded-xl bg-white p-6 shadow-sm">
        <h1 class="text-2xl font-black text-slate-950">Editar oferta academica</h1>
        <p class="mt-1 text-sm text-slate-500">Matriculados actuales: {{ $oferta->matriculados }}</p>
        <form method="POST" action="{{ route('ingresos-admision.ofertas.update', $oferta) }}" class="mt-6">
            @csrf @method('PUT')
            @include('ingresos-admision.academico.ofertas._form', ['submit' => 'Actualizar oferta'])
        </form>
    </div>
@endsection
