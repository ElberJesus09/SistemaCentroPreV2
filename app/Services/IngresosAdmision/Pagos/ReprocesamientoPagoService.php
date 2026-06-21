<?php

namespace App\Services\IngresosAdmision\Pagos;

use App\Enums\IngresosAdmision\Pagos\EstadoDetalleImportacionPago;
use App\Models\ImportacionPagoDetalle;
use Illuminate\Validation\ValidationException;

class ReprocesamientoPagoService
{
    public function __construct(
        private readonly ProcesamientoFilaPagoService $filas,
        private readonly ImportacionPagoService $importaciones,
    ) {}

    public function reprocess(ImportacionPagoDetalle $detalle): ImportacionPagoDetalle
    {
        if ($detalle->pago_id !== null) {
            throw ValidationException::withMessages([
                'detalle' => ['Este detalle ya genero un pago.'],
            ]);
        }

        if (! in_array($detalle->estado, [EstadoDetalleImportacionPago::Pendiente, EstadoDetalleImportacionPago::Observada], true)) {
            throw ValidationException::withMessages([
                'detalle' => ['Solo se pueden reprocesar detalles pendientes u observados.'],
            ]);
        }

        $detalle = $this->filas->processExisting($detalle);
        $this->importaciones->refreshCounters($detalle->importacionPago);

        return $detalle;
    }
}
