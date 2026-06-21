@extends('layouts.app')

@section('title', 'Nueva oferta')

@section('content')
    <div class="rounded-xl bg-white p-6 shadow-sm">
        <h1 class="text-2xl font-black text-slate-950">Nueva oferta academica</h1>
        <form method="POST" action="{{ route('ingresos-admision.ofertas.store') }}" class="mt-6">
            @csrf
            @include('ingresos-admision.academico.ofertas._form', ['submit' => 'Guardar oferta'])
        </form>
    </div>
@endsection
