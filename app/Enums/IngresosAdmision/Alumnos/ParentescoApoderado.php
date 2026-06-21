<?php

namespace App\Enums\IngresosAdmision\Alumnos;

enum ParentescoApoderado: string
{
    case Padre = 'padre';
    case Madre = 'madre';
    case Tio = 'tio';
    case Tia = 'tia';
    case Hermano = 'hermano';
    case Hermana = 'hermana';
    case Tutor = 'tutor';
    case Otro = 'otro';
}
