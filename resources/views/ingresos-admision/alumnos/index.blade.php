@extends('layouts.app')

@section('title', 'Alumnos')

@section('content')
    <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
            <h1 class="text-2xl font-black text-slate-950">Alumnos</h1>
            <p class="mt-1 text-sm text-slate-500">Registro privado de alumnos del módulo Ingresos y Admisión.</p>
        </div>
        @can('crear alumnos')
            <a href="{{ route('ingresos-admision.alumnos.create') }}" class="rounded-lg bg-blue-700 px-4 py-2 text-sm font-bold text-white hover:bg-blue-800">
                Registrar alumno
            </a>
        @endcan
    </div>

    <div class="overflow-hidden rounded-xl bg-white shadow-sm">
        <div class="overflow-x-auto">
        <table class="w-full min-w-[980px] text-left text-sm">
            <thead class="bg-slate-50 text-xs uppercase text-slate-500">
                <tr>
                    <th class="px-4 py-3">Código</th>
                    <th class="px-4 py-3">Documento</th>
                    <th class="px-4 py-3">Alumno</th>
                    <th class="px-4 py-3">Teléfono</th>
                    <th class="px-4 py-3">Correo</th>
                    <th class="px-4 py-3">Estado</th>
                    <th class="px-4 py-3 text-right">Acciones</th>
                </tr>
            </thead>
            <tbody class="divide-y">
                @forelse ($alumnos as $alumno)
                    <tr>
                        <td class="px-4 py-3 font-black text-blue-700">{{ $alumno->codigo }}</td>
                        <td class="px-4 py-3 font-bold">{{ $alumno->tipoDocumento?->codigo }} {{ $alumno->numero_documento }}</td>
                        <td class="px-4 py-3">{{ $alumno->nombreCompleto() }}</td>
                        <td class="px-4 py-3">{{ $alumno->telefono ?? '-' }}</td>
                        <td class="px-4 py-3">{{ $alumno->correo ?? '-' }}</td>
                        <td class="px-4 py-3">
                            <span @class([
                                'inline-flex rounded-full px-2.5 py-1 text-xs font-black uppercase tracking-wide',
                                'bg-emerald-50 text-emerald-700' => $alumno->estado->value === 'activo',
                                'bg-amber-50 text-amber-700' => $alumno->estado->value === 'pendiente',
                                'bg-slate-100 text-slate-600' => $alumno->estado->value === 'inactivo',
                                'bg-red-50 text-red-700' => $alumno->estado->value === 'rechazado',
                            ])>
                                {{ $alumno->estado->value }}
                            </span>
                        </td>
                        <td class="px-4 py-3">
                            <div class="flex justify-end gap-2">
                                @can('ver alumnos')
                                    <a href="{{ route('ingresos-admision.alumnos.show', $alumno) }}" class="rounded-lg border border-blue-200 px-3 py-1.5 text-xs font-bold text-blue-700 hover:bg-blue-50">
                                        Ver
                                    </a>
                                @endcan
                                @can('editar alumnos')
                                    <a href="{{ route('ingresos-admision.alumnos.edit', $alumno) }}" class="rounded-lg border border-slate-200 px-3 py-1.5 text-xs font-bold text-slate-700 hover:bg-slate-50">
                                        Editar
                                    </a>
                                @endcan
                                @can('desactivar alumnos')
                                    <form
                                        method="POST"
                                        action="{{ route('ingresos-admision.alumnos.destroy', $alumno) }}"
                                        data-confirm-title="Desactivar alumno"
                                        data-confirm="¿Seguro que deseas desactivar a {{ $alumno->nombreCompleto() }}? No se borrarán sus pagos ni matrículas."
                                        data-confirm-button="Si, desactivar"
                                    >
                                        @csrf
                                        @method('DELETE')
                                        <button class="rounded-lg border border-red-200 px-3 py-1.5 text-xs font-bold text-red-700 hover:bg-red-50">
                                            Desactivar
                                        </button>
                                    </form>
                                @endcan
                            </div>
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="7" class="px-4 py-6 text-center text-slate-500">Todavía no hay alumnos registrados.</td></tr>
                @endforelse
            </tbody>
        </table>
        </div>
    </div>
    <div class="mt-4">{{ $alumnos->links() }}</div>
@endsection
