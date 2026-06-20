@extends('layouts.app')

@section('title', 'Configuracion institucional')

@section('content')
    @include('personal.partials.errors')
    <form action="{{ route('institucional.configuracion.update') }}" method="POST" class="rounded-xl bg-white p-6 shadow-sm">
        @csrf
        @method('PUT')
        <div class="grid gap-5 md:grid-cols-2">
            <div><label class="block text-sm font-semibold">Nombre</label><input name="nombre" value="{{ old('nombre', $configuracion->nombre) }}" class="mt-1 w-full"></div>
            <div><label class="block text-sm font-semibold">Institucion relacionada</label><input name="institucion_relacionada" value="{{ old('institucion_relacionada', $configuracion->institucion_relacionada) }}" class="mt-1 w-full"></div>
            <div><label class="block text-sm font-semibold">Correo</label><input name="correo" type="email" value="{{ old('correo', $configuracion->correo) }}" class="mt-1 w-full"></div>
            <div><label class="block text-sm font-semibold">Telefono</label><input name="telefono" value="{{ old('telefono', $configuracion->telefono) }}" class="mt-1 w-full"></div>
            <div><label class="block text-sm font-semibold">Sitio web</label><input name="sitio_web" value="{{ old('sitio_web', $configuracion->sitio_web) }}" class="mt-1 w-full"></div>
            <div><label class="block text-sm font-semibold">Estado</label><select name="estado" class="mt-1 w-full"><option value="1" @selected(old('estado', $configuracion->estado) == 1)>Activo</option><option value="0" @selected(old('estado', $configuracion->estado) == 0)>Inactivo</option></select></div>
            <div class="md:col-span-2"><label class="block text-sm font-semibold">Proposito del portal</label><textarea name="proposito_portal" rows="3" class="mt-1 w-full">{{ old('proposito_portal', $configuracion->proposito_portal) }}</textarea></div>
            <div class="md:col-span-2"><label class="block text-sm font-semibold">Descripcion publica</label><textarea name="descripcion_publica" rows="4" class="mt-1 w-full">{{ old('descripcion_publica', $configuracion->descripcion_publica) }}</textarea></div>
        </div>
        <button class="mt-6 rounded-lg bg-blue-700 px-4 py-2 font-bold text-white hover:bg-blue-800">Guardar cambios</button>
    </form>
@endsection
