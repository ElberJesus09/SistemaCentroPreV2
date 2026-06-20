@extends('layouts.app')
@section('title','Detalle grupo academico')
@section('content')<div class="rounded-xl bg-white p-6 shadow-sm"><h1 class="text-2xl font-bold">{{ $grupoAcademico->nombre }}</h1><p class="mt-2 text-sm text-slate-500">{{ $grupoAcademico->codigo }}</p><p class="mt-4">{{ $grupoAcademico->descripcion ?: 'Sin descripcion' }}</p><a href="{{ route('institucional.grupos-academicos.index') }}" class="mt-6 inline-block rounded-lg border px-4 py-2">Volver</a></div>@endsection
