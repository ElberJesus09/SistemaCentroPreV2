@extends('layouts.app')

@section('title', 'Detalle trabajador')

@section('content')
    <div class="rounded bg-white p-6 shadow-sm">
        <h1 class="text-2xl font-bold">{{ $trabajador->apellidos }}, {{ $trabajador->nombres }}</h1>
        <dl class="mt-6 grid gap-4 md:grid-cols-2">
            <div><dt class="text-sm font-semibold">Documento</dt><dd>{{ $trabajador->tipoDocumento?->nombre }}: {{ $trabajador->numero_documento }}</dd></div>
            <div><dt class="text-sm font-semibold">Sede</dt><dd>{{ $trabajador->sede?->nombre ?: 'Sin sede' }}</dd></div>
            <div><dt class="text-sm font-semibold">Telefono</dt><dd>{{ $trabajador->telefono ?: 'No registrado' }}</dd></div>
            <div><dt class="text-sm font-semibold">Correo</dt><dd>{{ $trabajador->correo ?: 'No registrado' }}</dd></div>
            <div><dt class="text-sm font-semibold">Usuario</dt><dd>{{ $trabajador->user?->email ?: 'Sin usuario asociado' }}</dd></div>
            <div><dt class="text-sm font-semibold">Estado</dt><dd>{{ $trabajador->estado ? 'Activo' : 'Inactivo' }}</dd></div>
        </dl>
        <a href="{{ route('personal.trabajadores.index') }}" class="mt-6 inline-block rounded border px-4 py-2">Volver</a>
    </div>
@endsection
