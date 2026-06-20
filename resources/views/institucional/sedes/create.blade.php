@extends('layouts.app')
@section('title','Nueva sede')
@section('content')<form method="POST" action="{{ route('institucional.sedes.store') }}" class="rounded-xl bg-white p-6 shadow-sm">@include('institucional.sedes._form')</form>@endsection
