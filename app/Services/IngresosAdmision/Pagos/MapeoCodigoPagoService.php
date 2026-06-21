<?php

namespace App\Services\IngresosAdmision\Pagos;

use App\Models\CodigoPagoExterno;
use App\Models\ConceptoPago;
use InvalidArgumentException;

class MapeoCodigoPagoService
{
    public function conceptoPara(int $canalPagoId, mixed $codigoExterno): ConceptoPago
    {
        $codigo = strtoupper(trim((string) $codigoExterno));
        if ($codigo === '') {
            throw new InvalidArgumentException('Codigo externo vacio.');
        }

        $map = CodigoPagoExterno::query()
            ->with('conceptoPago')
            ->where('canal_pago_id', $canalPagoId)
            ->where('codigo_externo', $codigo)
            ->where('estado', true)
            ->first();

        if (! $map && ctype_digit($codigo)) {
            $codigoSinCeros = ltrim($codigo, '0');
            $map = CodigoPagoExterno::query()
                ->with('conceptoPago')
                ->where('canal_pago_id', $canalPagoId)
                ->where('estado', true)
                ->get()
                ->first(fn (CodigoPagoExterno $item): bool => ltrim($item->codigo_externo, '0') === $codigoSinCeros);
        }

        if (! $map || ! $map->conceptoPago || ! $map->conceptoPago->estado) {
            throw new InvalidArgumentException("Codigo externo desconocido: {$codigo}.");
        }

        return $map->conceptoPago;
    }
}
