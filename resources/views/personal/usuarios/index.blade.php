@extends('layouts.app')

@section('title', 'Usuarios')

@section('content')
    <div class="mb-6 flex items-center justify-between">
        <div>
            <h1 class="text-2xl font-bold">Usuarios</h1>
            <p class="text-sm text-gray-600">Cuentas que pueden ingresar al sistema.</p>
        </div>
        <a href="{{ route('personal.usuarios.create') }}" class="rounded bg-blue-700 px-4 py-2 text-sm font-semibold text-white">Nuevo usuario</a>
    </div>

    <div class="overflow-hidden rounded bg-white shadow-sm">
        <table class="w-full text-left text-sm">
            <thead class="bg-gray-100 text-xs uppercase text-gray-600">
                <tr>
                    <th class="px-4 py-3">Usuario</th>
                    <th class="px-4 py-3">Roles</th>
                    <th class="px-4 py-3">Estado</th>
                    <th class="px-4 py-3"></th>
                </tr>
            </thead>
            <tbody class="divide-y">
                @forelse ($usuarios as $usuario)
                    <tr>
                        <td class="px-4 py-3">
                            <div class="font-medium">{{ $usuario->name }}</div>
                            <div class="text-xs text-gray-500">{{ $usuario->email }}</div>
                        </td>
                        <td class="px-4 py-3">{{ $usuario->roles->pluck('name')->join(', ') ?: 'Sin roles' }}</td>
                        <td class="px-4 py-3">{{ $usuario->estado ? 'Activo' : 'Inactivo' }}</td>
                        <td class="px-4 py-3 text-right">
                            <a class="text-blue-700 hover:underline" href="{{ route('personal.usuarios.show', $usuario) }}">Ver</a>
                            <a class="ml-3 text-blue-700 hover:underline" href="{{ route('personal.usuarios.edit', $usuario) }}">Editar</a>
                            <form action="{{ route('personal.usuarios.destroy', $usuario) }}" method="POST" class="ml-3 inline">
                                @csrf
                                @method('DELETE')
                                <button class="text-red-700 hover:underline" onclick="return confirm('¿Desactivar usuario?')">Desactivar</button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="4" class="px-4 py-8 text-center text-gray-500">No hay usuarios registrados.</td></tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="mt-4">{{ $usuarios->links() }}</div>
@endsection
