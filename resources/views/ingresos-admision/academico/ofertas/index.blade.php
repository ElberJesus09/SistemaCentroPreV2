@extends('layouts.app')

@section('title', 'Ofertas academicas')

@section('content')
    <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
            <h1 class="text-2xl font-black text-slate-950">Ofertas academicas</h1>
            <p class="mt-1 text-sm text-slate-500">Programacion de ciclo, sede, turno y vacantes.</p>
        </div>
        @can('gestionar ofertas academicas')
            <a href="{{ route('ingresos-admision.ofertas.create') }}" class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Nueva oferta</a>
        @endcan
    </div>
    @include('personal.partials.errors')
    <div class="overflow-hidden rounded-xl bg-white shadow-sm">
        <table class="w-full text-left text-sm">
            <thead class="bg-slate-50 text-xs uppercase text-slate-500">
                <tr>
                    <th class="px-4 py-3">Ciclo</th>
                    <th class="px-4 py-3">Sede</th>
                    <th class="px-4 py-3">Turno</th>
                    <th class="px-4 py-3">Vacantes</th>
                    <th class="px-4 py-3">Costos</th>
                    <th class="px-4 py-3">Estado</th>
                    <th class="px-4 py-3"></th>
                </tr>
            </thead>
            <tbody class="divide-y">
                @forelse ($ofertas as $oferta)
                    <tr>
                        <td class="px-4 py-3 font-bold">{{ $oferta->cicloAcademico?->nombre }}</td>
                        <td class="px-4 py-3">{{ $oferta->sede?->nombre }}</td>
                        <td class="px-4 py-3">{{ $oferta->turno?->nombre }}</td>
                        <td class="px-4 py-3">{{ $oferta->matriculados }} / {{ $oferta->capacidad }} <span class="text-slate-500">({{ $oferta->vacantesDisponibles() }} libres)</span></td>
                        <td class="px-4 py-3">M: {{ $oferta->costo_matricula ?? '-' }} · P: {{ $oferta->costo_pension ?? '-' }}</td>
                        <td class="px-4 py-3">{{ $oferta->estado ? 'Activa' : 'Inactiva' }}</td>
                        <td class="px-4 py-3 text-right">
                            @can('gestionar ofertas academicas')
                                <a href="{{ route('ingresos-admision.ofertas.edit', $oferta) }}" class="font-bold text-blue-700">Editar</a>
                                <form method="POST" action="{{ route('ingresos-admision.ofertas.destroy', $oferta) }}" class="ml-3 inline" data-confirm="Se eliminara la oferta si no tiene matriculas ni inscripciones.">
                                    @csrf @method('DELETE')
                                    <button class="font-bold text-red-600">Eliminar</button>
                                </form>
                            @endcan
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="7" class="px-4 py-6 text-center text-slate-500">No hay ofertas academicas registradas.</td></tr>
                @endforelse
            </tbody>
        </table>
    </div>
    <div class="mt-4">{{ $ofertas->links() }}</div>
@endsection
