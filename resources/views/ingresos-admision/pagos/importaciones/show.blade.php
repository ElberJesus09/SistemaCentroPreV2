@extends('layouts.app')

@section('title', 'Detalle importacion')

@section('content')
    <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
        <div>
            <p class="text-xs font-black uppercase tracking-wide text-blue-700">Importacion</p>
            <h1 class="text-2xl font-black text-slate-950">{{ $importacion->nombre_archivo }}</h1>
            <p class="mt-1 text-sm text-slate-500">{{ $importacion->canalPago?->nombre }} - {{ $importacion->fecha_referencia?->format('d/m/Y') }}</p>
        </div>
        <div class="flex gap-2">
            @can('descargar archivos de pagos')
                @if ($importacion->disco && $importacion->ruta_archivo)
                <a href="{{ route('ingresos-admision.pagos.importaciones.download', $importacion) }}" class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Descargar archivo</a>
                @endif
            @endcan
            <a href="{{ route('ingresos-admision.pagos.importaciones.index') }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Volver</a>
        </div>
    </div>

    <section class="mb-6 grid gap-4 md:grid-cols-4">
        <div class="rounded-xl bg-white p-4 shadow-sm"><p class="text-2xl font-black text-blue-700">{{ $importacion->total_registros }}</p><p class="text-sm text-slate-500">Total</p></div>
        <div class="rounded-xl bg-white p-4 shadow-sm"><p class="text-2xl font-black text-blue-700">{{ $importacion->registros_importados }}</p><p class="text-sm text-slate-500">Importados</p></div>
        <div class="rounded-xl bg-white p-4 shadow-sm"><p class="text-2xl font-black text-amber-700">{{ $importacion->registros_observados }}</p><p class="text-sm text-slate-500">Observados</p></div>
        <div class="rounded-xl bg-white p-4 shadow-sm"><p class="text-sm font-black text-slate-900">{{ $importacion->estado->value }}</p><p class="text-sm text-slate-500">Estado</p></div>
    </section>

    @if ($importacion->mensaje_error)
        <p class="mb-6 rounded-lg bg-red-50 px-4 py-3 text-sm font-semibold text-red-800">{{ $importacion->mensaje_error }}</p>
    @endif

    @if ($observaciones->isNotEmpty())
        <section class="mb-6 rounded-xl border border-amber-200 bg-amber-50 p-5">
            <div class="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
                <div>
                    <h2 class="text-lg font-black text-amber-950">Observaciones encontradas</h2>
                    <p class="mt-1 text-sm text-amber-800">
                        Se muestran las primeras {{ $observaciones->count() }} filas observadas. Corrige el motivo y luego usa Reprocesar.
                    </p>
                </div>
                <span class="rounded-full bg-amber-100 px-3 py-1 text-xs font-black text-amber-800">
                    {{ $importacion->registros_observados }} observadas
                </span>
            </div>

            <div class="mt-4 space-y-3">
                @foreach ($observaciones as $observacion)
                    <article class="rounded-lg bg-white p-4 text-sm shadow-sm">
                        <div class="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
                            <div>
                                <p class="font-black text-slate-950">
                                    Fila {{ $observacion->numero_fila }}
                                    @if ($observacion->voucher)
                                        <span class="font-semibold text-slate-500">- Voucher {{ $observacion->voucher }}</span>
                                    @endif
                                </p>
                                <p class="mt-1 text-slate-600">
                                    Documento: {{ trim(($observacion->tipo_documento ?? '').' '.($observacion->numero_documento ?? '')) ?: 'No detectado' }}
                                    @if ($observacion->codigo_pago)
                                        | Codigo: {{ $observacion->codigo_pago }}
                                    @endif
                                </p>
                                <p class="mt-2 font-semibold text-amber-800">{{ $observacion->mensaje }}</p>
                            </div>
                            @can('reprocesar pagos observados')
                                <form method="POST" action="{{ route('ingresos-admision.pagos.detalles.reprocesar', $observacion) }}" data-confirm="Se intentara reprocesar esta fila observada.">
                                    @csrf
                                    <button class="rounded-lg bg-blue-700 px-3 py-2 text-xs font-bold text-white hover:bg-blue-800">Reprocesar</button>
                                </form>
                            @endcan
                        </div>
                    </article>
                @endforeach
            </div>
        </section>
    @endif

    <div class="overflow-hidden rounded-xl bg-white shadow-sm">
        <table class="w-full text-left text-xs">
            <thead class="bg-slate-50 uppercase text-slate-500">
                <tr>
                    <th class="px-3 py-3">Fila</th>
                    <th class="px-3 py-3">Documento</th>
                    <th class="px-3 py-3">Voucher</th>
                    <th class="px-3 py-3">Codigo</th>
                    <th class="px-3 py-3">Fecha</th>
                    <th class="px-3 py-3">Estado</th>
                    <th class="px-3 py-3">Mensaje</th>
                    <th class="px-3 py-3"></th>
                </tr>
            </thead>
            <tbody class="divide-y divide-slate-100">
                @forelse ($detalles as $detalle)
                    <tr>
                        <td class="px-3 py-3">{{ $detalle->numero_fila }}</td>
                        <td class="px-3 py-3">{{ $detalle->tipo_documento }} {{ $detalle->numero_documento }}</td>
                        <td class="px-3 py-3">{{ $detalle->voucher }}</td>
                        <td class="px-3 py-3">{{ $detalle->codigo_pago }}</td>
                        <td class="px-3 py-3">{{ $detalle->fecha_pago?->format('d/m/Y') }}</td>
                        <td class="px-3 py-3">{{ $detalle->estado->value }}</td>
                        <td class="px-3 py-3 text-slate-600">{{ $detalle->mensaje }}</td>
                        <td class="px-3 py-3 text-right">
                            @if ($detalle->pago)
                                <a href="{{ route('ingresos-admision.pagos.show', $detalle->pago) }}" class="font-bold text-blue-700">Pago</a>
                            @elseif (in_array($detalle->estado->value, ['pendiente', 'observada'], true))
                                @can('reprocesar pagos observados')
                                    <form method="POST" action="{{ route('ingresos-admision.pagos.detalles.reprocesar', $detalle) }}" data-confirm="Se intentara reprocesar esta fila.">
                                        @csrf
                                        <button class="font-bold text-blue-700">Reprocesar</button>
                                    </form>
                                @endcan
                            @endif
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="8" class="px-4 py-6 text-center text-slate-500">No hay detalles.</td></tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="mt-4">{{ $detalles->links() }}</div>
@endsection
