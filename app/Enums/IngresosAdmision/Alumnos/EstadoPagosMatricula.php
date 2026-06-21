<?php

namespace App\Enums\IngresosAdmision\Alumnos;

enum EstadoPagosMatricula: string
{
    case Completo = 'completo';
    case PendienteMatricula = 'pendiente_matricula';
    case PendientePension = 'pendiente_pension';
    case PendienteAmbos = 'pendiente_ambos';
}
