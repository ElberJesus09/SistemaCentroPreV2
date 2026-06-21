<?php

namespace App\Enums\IngresosAdmision\Alumnos;

enum EstadoAlumno: string
{
    case Pendiente = 'pendiente';
    case Activo = 'activo';
    case Rechazado = 'rechazado';
    case Inactivo = 'inactivo';
}
