@extends('layouts.app')
@section('title','Nueva facultad')
@section('content')<form method="POST" action="{{ route('institucional.facultades.store') }}" class="rounded-xl bg-white p-6 shadow-sm">@include('institucional.facultades._form')</form>@endsection
