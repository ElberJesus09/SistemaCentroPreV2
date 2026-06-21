<?php

namespace App\Enums\IngresosAdmision\Alumnos;

enum EstadoInscripcion: string
{
    case Pendiente = 'pendiente';
    case PendientePagos = 'pendiente_pagos';
    case Observada = 'observada';
    case Aprobada = 'aprobada';
    case Rechazada = 'rechazada';
}
