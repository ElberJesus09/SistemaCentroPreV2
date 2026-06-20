@extends('layouts.app')

@section('title', 'Editar rol')

@section('content')
    <h1 class="mb-6 text-2xl font-bold">Editar rol</h1>
    <form action="{{ route('personal.roles.update', $role) }}" method="POST" class="rounded bg-white p-6 shadow-sm">
        @include('personal.roles._form')
    </form>
@endsection
