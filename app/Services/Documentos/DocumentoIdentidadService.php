<?php

namespace App\Services\Documentos;

use App\Models\TipoDocumento;
use InvalidArgumentException;

class DocumentoIdentidadService
{
    public function normalizar(TipoDocumento $tipoDocumento, mixed $numeroDocumento): string
    {
        $numero = strtoupper(trim((string) $numeroDocumento));

        if ($numero === '') {
            throw new InvalidArgumentException('El numero de documento es obligatorio.');
        }

        $longitud = strlen($numero);
        if ($tipoDocumento->longitud_minima !== null && $longitud < $tipoDocumento->longitud_minima) {
            throw new InvalidArgumentException("El documento debe tener al menos {$tipoDocumento->longitud_minima} caracteres.");
        }

        if ($tipoDocumento->longitud_maxima !== null && $longitud > $tipoDocumento->longitud_maxima) {
            throw new InvalidArgumentException("El documento debe tener como maximo {$tipoDocumento->longitud_maxima} caracteres.");
        }

        if ($tipoDocumento->codigo === 'CE' && ! preg_match('/^(?:[0-9]{9}|N[0-9]{8})$/', $numero)) {
            throw new InvalidArgumentException('El carne de extranjeria debe tener 9 digitos o iniciar con N seguida de 8 digitos.');
        }

        if ($tipoDocumento->es_numerico && ! preg_match('/^[0-9]+$/', $numero)) {
            throw new InvalidArgumentException('El documento debe contener solo numeros.');
        }

        if (! $tipoDocumento->es_numerico && $tipoDocumento->permite_letras && ! preg_match('/^[A-Z0-9]+$/', $numero)) {
            throw new InvalidArgumentException('El documento debe contener solo letras y numeros.');
        }

        return $numero;
    }
}
