@extends('layouts.app')

@section('title', 'Turnos')

@section('content')
    <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
            <h1 class="text-2xl font-black text-slate-950">Turnos</h1>
            <p class="mt-1 text-sm text-slate-500">Turnos disponibles para las ofertas academicas.</p>
        </div>
        @can('gestionar turnos')
            <a href="{{ route('ingresos-admision.turnos.create') }}" class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Nuevo turno</a>
        @endcan
    </div>
    @include('personal.partials.errors')
    <div class="overflow-hidden rounded-xl bg-white shadow-sm">
        <table class="w-full text-left text-sm">
            <thead class="bg-slate-50 text-xs uppercase text-slate-500">
                <tr>
                    <th class="px-4 py-3">Codigo</th>
                    <th class="px-4 py-3">Nombre</th>
                    <th class="px-4 py-3">Horario</th>
                    <th class="px-4 py-3">Estado</th>
                    <th class="px-4 py-3"></th>
                </tr>
            </thead>
            <tbody class="divide-y">
                @forelse ($turnos as $turno)
                    <tr>
                        <td class="px-4 py-3 font-bold">{{ $turno->codigo }}</td>
                        <td class="px-4 py-3">{{ $turno->nombre }}</td>
                        <td class="px-4 py-3">{{ $turno->hora_inicio?->format('H:i') ?? '-' }} - {{ $turno->hora_fin?->format('H:i') ?? '-' }}</td>
                        <td class="px-4 py-3">{{ $turno->estado ? 'Activo' : 'Inactivo' }}</td>
                        <td class="px-4 py-3 text-right">
                            @can('gestionar turnos')
                                <a href="{{ route('ingresos-admision.turnos.edit', $turno) }}" class="font-bold text-blue-700">Editar</a>
                                <form method="POST" action="{{ route('ingresos-admision.turnos.destroy', $turno) }}" class="ml-3 inline" data-confirm="Se eliminara el turno si no esta usado en ofertas academicas.">
                                    @csrf @method('DELETE')
                                    <button class="font-bold text-red-600">Eliminar</button>
                                </form>
                            @endcan
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="5" class="px-4 py-6 text-center text-slate-500">No hay turnos registrados.</td></tr>
                @endforelse
            </tbody>
        </table>
    </div>
    <div class="mt-4">{{ $turnos->links() }}</div>
@endsection
