<?php

namespace App\Services\IngresosAdmision\Pagos\Readers;

interface PaymentFileReaderInterface
{
    /**
     * @return array<int, array{numero_fila: int, datos: array<string, mixed>}>
     */
    public function read(string $path): array;
}
