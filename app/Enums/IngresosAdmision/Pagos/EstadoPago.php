<?php

namespace App\Enums\IngresosAdmision\Pagos;

enum EstadoPago: string
{
    case Importado = 'importado';
    case Disponible = 'disponible';
    case Observado = 'observado';
    case Rechazado = 'rechazado';
    case Anulado = 'anulado';
    case Reservado = 'reservado';
    case Asociado = 'asociado';
}
