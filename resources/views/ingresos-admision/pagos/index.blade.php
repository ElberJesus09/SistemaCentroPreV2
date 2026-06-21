@extends('layouts.app')

@section('title', 'Pagos oficiales')

@section('content')
    <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
            <h1 class="text-2xl font-black text-slate-950">Pagos oficiales</h1>
            <p class="mt-1 text-sm text-slate-500">Pagos validos importados desde archivos oficiales.</p>
        </div>
        @can('ver importaciones de pagos')
            <a href="{{ route('ingresos-admision.pagos.importaciones.index') }}" class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Ver importaciones</a>
        @endcan
    </div>

    <form method="GET" class="mb-4 flex gap-2">
        <input name="buscar" value="{{ request('buscar') }}" placeholder="Documento o voucher" class="w-full max-w-md">
        <button class="rounded-lg border border-slate-200 px-4 py-2 text-sm font-bold text-slate-700 hover:bg-slate-50">Buscar</button>
    </form>

    <div class="overflow-hidden rounded-xl bg-white shadow-sm">
        <table class="w-full text-left text-sm">
            <thead class="bg-slate-50 text-xs uppercase text-slate-500">
                <tr>
                    <th class="px-4 py-3">Documento</th>
                    <th class="px-4 py-3">Voucher</th>
                    <th class="px-4 py-3">Fecha</th>
                    <th class="px-4 py-3">Concepto</th>
                    <th class="px-4 py-3">Canal</th>
                    <th class="px-4 py-3">Estado</th>
                    <th class="px-4 py-3"></th>
                </tr>
            </thead>
            <tbody class="divide-y divide-slate-100">
                @forelse ($pagos as $pago)
                    <tr>
                        <td class="px-4 py-3">{{ $pago->tipo_documento }} {{ $pago->numero_documento }}</td>
                        <td class="px-4 py-3 font-semibold">{{ $pago->voucher }}</td>
                        <td class="px-4 py-3">{{ $pago->fecha_pago?->format('d/m/Y') }}</td>
                        <td class="px-4 py-3">{{ $pago->conceptoPago?->nombre }}</td>
                        <td class="px-4 py-3">{{ $pago->canalPago?->nombre }}</td>
                        <td class="px-4 py-3">{{ $pago->estado->value }}</td>
                        <td class="px-4 py-3 text-right"><a href="{{ route('ingresos-admision.pagos.show', $pago) }}" class="font-bold text-blue-700">Ver</a></td>
                    </tr>
                @empty
                    <tr><td colspan="7" class="px-4 py-6 text-center text-slate-500">No hay pagos registrados.</td></tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="mt-4">{{ $pagos->links() }}</div>
@endsection
