<?php

namespace App\Services\IngresosAdmision\Pagos;

use App\Enums\IngresosAdmision\Alumnos\EstadoMatricula;
use App\Enums\IngresosAdmision\Alumnos\EstadoPagosMatricula;
use App\Enums\IngresosAdmision\Pagos\EstadoDetalleImportacionPago;
use App\Enums\IngresosAdmision\Pagos\EstadoPago;
use App\Models\Alumno;
use App\Models\CanalPago;
use App\Models\ImportacionPago;
use App\Models\ImportacionPagoDetalle;
use App\Models\Matricula;
use App\Models\Pago;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Throwable;

class ProcesamientoFilaPagoService
{
    public function __construct(
        private readonly NormalizacionDocumentoService $documentos,
        private readonly MapeoCodigoPagoService $mapeo,
    ) {}

    /**
     * @param  array<string, mixed>  $datos
     */
    public function process(ImportacionPago $importacion, int $numeroFila, array $datos): ImportacionPagoDetalle
    {
        return DB::transaction(function () use ($importacion, $numeroFila, $datos): ImportacionPagoDetalle {
            $detalle = ImportacionPagoDetalle::query()->create([
                'importacion_pago_id' => $importacion->id,
                'numero_fila' => $numeroFila,
                'datos_origen' => $datos,
                'estado' => EstadoDetalleImportacionPago::Pendiente,
            ]);

            return $this->processExisting($detalle);
        });
    }

    public function processExisting(ImportacionPagoDetalle $detalle): ImportacionPagoDetalle
    {
        return DB::transaction(function () use ($detalle): ImportacionPagoDetalle {
            $detalle->refresh();
            if ($detalle->pago_id !== null) {
                return $detalle;
            }

            $importacion = $detalle->importacionPago()->with('canalPago')->firstOrFail();
            $datos = $detalle->datos_origen ?? [];

            try {
                $resultado = $this->preview($importacion->canalPago, $importacion->fecha_referencia, $datos);

                $detalle->fill([
                    'tipo_documento' => $resultado['tipo_documento'],
                    'numero_documento' => $resultado['numero_documento'],
                    'voucher' => $resultado['voucher'],
                    'fecha_pago' => $resultado['fecha_pago'],
                    'agencia' => $resultado['agencia'],
                    'codigo_pago' => $resultado['codigo_pago'],
                    'estado' => EstadoDetalleImportacionPago::Procesada,
                    'mensaje' => $resultado['mensaje'],
                ]);
                $detalle->save();

                $pago = Pago::query()->create([
                    'tipo_documento' => $resultado['tipo_documento'],
                    'numero_documento' => $resultado['numero_documento'],
                    'voucher' => $resultado['voucher'],
                    'fecha_pago' => $resultado['fecha_pago'],
                    'agencia' => $resultado['agencia'],
                    'concepto_pago_id' => $resultado['concepto_pago_id'],
                    'canal_pago_id' => $importacion->canal_pago_id,
                    'importacion_pago_detalle_id' => $detalle->id,
                    'estado' => EstadoPago::Disponible,
                    'observacion' => $resultado['mensaje'],
                ]);

                $detalle->update(['pago_id' => $pago->id]);
                $this->associatePaymentIfPossible($pago);

                return $detalle->fresh();
            } catch (Throwable $e) {
                $detalle->update([
                    'estado' => EstadoDetalleImportacionPago::Observada,
                    'mensaje' => $e->getMessage(),
                    'tipo_documento' => $this->documentos->normalizeTipo((string) $this->first($datos, ['NOMBRE_TDOC', 'CODIGO_TDOC', 'CODIGO_TIPO_DOCUMENTO', 'TIPO_DOCUMENTO', 'TIPO_DOC'])),
                    'numero_documento' => $this->nullableString($this->first($datos, ['DOCUMENTO', 'NRO_DOCUMENTO', 'NUMERO_DOCUMENTO', 'COD_ALUMNO'])),
                    'voucher' => $this->nullableString($this->first($datos, ['VOUCHER', 'NRO_OPERACION', 'NUMERO_OPERACION'])),
                    'codigo_pago' => $this->nullableString($this->first($datos, ['COD_PAGO', 'CODIGO_PAGO', 'CONCEPTO_PAGO'])),
                    'agencia' => $this->nullableString($this->first($datos, ['AGENCIA', 'AGE', 'AGE_'])),
                ]);

                return $detalle->fresh();
            }
        });
    }

