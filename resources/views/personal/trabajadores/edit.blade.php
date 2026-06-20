@extends('layouts.app')

@section('title', 'Editar trabajador')

@section('content')
    <h1 class="mb-6 text-2xl font-bold">Editar trabajador</h1>
    <form action="{{ route('personal.trabajadores.update', $trabajador) }}" method="POST" class="rounded bg-white p-6 shadow-sm">
        @include('personal.trabajadores._form')
    </form>
@endsection
