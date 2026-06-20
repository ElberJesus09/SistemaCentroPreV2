@extends('layouts.app')

@section('title', 'Nuevo trabajador')

@section('content')
    <h1 class="mb-6 text-2xl font-bold">Nuevo trabajador</h1>
    <form action="{{ route('personal.trabajadores.store') }}" method="POST" class="rounded bg-white p-6 shadow-sm">
        @include('personal.trabajadores._form')
    </form>
@endsection
