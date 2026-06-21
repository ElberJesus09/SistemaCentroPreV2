@extends('layouts.app')

@section('title', 'Ciclos academicos')

@section('content')
    <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
            <h1 class="text-2xl font-black text-slate-950">Ciclos academicos</h1>
            <p class="mt-1 text-sm text-slate-500">Periodos usados para programar ofertas de admision.</p>
        </div>
        @can('gestionar ciclos academicos')
            <a href="{{ route('ingresos-admision.ciclos.create') }}" class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Nuevo ciclo</a>
        @endcan
    </div>

    @include('personal.partials.errors')

    <div class="overflow-hidden rounded-xl bg-white shadow-sm">
        <table class="w-full text-left text-sm">
            <thead class="bg-slate-50 text-xs uppercase text-slate-500">
                <tr>
                    <th class="px-4 py-3">Codigo</th>
                    <th class="px-4 py-3">Nombre</th>
                    <th class="px-4 py-3">Periodo</th>
                    <th class="px-4 py-3">Inscripcion</th>
                    <th class="px-4 py-3">Estado</th>
                    <th class="px-4 py-3"></th>
                </tr>
            </thead>
            <tbody class="divide-y">
                @forelse ($ciclos as $ciclo)
                    <tr>
                        <td class="px-4 py-3 font-bold">{{ $ciclo->codigo }}</td>
                        <td class="px-4 py-3">{{ $ciclo->nombre }}</td>
                        <td class="px-4 py-3">{{ $ciclo->fecha_inicio?->format('d/m/Y') }} - {{ $ciclo->fecha_fin?->format('d/m/Y') }}</td>
                        <td class="px-4 py-3">{{ $ciclo->fecha_inicio_inscripcion?->format('d/m/Y') ?? '-' }} - {{ $ciclo->fecha_fin_inscripcion?->format('d/m/Y') ?? '-' }}</td>
                        <td class="px-4 py-3">{{ $ciclo->estado ? 'Activo' : 'Inactivo' }}</td>
                        <td class="px-4 py-3 text-right">
                            @can('gestionar ciclos academicos')
                                <a href="{{ route('ingresos-admision.ciclos.edit', $ciclo) }}" class="font-bold text-blue-700">Editar</a>
                                <form method="POST" action="{{ route('ingresos-admision.ciclos.destroy', $ciclo) }}" class="ml-3 inline" data-confirm="Se eliminara el ciclo si no tiene ofertas academicas.">
                                    @csrf @method('DELETE')
                                    <button class="font-bold text-red-600">Eliminar</button>
                                </form>
                            @endcan
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="6" class="px-4 py-6 text-center text-slate-500">No hay ciclos registrados.</td></tr>
                @endforelse
            </tbody>
        </table>
    </div>
    <div class="mt-4">{{ $ciclos->links() }}</div>
@endsection
