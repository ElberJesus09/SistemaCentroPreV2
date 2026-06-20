@extends('layouts.app')

@section('title', 'Roles')

@section('content')
    <div class="mb-6 flex items-center justify-between">
        <h1 class="text-2xl font-bold">Roles</h1>
        <a href="{{ route('personal.roles.create') }}" class="rounded bg-blue-700 px-4 py-2 text-sm font-semibold text-white">Nuevo rol</a>
    </div>

    <div class="overflow-hidden rounded bg-white shadow-sm">
        <table class="w-full text-left text-sm">
            <thead class="bg-gray-100 text-xs uppercase text-gray-600">
                <tr><th class="px-4 py-3">Rol</th><th class="px-4 py-3">Permisos</th><th class="px-4 py-3"></th></tr>
            </thead>
            <tbody class="divide-y">
                @forelse ($roles as $role)
                    <tr>
                        <td class="px-4 py-3 font-medium">{{ $role->name }}</td>
                        <td class="px-4 py-3">{{ $role->permissions_count }}</td>
                        <td class="px-4 py-3 text-right">
                            <a class="text-blue-700 hover:underline" href="{{ route('personal.roles.show', $role) }}">Ver</a>
                            <a class="ml-3 text-blue-700 hover:underline" href="{{ route('personal.roles.edit', $role) }}">Editar</a>
                            <form action="{{ route('personal.roles.destroy', $role) }}" method="POST" class="ml-3 inline">
                                @csrf
                                @method('DELETE')
                                <button class="text-red-700 hover:underline" onclick="return confirm('¿Eliminar rol?')">Eliminar</button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="3" class="px-4 py-8 text-center text-gray-500">No hay roles registrados.</td></tr>
                @endforelse
            </tbody>
        </table>
    </div>
    <div class="mt-4">{{ $roles->links() }}</div>
@endsection
