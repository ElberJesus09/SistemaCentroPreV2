@include('personal.partials.errors')

@csrf
@isset($codigoExterno)
    @method('PUT')
@endisset

<div class="grid gap-4 md:grid-cols-2">
    <div>
        <label class="block text-sm font-semibold">Canal</label>
        <select name="canal_pago_id" class="mt-1 w-full">
            @foreach ($canales as $canal)
                <option value="{{ $canal->id }}" @selected(old('canal_pago_id', $codigoExterno->canal_pago_id ?? '') == $canal->id)>{{ $canal->nombre }}</option>
            @endforeach
        </select>
    </div>
    <div>
        <label class="block text-sm font-semibold">Concepto</label>
        <select name="concepto_pago_id" class="mt-1 w-full">
            @foreach ($conceptos as $concepto)
                <option value="{{ $concepto->id }}" @selected(old('concepto_pago_id', $codigoExterno->concepto_pago_id ?? '') == $concepto->id)>{{ $concepto->nombre }}</option>
            @endforeach
        </select>
    </div>
    <div>
        <label class="block text-sm font-semibold">Codigo externo</label>
        <input name="codigo_externo" value="{{ old('codigo_externo', $codigoExterno->codigo_externo ?? '') }}" class="mt-1 w-full">
    </div>
    <div>
        <label class="block text-sm font-semibold">Descripcion externa</label>
        <input name="descripcion_externa" value="{{ old('descripcion_externa', $codigoExterno->descripcion_externa ?? '') }}" class="mt-1 w-full">
    </div>
    <label class="flex items-center gap-2 text-sm font-semibold">
        <input type="checkbox" name="estado" value="1" @checked(old('estado', $codigoExterno->estado ?? true))>
        Activo
    </label>
</div>

<div class="mt-6 flex gap-3">
    <button class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">Guardar</button>
    <a href="{{ route('ingresos-admision.pagos.codigos-externos.index') }}" class="rounded-lg border px-4 py-2 text-sm font-bold">Cancelar</a>
</div>
