@extends('layouts.app')

@section('title', 'Nuevo usuario')

@section('content')
    <h1 class="mb-6 text-2xl font-bold">Nuevo usuario</h1>
    <form action="{{ route('personal.usuarios.store') }}" method="POST" class="rounded bg-white p-6 shadow-sm">
        @include('personal.usuarios._form')
    </form>
@endsection
