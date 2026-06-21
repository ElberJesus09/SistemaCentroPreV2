@extends('layouts.app')

@section('title', 'Previsualizar importacion')

@section('content')
    <div class="space-y-6">
        <div class="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
            <div>
                <h1 class="text-2xl font-black text-slate-950">Previsualizacion de pagos</h1>
                <p class="mt-1 text-sm text-slate-500">
                    Archivo: <span class="font-semibold text-slate-700">{{ $metadata['nombre_archivo'] }}</span>
                    · Canal: <span class="font-semibold text-slate-700">{{ $canal->nombre }}</span>
                    · Fecha: <span class="font-semibold text-slate-700">{{ $metadata['fecha_referencia'] }}</span>
                </p>
            </div>
            <a href="{{ route('ingresos-admision.pagos.importaciones.create') }}" class="rounded-lg border px-4 py-2 text-sm font-bold">
                Volver a cargar
            </a>
        </div>

        @include('personal.partials.errors')

        <div class="grid gap-4 md:grid-cols-3">
            <div class="rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
                <p class="text-xs font-black uppercase tracking-wide text-slate-500">Filas leidas</p>
                <p class="mt-2 text-3xl font-black text-slate-950">{{ $preview['total'] }}</p>
            </div>
            <div class="rounded-xl border border-emerald-200 bg-emerald-50 p-5 shadow-sm">
                <p class="text-xs font-black uppercase tracking-wide text-emerald-700">Listas para importar</p>
                <p class="mt-2 text-3xl font-black text-emerald-800">{{ $preview['procesados'] }}</p>
            </div>
            <div class="rounded-xl border border-amber-200 bg-amber-50 p-5 shadow-sm">
                <p class="text-xs font-black uppercase tracking-wide text-amber-700">Observaciones</p>
                <p class="mt-2 text-3xl font-black text-amber-800">{{ $preview['observados'] }}</p>
            </div>
        </div>

        @if ($preview['observados'] > 0)
            <section class="rounded-xl border border-amber-300 bg-amber-50 p-5">
                <h2 class="text-lg font-black text-amber-950">Corrige estas observaciones antes de importar</h2>
                <p class="mt-1 text-sm text-amber-800">
                    No se guardara la importacion mientras existan filas observadas. Corrige el Excel y vuelve a cargarlo.
                </p>

                <div class="mt-4 overflow-x-auto rounded-lg border border-amber-200 bg-white">
                    <table class="min-w-full text-sm">
                        <thead class="bg-amber-100 text-left text-xs uppercase tracking-wide text-amber-900">
                            <tr>
                                <th class="px-3 py-2">Fila</th>
                                <th class="px-3 py-2">Documento</th>
                                <th class="px-3 py-2">Voucher</th>
                                <th class="px-3 py-2">Codigo</th>
                                <th class="px-3 py-2">Agencia</th>
                                <th class="px-3 py-2">Observacion</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-amber-100">
                            @foreach ($preview['observaciones'] as $fila)
                                <tr>
                                    <td class="px-3 py-2 font-semibold">{{ $fila['numero_fila'] }}</td>
                                    <td class="px-3 py-2">{{ $fila['tipo_documento'] }} {{ $fila['numero_documento'] }}</td>
                                    <td class="px-3 py-2">{{ $fila['voucher'] ?? '-' }}</td>
                                    <td class="px-3 py-2">{{ $fila['codigo_pago'] ?? '-' }}</td>
                                    <td class="px-3 py-2">{{ $fila['agencia'] ?? '-' }}</td>
                                    <td class="px-3 py-2 text-amber-900">{{ $fila['mensaje'] }}</td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </section>
        @else
            <section class="rounded-xl border border-emerald-200 bg-emerald-50 p-5">
                <h2 class="text-lg font-black text-emerald-950">Sin observaciones</h2>
                <p class="mt-1 text-sm text-emerald-800">El archivo esta listo. Confirma para guardar la importacion y crear los pagos.</p>
                <form
                    method="POST"
                    action="{{ route('ingresos-admision.pagos.importaciones.confirm') }}"
                    class="mt-4"
                    data-confirm-title="Confirmar importacion"
                    data-confirm="El archivo no tiene observaciones. Se guardara la importacion y se crearan los pagos disponibles."
                >
                    @csrf
                    <input type="hidden" name="token" value="{{ $token }}">
                    <button class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Confirmar importacion</button>
                </form>
            </section>
        @endif

        <section class="rounded-xl bg-white shadow-sm">
            <div class="border-b px-5 py-4">
                <h2 class="font-black text-slate-950">Primeras filas revisadas</h2>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full text-sm">
                    <thead class="bg-slate-50 text-left text-xs uppercase tracking-wide text-slate-500">
                        <tr>
                            <th class="px-4 py-3">Fila</th>
                            <th class="px-4 py-3">Estado</th>
                            <th class="px-4 py-3">Documento</th>
                            <th class="px-4 py-3">Voucher</th>
                            <th class="px-4 py-3">Codigo</th>
                            <th class="px-4 py-3">Fecha</th>
                            <th class="px-4 py-3">Mensaje</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y">
                        @foreach ($preview['filas'] as $fila)
                            <tr>
                                <td class="px-4 py-3 font-semibold">{{ $fila['numero_fila'] }}</td>
                                <td class="px-4 py-3">
                                    <span @class([
                                        'rounded-full px-2 py-1 text-xs font-bold',
                                        'bg-emerald-100 text-emerald-700' => $fila['estado'] === 'procesada',
                                        'bg-amber-100 text-amber-800' => $fila['estado'] !== 'procesada',
                                    ])>
                                        {{ $fila['estado'] }}
                                    </span>
                                </td>
                                <td class="px-4 py-3">{{ $fila['tipo_documento'] }} {{ $fila['numero_documento'] }}</td>
                                <td class="px-4 py-3">{{ $fila['voucher'] ?? '-' }}</td>
                                <td class="px-4 py-3">{{ $fila['codigo_pago'] ?? '-' }}</td>
                                <td class="px-4 py-3">{{ $fila['fecha_pago'] ?? '-' }}</td>
                                <td class="px-4 py-3">{{ $fila['mensaje'] ?? '-' }}</td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </section>
    </div>
@endsection
