@extends('layouts.app')
@section('title','Detalle facultad')
@section('content')<div class="rounded-xl bg-white p-6 shadow-sm"><h1 class="text-2xl font-bold">{{ $facultad->nombre }}</h1><p class="mt-2 text-sm text-slate-500">{{ $facultad->sigla }}</p>@if($facultad->enlace)<a class="mt-4 inline-block text-blue-700" href="{{ $facultad->enlace }}" target="_blank">Ver enlace</a>@endif<br><a href="{{ route('institucional.facultades.index') }}" class="mt-6 inline-block rounded-lg border px-4 py-2">Volver</a></div>@endsection
