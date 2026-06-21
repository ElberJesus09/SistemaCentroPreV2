<?php

namespace App\Policies;

use App\Models\CodigoPagoExterno;
use App\Models\User;

class CodigoPagoExternoPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->can('gestionar codigos externos de pago');
    }

    public function create(User $user): bool
    {
        return $user->can('gestionar codigos externos de pago');
    }

    public function update(User $user, CodigoPagoExterno $codigoPagoExterno): bool
    {
        return $user->can('gestionar codigos externos de pago');
    }

    public function delete(User $user, CodigoPagoExterno $codigoPagoExterno): bool
    {
        return $user->can('gestionar codigos externos de pago');
    }
}
