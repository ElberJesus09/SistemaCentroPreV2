@extends('layouts.app')

@section('title', 'Codigos externos')

@section('content')
    <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
            <h1 class="text-2xl font-black text-slate-950">Codigos externos de pago</h1>
            <p class="mt-1 text-sm text-slate-500">Relacionan el codigo del Excel con Matricula o Pension.</p>
        </div>
        <a href="{{ route('ingresos-admision.pagos.codigos-externos.create') }}" class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Nuevo codigo</a>
    </div>

    <div class="overflow-hidden rounded-xl bg-white shadow-sm">
        <table class="w-full text-left text-sm">
            <thead class="bg-slate-50 text-xs uppercase text-slate-500">
                <tr><th class="px-4 py-3">Canal</th><th class="px-4 py-3">Codigo</th><th class="px-4 py-3">Concepto</th><th class="px-4 py-3">Estado</th><th class="px-4 py-3"></th></tr>
            </thead>
            <tbody class="divide-y divide-slate-100">
                @forelse ($codigos as $codigo)
                    <tr>
                        <td class="px-4 py-3">{{ $codigo->canalPago?->nombre }}</td>
                        <td class="px-4 py-3 font-semibold">{{ $codigo->codigo_externo }}</td>
                        <td class="px-4 py-3">{{ $codigo->conceptoPago?->nombre }}</td>
                        <td class="px-4 py-3">{{ $codigo->estado ? 'Activo' : 'Inactivo' }}</td>
                        <td class="px-4 py-3 text-right">
                            <a href="{{ route('ingresos-admision.pagos.codigos-externos.edit', $codigo) }}" class="font-bold text-blue-700">Editar</a>
                            <form method="POST" action="{{ route('ingresos-admision.pagos.codigos-externos.destroy', $codigo) }}" class="inline" data-confirm="Se eliminara este codigo externo.">
                                @csrf @method('DELETE')
                                <button class="ml-3 font-bold text-red-600">Eliminar</button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="5" class="px-4 py-6 text-center text-slate-500">No hay codigos registrados.</td></tr>
                @endforelse
            </tbody>
        </table>
    </div>
    <div class="mt-4">{{ $codigos->links() }}</div>
@endsection
