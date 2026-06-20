@extends('layouts.app')

@section('title', 'Editar usuario')

@section('content')
    <h1 class="mb-6 text-2xl font-bold">Editar usuario</h1>
    <p class="mb-4 text-sm text-gray-600">Deja la contrasena vacia si no deseas cambiarla.</p>
    <form action="{{ route('personal.usuarios.update', $usuario) }}" method="POST" class="rounded bg-white p-6 shadow-sm">
        @include('personal.usuarios._form')
    </form>
@endsection
