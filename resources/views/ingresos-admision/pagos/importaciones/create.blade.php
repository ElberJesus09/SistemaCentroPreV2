@extends('layouts.app')

@section('title', 'Importar pagos')

@section('content')
    <div class="max-w-2xl rounded-xl bg-white p-6 shadow-sm">
        <h1 class="text-2xl font-black text-slate-950">Importar archivo oficial</h1>
        <p class="mt-1 text-sm text-slate-500">Carga el archivo oficial del Banco de la Nacion correspondiente a la fecha de referencia.</p>

        @include('personal.partials.errors')

        <form
            method="POST"
            action="{{ route('ingresos-admision.pagos.importaciones.preview') }}"
            enctype="multipart/form-data"
            class="mt-6 space-y-5"
        >
            @csrf
            <div class="rounded-lg border border-blue-100 bg-blue-50 px-4 py-3">
                <p class="text-xs font-black uppercase tracking-wide text-blue-700">Canal de importacion</p>
                <p class="mt-1 text-sm font-semibold text-blue-950">{{ $canal->nombre }}</p>
            </div>
            <div>
                <label class="block text-sm font-semibold">Fecha de referencia</label>
                <input type="date" name="fecha_referencia" value="{{ old('fecha_referencia', now()->toDateString()) }}" class="mt-1 w-full">
                <p class="mt-1 text-xs text-slate-500">Si el archivo trae FECHA_PAGO diferente, la fila quedara con advertencia u observacion.</p>
            </div>
            <div>
                <label class="block text-sm font-semibold">Archivo Excel</label>
                <input type="file" name="archivo" accept=".xlsx,.xls" class="mt-1 w-full">
                <p class="mt-1 text-xs text-slate-500">XLSX soportado. XLS queda validado para activar lector binario luego.</p>
            </div>
            <div class="flex gap-3">
                <button class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Previsualizar observaciones</button>
                <a href="{{ route('ingresos-admision.pagos.importaciones.index') }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Cancelar</a>
            </div>
        </form>
    </div>
@endsection
