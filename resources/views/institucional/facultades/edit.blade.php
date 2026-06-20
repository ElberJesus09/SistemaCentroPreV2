@extends('layouts.app')
@section('title','Editar facultad')
@section('content')<form method="POST" action="{{ route('institucional.facultades.update',$facultad) }}" class="rounded-xl bg-white p-6 shadow-sm">@include('institucional.facultades._form')</form>@endsection