    /**
     * @param  array<string, mixed>  $datos
     * @return array{
     *     estado:string,
     *     mensaje:?string,
     *     tipo_documento:?string,
     *     numero_documento:?string,
     *     voucher:?string,
     *     codigo_pago:?string,
     *     fecha_pago:?string,
     *     agencia:?string,
     *     concepto_pago_id:?int
     * }
     */
    public function preview(CanalPago $canal, Carbon $fechaReferencia, array $datos): array
    {
        try {
            $tipoFuente = $this->first($datos, ['NOMBRE_TDOC', 'CODIGO_TDOC', 'CODIGO_TIPO_DOCUMENTO', 'TIPO_DOCUMENTO', 'TIPO_DOC']);
            $documento = $this->first($datos, ['DOCUMENTO', 'NRO_DOCUMENTO', 'NUMERO_DOCUMENTO', 'COD_ALUMNO']);
            $normalizado = $this->documentos->normalize(is_string($tipoFuente) ? $tipoFuente : null, $documento);
            $voucher = $this->requiredString($this->first($datos, ['VOUCHER', 'NRO_OPERACION', 'NUMERO_OPERACION']), 'Voucher vacio.');
            $codigoPago = strtoupper($this->requiredString($this->first($datos, ['COD_PAGO', 'CODIGO_PAGO', 'CONCEPTO_PAGO']), 'Codigo externo vacio.'));
            $fecha = $this->dateValue($this->first($datos, ['FECHA_PAGO', 'FECHA']));
            $mensaje = null;

            if ($fecha === null) {
                $fecha = $fechaReferencia->copy();
            } elseif (! $fecha->isSameDay($fechaReferencia)) {
                $mensaje = 'Advertencia: la fecha de pago no coincide con la fecha de referencia.';
            }

            $concepto = $this->mapeo->conceptoPara((int) $canal->id, $codigoPago);
            $agencia = $this->nullableString($this->first($datos, ['AGENCIA', 'AGE', 'AGE_']));
            if ($canal->codigo === 'BANCO_NACION' && $agencia === null) {
                throw new \InvalidArgumentException('Agencia requerida para Banco de la Nacion.');
            }

            if (Pago::query()->where('canal_pago_id', $canal->id)->where('voucher', $voucher)->exists()) {
                throw new \InvalidArgumentException('Voucher duplicado para el canal seleccionado.');
            }

            return [
                'estado' => EstadoDetalleImportacionPago::Procesada->value,
                'mensaje' => $mensaje,
                'tipo_documento' => $normalizado['tipo'],
                'numero_documento' => $normalizado['numero'],
                'voucher' => $voucher,
                'codigo_pago' => $codigoPago,
                'fecha_pago' => $fecha->toDateString(),
                'agencia' => $agencia,
                'concepto_pago_id' => $concepto->id,
            ];
        } catch (Throwable $e) {
            return [
                'estado' => EstadoDetalleImportacionPago::Observada->value,
                'mensaje' => $e->getMessage(),
                'tipo_documento' => $this->documentos->normalizeTipo((string) $this->first($datos, ['NOMBRE_TDOC', 'CODIGO_TDOC', 'CODIGO_TIPO_DOCUMENTO', 'TIPO_DOCUMENTO', 'TIPO_DOC'])),
                'numero_documento' => $this->nullableString($this->first($datos, ['DOCUMENTO', 'NRO_DOCUMENTO', 'NUMERO_DOCUMENTO', 'COD_ALUMNO'])),
                'voucher' => $this->nullableString($this->first($datos, ['VOUCHER', 'NRO_OPERACION', 'NUMERO_OPERACION'])),
                'codigo_pago' => $this->nullableString($this->first($datos, ['COD_PAGO', 'CODIGO_PAGO', 'CONCEPTO_PAGO'])),
                'fecha_pago' => null,
                'agencia' => $this->nullableString($this->first($datos, ['AGENCIA', 'AGE', 'AGE_'])),
                'concepto_pago_id' => null,
            ];
        }
    }

