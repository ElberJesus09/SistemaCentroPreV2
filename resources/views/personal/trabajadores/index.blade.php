@extends('layouts.app')

@section('title', 'Trabajadores')

@section('content')
    <div class="mb-6 flex items-center justify-between">
        <div>
            <h1 class="text-2xl font-bold">Trabajadores</h1>
            <p class="text-sm text-gray-600">Personal interno del centro preuniversitario.</p>
        </div>
        <a href="{{ route('personal.trabajadores.create') }}" class="rounded bg-blue-700 px-4 py-2 text-sm font-semibold text-white">Nuevo trabajador</a>
    </div>

    <div class="overflow-hidden rounded bg-white shadow-sm">
        <table class="w-full text-left text-sm">
            <thead class="bg-gray-100 text-xs uppercase text-gray-600">
                <tr>
                    <th class="px-4 py-3">Documento</th>
                    <th class="px-4 py-3">Trabajador</th>
                    <th class="px-4 py-3">Sede</th>
                    <th class="px-4 py-3">Estado</th>
                    <th class="px-4 py-3"></th>
                </tr>
            </thead>
            <tbody class="divide-y">
                @forelse ($trabajadores as $trabajador)
                    <tr>
                        <td class="px-4 py-3">{{ $trabajador->tipoDocumento?->codigo }} {{ $trabajador->numero_documento }}</td>
                        <td class="px-4 py-3">
                            <div class="font-medium">{{ $trabajador->apellidos }}, {{ $trabajador->nombres }}</div>
                            <div class="text-xs text-gray-500">{{ $trabajador->correo ?: 'Sin correo' }}</div>
                        </td>
                        <td class="px-4 py-3">{{ $trabajador->sede?->nombre ?: 'Sin sede' }}</td>
                        <td class="px-4 py-3">{{ $trabajador->estado ? 'Activo' : 'Inactivo' }}</td>
                        <td class="px-4 py-3 text-right">
                            <a class="text-blue-700 hover:underline" href="{{ route('personal.trabajadores.show', $trabajador) }}">Ver</a>
                            <a class="ml-3 text-blue-700 hover:underline" href="{{ route('personal.trabajadores.edit', $trabajador) }}">Editar</a>
                            <form action="{{ route('personal.trabajadores.destroy', $trabajador) }}" method="POST" class="ml-3 inline" data-confirm-title="Desactivar trabajador" data-confirm="¿Estas seguro de desactivar este trabajador? El registro no se eliminara, solo quedara inactivo.">
                                @csrf
                                @method('DELETE')
                                <button class="text-red-700 hover:underline">Desactivar</button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="5" class="px-4 py-8 text-center text-gray-500">No hay trabajadores registrados.</td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="mt-4">{{ $trabajadores->links() }}</div>
@endsection
