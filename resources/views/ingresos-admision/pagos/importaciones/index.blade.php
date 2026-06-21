@extends('layouts.app')

@section('title', 'Importaciones de pagos')

@section('content')
    <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
            <h1 class="text-2xl font-black text-slate-950">Importaciones de pagos</h1>
            <p class="mt-1 text-sm text-slate-500">Archivos oficiales cargados al sistema.</p>
        </div>
        @can('importar pagos')
            <a href="{{ route('ingresos-admision.pagos.importaciones.create') }}" class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Nueva importacion</a>
        @endcan
    </div>

    <div class="overflow-hidden rounded-xl bg-white shadow-sm">
        <table class="w-full text-left text-sm">
            <thead class="bg-slate-50 text-xs uppercase text-slate-500">
                <tr>
                    <th class="px-4 py-3">Archivo</th>
                    <th class="px-4 py-3">Canal</th>
                    <th class="px-4 py-3">Fecha ref.</th>
                    <th class="px-4 py-3">Importados</th>
                    <th class="px-4 py-3">Observados</th>
                    <th class="px-4 py-3">Estado</th>
                    <th class="px-4 py-3"></th>
                </tr>
            </thead>
            <tbody class="divide-y divide-slate-100">
                @forelse ($importaciones as $importacion)
                    <tr>
                        <td class="px-4 py-3 font-semibold">{{ $importacion->nombre_archivo }}</td>
                        <td class="px-4 py-3">{{ $importacion->canalPago?->nombre }}</td>
                        <td class="px-4 py-3">{{ $importacion->fecha_referencia?->format('d/m/Y') }}</td>
                        <td class="px-4 py-3">{{ $importacion->registros_importados }}</td>
                        <td class="px-4 py-3">{{ $importacion->registros_observados }}</td>
                        <td class="px-4 py-3">{{ $importacion->estado->value }}</td>
                        <td class="px-4 py-3 text-right"><a href="{{ route('ingresos-admision.pagos.importaciones.show', $importacion) }}" class="font-bold text-blue-700">Ver</a></td>
                    </tr>
                @empty
                    <tr><td colspan="7" class="px-4 py-6 text-center text-slate-500">No hay importaciones registradas.</td></tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="mt-4">{{ $importaciones->links() }}</div>
@endsection
