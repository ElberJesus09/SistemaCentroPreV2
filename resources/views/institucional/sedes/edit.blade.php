@extends('layouts.app')
@section('title','Editar sede')
@section('content')<form method="POST" action="{{ route('institucional.sedes.update',$sede) }}" class="rounded-xl bg-white p-6 shadow-sm">@include('institucional.sedes._form')</form>@endsection
