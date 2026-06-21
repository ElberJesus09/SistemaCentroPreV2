<?php

namespace App\Services\IngresosAdmision\Alumnos;

use App\Enums\IngresosAdmision\Alumnos\EstadoAlumno;
use App\Enums\IngresosAdmision\Alumnos\EstadoInscripcion;
use App\Enums\IngresosAdmision\Alumnos\EstadoMatricula;
use App\Enums\IngresosAdmision\Alumnos\EstadoPagosMatricula;
use App\Enums\IngresosAdmision\Pagos\EstadoPago;
use App\Models\Alumno;
use App\Models\Apoderado;
use App\Models\Colegio;
use App\Models\ConceptoPago;
use App\Models\Inscripcion;
use App\Models\Matricula;
use App\Models\OfertaAcademica;
use App\Models\Pago;
use App\Models\TipoDocumento;
use App\Services\Documentos\DocumentoIdentidadService;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class RegistroAlumnoPrivadoService
{
    public function __construct(
        private readonly DocumentoIdentidadService $documentos,
        private readonly ReglaApoderadoService $reglaApoderado,
    ) {}

    /**
     * @param  array<string, mixed>  $data
     */
    public function registrar(array $data, int $userId, bool $puedeRegistrarSinPagos): Matricula
    {
        return DB::transaction(function () use ($data, $userId, $puedeRegistrarSinPagos): Matricula {
            $oferta = OfertaAcademica::query()->lockForUpdate()->findOrFail((int) $data['oferta_academica_id']);
            $this->assertOfertaDisponible($oferta);

            $tipoDocumento = TipoDocumento::query()->findOrFail((int) $data['tipo_documento_id']);
            $numeroDocumento = $this->documentos->normalizar($tipoDocumento, $data['numero_documento']);
            $pagoMatricula = $this->buscarPagoDisponible($numeroDocumento, 'MATRICULA', $data['voucher_matricula'] ?? null, $data['agencia_matricula'] ?? null, $data['fecha_pago_matricula'] ?? null);
            $pagoPension = $this->buscarPagoDisponible($numeroDocumento, 'PENSION', $data['voucher_pension'] ?? null, $data['agencia_pension'] ?? null, $data['fecha_pago_pension'] ?? null);

            if (! $pagoMatricula && ! $pagoPension && ! $puedeRegistrarSinPagos) {
                throw ValidationException::withMessages([
                    'voucher_matricula' => ['No hay pagos disponibles. Se necesita permiso para registrar alumnos sin pagos.'],
                ]);
            }

            $this->assertAlumnoSinInscripcionEnCiclo($numeroDocumento, (int) $tipoDocumento->id, (int) $oferta->ciclo_academico_id);

            $alumno = Alumno::query()->firstOrNew([
                'tipo_documento_id' => $tipoDocumento->id,
                'numero_documento' => $numeroDocumento,
            ]);

            if (! $alumno->exists) {
                $alumno->codigo = $this->codigoAlumno();
            }

            $alumno->fill([
                'nombres' => $this->texto($data['nombres']),
                'apellido_paterno' => $this->texto($data['apellido_paterno']),
                'apellido_materno' => $this->nullableTexto($data['apellido_materno'] ?? null),
                'fecha_nacimiento' => $data['fecha_nacimiento'],
                'genero' => $data['genero'],
                'telefono' => $data['telefono'] ?? null,
                'correo' => $data['correo'] ?? null,
                'departamento' => $this->nullableTexto($data['departamento'] ?? null),
                'provincia' => $this->nullableTexto($data['provincia'] ?? null),
                'distrito' => $this->nullableTexto($data['distrito'] ?? null),
                'direccion' => $this->nullableTexto($data['direccion'] ?? null),
                'estado' => EstadoAlumno::Activo,
                'registrado_por' => $userId,
            ])->save();

            $colegio = $this->resolverColegio($data);
            $alumno->colegios()->syncWithoutDetaching([
                $colegio->id => [
                    'anio_egreso' => (int) $data['anio_egreso'],
                    'es_principal' => true,
                ],
            ]);

            if ($this->reglaApoderado->requiereApoderado((string) $data['fecha_nacimiento']) || filled($data['apoderado_numero_documento'] ?? null)) {
                $apoderado = $this->resolverApoderado($data);
                $alumno->apoderados()->syncWithoutDetaching([
                    $apoderado->id => [
                        'parentesco' => $data['parentesco'],
                        'es_principal' => true,
                        'vive_con_alumno' => null,
                    ],
                ]);
            }

            [$estadoInscripcion, $estadoMatricula, $estadoPagos] = $this->estadosPorPagos($pagoMatricula, $pagoPension);

            $inscripcion = Inscripcion::query()->create([
                'codigo' => $this->codigo('INS'),
                'alumno_id' => $alumno->id,
                'oferta_academica_id' => $oferta->id,
                'carrera_id' => (int) $data['carrera_id'],
                'colegio_id' => $colegio->id,
                'fecha_inscripcion' => now()->toDateString(),
                'estado' => $estadoInscripcion,
                'observacion' => $data['observacion'] ?? null,
                'registrado_por' => $userId,
            ]);

            $matricula = Matricula::query()->create([
                'codigo' => $this->codigo('MAT'),
                'alumno_id' => $alumno->id,
                'inscripcion_id' => $inscripcion->id,
                'oferta_academica_id' => $oferta->id,
                'carrera_id' => (int) $data['carrera_id'],
                'fecha_matricula' => now()->toDateString(),
                'estado' => $estadoMatricula,
                'estado_pagos' => $estadoPagos,
                'registrado_por' => $userId,
                'activado_at' => $estadoMatricula === EstadoMatricula::Activa ? now() : null,
            ]);

            foreach ([$pagoMatricula, $pagoPension] as $pago) {
                if ($pago) {
                    $pago->update([
                        'inscripcion_id' => $inscripcion->id,
                        'matricula_id' => $matricula->id,
                        'asociado_at' => now(),
                        'asociado_por' => $userId,
                        'estado' => EstadoPago::Asociado,
                    ]);
                }
            }

            $oferta->increment('matriculados');

            return $matricula->fresh(['alumno.tipoDocumento', 'inscripcion', 'ofertaAcademica.cicloAcademico', 'ofertaAcademica.sede', 'ofertaAcademica.turno', 'carrera', 'pagos.conceptoPago']);
        });
    }

    public function verificarPagoDisponible(string $numeroDocumento, string $conceptoCodigo, mixed $voucher, mixed $agencia, mixed $fecha): ?Pago
    {
        return $this->buscarPagoDisponible($numeroDocumento, $conceptoCodigo, $voucher, $agencia, $fecha);
    }

    private function buscarPagoDisponible(string $numeroDocumento, string $conceptoCodigo, mixed $voucher, mixed $agencia, mixed $fecha): ?Pago
    {
        $voucher = trim((string) $voucher);
        if ($voucher === '') {
            return null;
        }
        $agencia = trim((string) $agencia);
        $fecha = trim((string) $fecha);

        $concepto = ConceptoPago::query()->where('codigo', $conceptoCodigo)->firstOrFail();
        $pago = Pago::query()
            ->where('numero_documento', $numeroDocumento)
            ->where('voucher', $voucher)
            ->where('agencia', $agencia)
            ->whereDate('fecha_pago', $fecha)
            ->where('concepto_pago_id', $concepto->id)
            ->lockForUpdate()
            ->first();

        if (! $pago) {
            throw ValidationException::withMessages([
                $conceptoCodigo === 'MATRICULA' ? 'voucher_matricula' : 'voucher_pension' => ["No se encontro pago disponible de {$conceptoCodigo} con ese voucher, agencia y fecha."],
            ]);
        }

        if ($pago->estado !== EstadoPago::Disponible) {
            throw ValidationException::withMessages([
                $conceptoCodigo === 'MATRICULA' ? 'voucher_matricula' : 'voucher_pension' => ["El pago de {$conceptoCodigo} ya no esta disponible."],
            ]);
        }

        return $pago;
    }

    private function assertOfertaDisponible(OfertaAcademica $oferta): void
    {
        if (! $oferta->estado || $oferta->matriculados >= $oferta->capacidad) {
            throw ValidationException::withMessages([
                'oferta_academica_id' => ['La oferta no esta activa o no tiene vacantes disponibles.'],
            ]);
        }
    }

    private function assertAlumnoSinInscripcionEnCiclo(string $numero, int $tipoId, int $cicloId): void
    {
        $existe = Alumno::query()
            ->where('tipo_documento_id', $tipoId)
            ->where('numero_documento', $numero)
            ->whereHas('inscripciones.ofertaAcademica', fn ($query) => $query->where('ciclo_academico_id', $cicloId))
            ->exists();

        if ($existe) {
            throw ValidationException::withMessages([
                'numero_documento' => ['El alumno ya tiene una inscripcion en este ciclo academico.'],
            ]);
        }
    }

    private function resolverColegio(array $data): Colegio
    {
        $attributes = [
            'nombre' => $this->texto($data['colegio_nombre']),
            'tipo_gestion' => null,
            'departamento' => $this->nullableTexto($data['colegio_departamento'] ?? null),
            'provincia' => $this->nullableTexto($data['colegio_provincia'] ?? null),
            'distrito' => $this->nullableTexto($data['colegio_distrito'] ?? null),
            'estado' => true,
        ];

        return Colegio::query()->firstOrCreate([
            'codigo_modular' => null,
            'nombre' => $attributes['nombre'],
            'departamento' => $attributes['departamento'],
            'provincia' => $attributes['provincia'],
            'distrito' => $attributes['distrito'],
        ], $attributes);
    }

    private function resolverApoderado(array $data): Apoderado
    {
        $tipo = TipoDocumento::query()->findOrFail((int) $data['apoderado_tipo_documento_id']);
        $numero = $this->documentos->normalizar($tipo, $data['apoderado_numero_documento']);

        return Apoderado::query()->updateOrCreate(
            ['tipo_documento_id' => $tipo->id, 'numero_documento' => $numero],
            [
                'nombres' => $this->texto($data['apoderado_nombres']),
                'apellido_paterno' => $this->texto($data['apoderado_apellido_paterno']),
                'apellido_materno' => $this->nullableTexto($data['apoderado_apellido_materno'] ?? null),
                'telefono' => $data['apoderado_telefono'],
                'correo' => null,
                'direccion' => null,
                'estado' => 'activo',
            ],
        );
    }

    private function estadosPorPagos(?Pago $matricula, ?Pago $pension): array
    {
        return match (true) {
            $matricula && $pension => [EstadoInscripcion::Aprobada, EstadoMatricula::Activa, EstadoPagosMatricula::Completo],
            $matricula !== null => [EstadoInscripcion::PendientePagos, EstadoMatricula::PendientePagoPension, EstadoPagosMatricula::PendientePension],
            $pension !== null => [EstadoInscripcion::Observada, EstadoMatricula::PendientePagoMatricula, EstadoPagosMatricula::PendienteMatricula],
            default => [EstadoInscripcion::PendientePagos, EstadoMatricula::PendientePagos, EstadoPagosMatricula::PendienteAmbos],
        };
    }

    private function codigo(string $prefijo): string
    {
        return $prefijo.'-'.now()->format('YmdHis').'-'.Str::upper(Str::random(4));
    }

    private function codigoAlumno(): string
    {
        $ultimo = Alumno::query()
            ->lockForUpdate()
            ->whereNotNull('codigo')
            ->max('codigo');

        return str_pad(((int) $ultimo) + 1, 6, '0', STR_PAD_LEFT);
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
}
