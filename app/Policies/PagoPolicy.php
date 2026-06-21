<?php

namespace App\Policies;

use App\Models\Pago;
use App\Models\User;

class PagoPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->can('ver pagos');
    }

    public function view(User $user, Pago $pago): bool
    {
        return $user->can('ver pagos');
    }
}
