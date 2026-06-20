@extends('layouts.app')
@section('title','Nueva carrera')
@section('content')<form method="POST" action="{{ route('institucional.carreras.store') }}" class="rounded-xl bg-white p-6 shadow-sm">@include('institucional.carreras._form')</form>@endsection
