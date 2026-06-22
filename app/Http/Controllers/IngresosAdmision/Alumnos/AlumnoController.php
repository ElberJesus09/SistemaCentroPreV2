<?php

namespace App\Http\Controllers\IngresosAdmision\Alumnos;

use App\Enums\IngresosAdmision\Alumnos\EstadoAlumno;
use App\Http\Controllers\Controller;
use App\Http\Requests\IngresosAdmision\Alumnos\AlumnoUpdateRequest;
use App\Http\Requests\IngresosAdmision\Alumnos\RegistroAlumnoPrivadoRequest;
use App\Models\Alumno;
use App\Models\Apoderado;
use App\Models\Carrera;
use App\Models\Colegio;
use App\Models\OfertaAcademica;
use App\Models\TipoDocumento;
use App\Services\Documentos\DocumentoIdentidadService;
use App\Services\IngresosAdmision\Alumnos\RegistroAlumnoPrivadoService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\View\View;

class AlumnoController extends Controller
{
    public function index(Request $request): View
    {
        $search = trim((string) $request->query('q', ''));

        $alumnos = Alumno::query()
            ->with(['tipoDocumento'])
            ->when($search !== '', function ($query) use ($search): void {
                $like = '%'.addcslashes($search, '%_\\').'%';

                $query->where(function ($query) use ($like): void {
                    $query
                        ->where('codigo', 'like', $like)
                        ->orWhere('numero_documento', 'like', $like)
                        ->orWhere('nombres', 'like', $like)
                        ->orWhere('apellido_paterno', 'like', $like)
                        ->orWhere('apellido_materno', 'like', $like)
                        ->orWhereRaw("CONCAT_WS(' ', apellido_paterno, apellido_materno, nombres) LIKE ?", [$like])
                        ->orWhereRaw("CONCAT_WS(' ', nombres, apellido_paterno, apellido_materno) LIKE ?", [$like]);
                });
            })
            ->latest()
            ->paginate(20)
            ->withQueryString();

        return view('ingresos-admision.alumnos.index', compact('alumnos', 'search'));
    }

    public function create(): View
    {
        return view('ingresos-admision.alumnos.create', [
            'tiposDocumento' => TipoDocumento::query()->where('estado', true)->orderBy('nombre')->get(),
            'colegios' => Colegio::query()->where('estado', true)->orderBy('nombre')->limit(200)->get(),
            'carreras' => Carrera::query()->where('estado', true)->orderBy('nombre')->get(),
            'ofertas' => OfertaAcademica::query()
                ->where('estado', true)
                ->whereColumn('matriculados', '<', 'capacidad')
                ->with(['cicloAcademico', 'sede', 'turno'])
                ->get(),
        ]);
    }

    public function show(Alumno $alumno): View
    {
        $alumno->load([
            'tipoDocumento',
            'apoderados.tipoDocumento',
            'colegios',
            'inscripciones.carrera',
            'inscripciones.ofertaAcademica.cicloAcademico',
            'inscripciones.ofertaAcademica.sede',
            'inscripciones.ofertaAcademica.turno',
            'matriculas.carrera',
            'matriculas.ofertaAcademica.cicloAcademico',
            'matriculas.ofertaAcademica.sede',
            'matriculas.ofertaAcademica.turno',
            'matriculas.pagos.conceptoPago',
        ]);

        return view('ingresos-admision.alumnos.show', compact('alumno'));
    }

    public function edit(Alumno $alumno): View
    {
        $alumno->load(['apoderados.tipoDocumento', 'colegios']);

        return view('ingresos-admision.alumnos.edit', [
            'alumno' => $alumno,
            'apoderado' => $alumno->apoderados->first(),
            'colegio' => $alumno->colegios->first(),
            'tiposDocumento' => TipoDocumento::query()->where('estado', true)->orderBy('nombre')->get(),
        ]);
    }

    public function store(RegistroAlumnoPrivadoRequest $request, RegistroAlumnoPrivadoService $service): RedirectResponse
    {
        $matricula = $service->registrar(
            $request->validated(),
            (int) $request->user()->id,
            $request->user()->can('registrar alumnos sin pagos'),
        );

        return redirect()
            ->route('ingresos-admision.alumnos.index')
            ->with('status', 'Alumno registrado correctamente.');
    }

