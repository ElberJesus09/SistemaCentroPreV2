<?php

namespace App\Policies;

use App\Models\ImportacionPago;
use App\Models\User;

class ImportacionPagoPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->can('ver importaciones de pagos');
    }

    public function view(User $user, ImportacionPago $importacionPago): bool
    {
        return $user->can('ver detalles de importacion');
    }

    public function create(User $user): bool
    {
        return $user->can('importar pagos');
    }

    public function download(User $user, ImportacionPago $importacionPago): bool
    {
        return $user->can('descargar archivos de pagos');
    }
}
