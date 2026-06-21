<?php

namespace App\Enums\IngresosAdmision\Pagos;

enum EstadoDetalleImportacionPago: string
{
    case Pendiente = 'pendiente';
    case Procesada = 'procesada';
    case Observada = 'observada';
    case Ignorada = 'ignorada';
}
