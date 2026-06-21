@extends('layouts.app')

@section('title', 'Detalle pago')

@section('content')
    <div class="rounded-xl bg-white p-6 shadow-sm">
        <div class="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
            <div>
                <p class="text-xs font-black uppercase tracking-wide text-blue-700">Pago oficial</p>
                <h1 class="mt-1 text-2xl font-black text-slate-950">Voucher {{ $pago->voucher }}</h1>
            </div>
            <a href="{{ route('ingresos-admision.pagos.index') }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Volver</a>
        </div>

        <dl class="mt-6 grid gap-4 md:grid-cols-2">
            @foreach ([
                'Documento' => $pago->tipo_documento.' '.$pago->numero_documento,
                'Fecha de pago' => $pago->fecha_pago?->format('d/m/Y'),
                'Agencia' => $pago->agencia ?: 'No registrada',
                'Concepto' => $pago->conceptoPago?->nombre,
                'Canal' => $pago->canalPago?->nombre,
                'Estado' => $pago->estado->value,
            ] as $label => $value)
                <div class="rounded-lg bg-slate-50 p-4">
                    <dt class="text-xs font-black uppercase text-slate-500">{{ $label }}</dt>
                    <dd class="mt-1 font-semibold text-slate-900">{{ $value }}</dd>
                </div>
            @endforeach
        </dl>

        @if ($pago->observacion)
            <p class="mt-5 rounded-lg bg-amber-50 px-4 py-3 text-sm font-semibold text-amber-800">{{ $pago->observacion }}</p>
        @endif
    </div>
@endsection
