<?php

namespace App\Services\IngresosAdmision\Pagos;

use InvalidArgumentException;

class NormalizacionDocumentoService
{
    /**
     * @return array{tipo: string, numero: string}
     */
    public function normalize(?string $tipoRecibido, mixed $documento): array
    {
        $tipo = $this->normalizeTipo($tipoRecibido);
        $numero = trim((string) $documento);

        if ($tipo === '') {
            throw new InvalidArgumentException('Tipo de documento vacio.');
        }

        if ($numero === '') {
            throw new InvalidArgumentException('Documento vacio.');
        }

        if ($tipo === 'DNI') {
            return ['tipo' => $tipo, 'numero' => $this->normalizeDni($numero)];
        }

        $numero = strtoupper(preg_replace('/\s+/', '', $numero) ?? '');
        if (! preg_match('/^[A-Z0-9-]+$/', $numero)) {
            throw new InvalidArgumentException('Documento invalido.');
        }

        return ['tipo' => $tipo, 'numero' => $numero];
    }

    public function normalizeTipo(?string $tipo): string
    {
        $tipo = strtoupper(trim((string) $tipo));

        return match (true) {
            $tipo === '1', str_contains($tipo, 'DNI') => 'DNI',
            str_contains($tipo, 'EXTRANJ') || str_contains($tipo, 'CARN') => 'CARNET_EXTRANJERIA',
            str_contains($tipo, 'PASAP') => 'PASAPORTE',
            default => $tipo,
        };
    }

    private function normalizeDni(string $numero): string
    {
        $numero = preg_replace('/\s+/', '', $numero) ?? '';

        if (! preg_match('/^\d{8,}$/', $numero)) {
            throw new InvalidArgumentException('DNI invalido.');
        }

        if (strlen($numero) === 8) {
            return $numero;
        }

        $dni = substr($numero, 0, 8);
        $tail = substr($numero, 8);

        if ($tail !== '' && preg_match('/^0+$/', $tail)) {
            return $dni;
        }

        throw new InvalidArgumentException('DNI no normalizable.');
    }
}
