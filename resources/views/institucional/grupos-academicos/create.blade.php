@extends('layouts.app')
@section('title','Nuevo grupo academico')
@section('content')<form method="POST" action="{{ route('institucional.grupos-academicos.store') }}" class="rounded-xl bg-white p-6 shadow-sm">@include('institucional.grupos-academicos._form')</form>@endsection
