@extends('layouts.app')
@section('title','Editar grupo academico')
@section('content')<form method="POST" action="{{ route('institucional.grupos-academicos.update',$grupoAcademico) }}" class="rounded-xl bg-white p-6 shadow-sm">@include('institucional.grupos-academicos._form')</form>@endsection
