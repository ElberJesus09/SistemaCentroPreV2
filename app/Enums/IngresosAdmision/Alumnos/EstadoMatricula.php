<?php

namespace App\Enums\IngresosAdmision\Alumnos;

enum EstadoMatricula: string
{
    case Pendiente = 'pendiente';
    case PendientePagoMatricula = 'pendiente_pago_matricula';
    case PendientePagoPension = 'pendiente_pago_pension';
    case PendientePagos = 'pendiente_pagos';
    case Activa = 'activa';
    case Anulada = 'anulada';
    case Finalizada = 'finalizada';
}
