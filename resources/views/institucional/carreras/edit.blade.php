@extends('layouts.app')
@section('title','Editar carrera')
@section('content')<form method="POST" action="{{ route('institucional.carreras.update',$carrera) }}" class="rounded-xl bg-white p-6 shadow-sm">@include('institucional.carreras._form')</form>@endsection
