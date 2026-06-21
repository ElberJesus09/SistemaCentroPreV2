<?php

namespace App\Enums\IngresosAdmision\Pagos;

enum EstadoImportacionPago: string
{
    case Pendiente = 'pendiente';
    case Procesando = 'procesando';
    case Procesada = 'procesada';
    case ProcesadaConObservaciones = 'procesada_con_observaciones';
    case Fallida = 'fallida';
}