    public function update(AlumnoUpdateRequest $request, Alumno $alumno, DocumentoIdentidadService $documentos): RedirectResponse
    {
        $validated = $request->validated();
        $tipo = TipoDocumento::query()->findOrFail((int) $validated['tipo_documento_id']);
        $validated['numero_documento'] = $documentos->normalizar($tipo, $validated['numero_documento']);
        $validated['nombres'] = mb_strtoupper($validated['nombres']);
        $validated['apellido_paterno'] = mb_strtoupper($validated['apellido_paterno']);
        $validated['apellido_materno'] = filled($validated['apellido_materno'] ?? null)
            ? mb_strtoupper($validated['apellido_materno'])
            : null;

        DB::transaction(function () use ($alumno, $validated, $documentos): void {
            $alumno->update([
                'tipo_documento_id' => $validated['tipo_documento_id'],
                'numero_documento' => $validated['numero_documento'],
                'nombres' => $validated['nombres'],
                'apellido_paterno' => $validated['apellido_paterno'],
                'apellido_materno' => $validated['apellido_materno'],
                'fecha_nacimiento' => $validated['fecha_nacimiento'],
                'genero' => $validated['genero'],
                'telefono' => $validated['telefono'],
                'correo' => $validated['correo'],
                'departamento' => $this->nullableTexto($validated['departamento']),
                'provincia' => $this->nullableTexto($validated['provincia']),
                'distrito' => $this->nullableTexto($validated['distrito']),
                'direccion' => $this->nullableTexto($validated['direccion']),
            ]);

            $colegio = Colegio::query()->firstOrCreate([
                'codigo_modular' => null,
                'nombre' => $this->texto($validated['colegio_nombre']),
                'departamento' => $this->nullableTexto($validated['colegio_departamento']),
                'provincia' => $this->nullableTexto($validated['colegio_provincia']),
                'distrito' => $this->nullableTexto($validated['colegio_distrito']),
            ], [
                'tipo_gestion' => null,
                'estado' => true,
            ]);

            $alumno->colegios()->sync([
                $colegio->id => [
                    'anio_egreso' => (int) $validated['anio_egreso'],
                    'es_principal' => true,
                ],
            ]);

            if (filled($validated['apoderado_numero_documento'] ?? null)) {
                $tipoApoderado = TipoDocumento::query()->findOrFail((int) $validated['apoderado_tipo_documento_id']);
                $numeroApoderado = $documentos->normalizar($tipoApoderado, $validated['apoderado_numero_documento']);
                $apoderado = Apoderado::query()->updateOrCreate(
                    ['tipo_documento_id' => $tipoApoderado->id, 'numero_documento' => $numeroApoderado],
                    [
                        'nombres' => $this->texto($validated['apoderado_nombres']),
                        'apellido_paterno' => $this->texto($validated['apoderado_apellido_paterno']),
                        'apellido_materno' => $this->nullableTexto($validated['apoderado_apellido_materno'] ?? null),
                        'telefono' => $validated['apoderado_telefono'],
                        'correo' => null,
                        'direccion' => null,
                        'estado' => 'activo',
                    ],
                );

                $alumno->apoderados()->sync([
                    $apoderado->id => [
                        'parentesco' => $validated['parentesco'],
                        'es_principal' => true,
                        'vive_con_alumno' => null,
                    ],
                ]);
            } else {
                $alumno->apoderados()->detach();
            }
        });

        return redirect()
            ->route('ingresos-admision.alumnos.show', $alumno)
            ->with('status', 'Alumno actualizado correctamente.');
    }

    private function texto(mixed $value): string
    {
        return Str::upper(trim(strip_tags((string) $value)));
    }

    private function nullableTexto(mixed $value): ?string
    {
        $value = trim(strip_tags((string) $value));

        return $value === '' ? null : Str::upper($value);
    }

    public function destroy(Alumno $alumno): RedirectResponse
    {
        $alumno->update(['estado' => EstadoAlumno::Inactivo]);

        return redirect()
            ->route('ingresos-admision.alumnos.index')
            ->with('status', 'Alumno desactivado correctamente.');
    }

    public function verificarPagos(Request $request, RegistroAlumnoPrivadoService $service, DocumentoIdentidadService $documentos): JsonResponse
    {
        $validated = $request->validate([
            'tipo_documento_id' => ['required', 'integer', 'exists:tipos_documento,id'],
            'numero_documento' => ['required', 'string', 'max:60'],
            'voucher_matricula' => ['nullable', 'string', 'max:120'],
            'agencia_matricula' => ['nullable', 'required_with:voucher_matricula', 'digits:4'],
            'fecha_pago_matricula' => ['nullable', 'required_with:voucher_matricula', 'date'],
            'voucher_pension' => ['nullable', 'string', 'max:120'],
            'agencia_pension' => ['nullable', 'required_with:voucher_pension', 'digits:4'],
            'fecha_pago_pension' => ['nullable', 'required_with:voucher_pension', 'date'],
        ]);

        $tipo = TipoDocumento::query()->findOrFail((int) $validated['tipo_documento_id']);
        $numero = $documentos->normalizar($tipo, $validated['numero_documento']);
        $items = [];

        foreach ([
            'MATRICULA' => ['voucher_matricula', 'agencia_matricula', 'fecha_pago_matricula'],
            'PENSION' => ['voucher_pension', 'agencia_pension', 'fecha_pago_pension'],
        ] as $concepto => [$voucherField, $agenciaField, $fechaField]) {
            if (blank($validated[$voucherField] ?? null)) {
                $items[] = "{$concepto}: pendiente, no ingresaste voucher.";
                continue;
            }

            try {
                $pago = $service->verificarPagoDisponible(
                    $numero,
                    $concepto,
                    $validated[$voucherField],
                    $validated[$agenciaField] ?? null,
                    $validated[$fechaField] ?? null,
                );
                $items[] = $pago
                    ? "{$concepto}: pago encontrado y disponible."
                    : "{$concepto}: pendiente.";
            } catch (\Throwable $e) {
                $items[] = "{$concepto}: {$e->getMessage()}";
            }
        }

        $ok = collect($items)->contains(fn (string $item): bool => str_contains($item, 'encontrado'));

        return response()->json([
            'ok' => $ok,
            'message' => $ok ? 'Verificacion realizada.' : 'No se encontraron pagos disponibles.',
            'items' => $items,
        ]);
    }
}