    /**
     * @param  array<string, mixed>  $datos
     * @param  list<string>  $keys
     */
    private function first(array $datos, array $keys): mixed
    {
        foreach ($keys as $key) {
            if (array_key_exists($key, $datos) && trim((string) $datos[$key]) !== '') {
                return $datos[$key];
            }
        }

        return null;
    }

    private function requiredString(mixed $value, string $message): string
    {
        $value = trim((string) $value);
        if ($value === '') {
            throw new \InvalidArgumentException($message);
        }

        return $value;
    }

    private function nullableString(mixed $value): ?string
    {
        $value = trim((string) $value);

        return $value === '' ? null : $value;
    }

    private function associatePaymentIfPossible(Pago $pago): void
    {
        if ($pago->fecha_pago->greaterThan(Carbon::create(2026, 6, 21))) {
            return;
        }

        $conceptoCodigo = $pago->conceptoPago()->value('codigo');
        if (! in_array($conceptoCodigo, ['MATRICULA', 'PENSION'], true)) {
            return;
        }

        $alumno = Alumno::query()
            ->where('numero_documento', $pago->numero_documento)
            ->whereHas('tipoDocumento', fn ($query) => $query->where('codigo', $pago->tipo_documento))
            ->first();

        if ($alumno === null) {
            return;
        }

        $matricula = Matricula::query()
            ->where('alumno_id', $alumno->id)
            ->latest('fecha_matricula')
            ->latest('id')
            ->first();

        if ($matricula === null) {
            return;
        }

        $conceptoYaAsociado = Pago::query()
            ->where('matricula_id', $matricula->id)
            ->where('concepto_pago_id', $pago->concepto_pago_id)
            ->whereKeyNot($pago->id)
            ->exists();

        if ($conceptoYaAsociado) {
            return;
        }

        $pago->update([
            'inscripcion_id' => $matricula->inscripcion_id,
            'matricula_id' => $matricula->id,
            'asociado_at' => now(),
            'estado' => EstadoPago::Asociado,
            'observacion' => trim((string) $pago->observacion."\nAsociado automaticamente por DNI al importar el pago."),
        ]);

        $this->refreshMatriculaPaymentState($matricula);
    }

    private function refreshMatriculaPaymentState(Matricula $matricula): void
    {
        $conceptos = Pago::query()
            ->where('matricula_id', $matricula->id)
            ->where('estado', EstadoPago::Asociado)
            ->whereHas('conceptoPago', fn ($query) => $query->whereIn('codigo', ['MATRICULA', 'PENSION']))
            ->with('conceptoPago')
            ->get()
            ->pluck('conceptoPago.codigo')
            ->all();

        $hasMatricula = in_array('MATRICULA', $conceptos, true);
        $hasPension = in_array('PENSION', $conceptos, true);

        $matricula->update([
            'estado' => match (true) {
                $hasMatricula && $hasPension => EstadoMatricula::Activa,
                $hasMatricula => EstadoMatricula::PendientePagoPension,
                $hasPension => EstadoMatricula::PendientePagoMatricula,
                default => EstadoMatricula::PendientePagos,
            },
            'estado_pagos' => match (true) {
                $hasMatricula && $hasPension => EstadoPagosMatricula::Completo,
                $hasMatricula => EstadoPagosMatricula::PendientePension,
                $hasPension => EstadoPagosMatricula::PendienteMatricula,
                default => EstadoPagosMatricula::PendienteAmbos,
            },
            'activado_at' => $hasMatricula && $hasPension ? ($matricula->activado_at ?? now()) : null,
        ]);
    }

    private function dateValue(mixed $value): ?Carbon
    {
        $value = trim((string) $value);
        if ($value === '') {
            return null;
        }

        if (is_numeric($value)) {
            return Carbon::create(1899, 12, 30)->addDays((int) $value);
        }

        foreach (['Y-m-d', 'd/m/Y', 'd-m-Y', 'm/d/Y'] as $format) {
            try {
                $date = Carbon::createFromFormat($format, $value);
                if ($date !== false) {
                    return $date;
                }
            } catch (\Throwable) {
                // Intentar con el siguiente formato.
            }
        }

        try {
            return Carbon::parse($value);
        } catch (\Throwable) {
            throw new \InvalidArgumentException('Fecha invalida.');
        }
    }
}
