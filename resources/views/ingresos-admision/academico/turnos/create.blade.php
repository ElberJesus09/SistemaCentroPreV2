@extends('layouts.app')

@section('title', 'Nuevo turno')

@section('content')
    <div class="max-w-3xl rounded-xl bg-white p-6 shadow-sm">
        <h1 class="text-2xl font-black text-slate-950">Nuevo turno</h1>
        <form method="POST" action="{{ route('ingresos-admision.turnos.store') }}" class="mt-6">
            @csrf
            @include('ingresos-admision.academico.turnos._form', ['submit' => 'Guardar turno'])
        </form>
    </div>
@endsection
