@extends('layouts.app')

@section('title', 'Editar codigo externo')

@section('content')
    <div class="max-w-3xl rounded-xl bg-white p-6 shadow-sm">
        <h1 class="text-2xl font-black text-slate-950">Editar codigo externo</h1>
        <form method="POST" action="{{ route('ingresos-admision.pagos.codigos-externos.update', $codigoExterno) }}" class="mt-6">
            @include('ingresos-admision.pagos.codigos-externos._form')
        </form>
    </div>
@endsection
