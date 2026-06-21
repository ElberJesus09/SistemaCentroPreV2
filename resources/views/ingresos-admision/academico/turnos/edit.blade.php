@extends('layouts.app')

@section('title', 'Editar turno')

@section('content')
    <div class="max-w-3xl rounded-xl bg-white p-6 shadow-sm">
        <h1 class="text-2xl font-black text-slate-950">Editar turno</h1>
        <form method="POST" action="{{ route('ingresos-admision.turnos.update', $turno) }}" class="mt-6">
            @csrf @method('PUT')
            @include('ingresos-admision.academico.turnos._form', ['submit' => 'Actualizar turno'])
        </form>
    </div>
@endsection
