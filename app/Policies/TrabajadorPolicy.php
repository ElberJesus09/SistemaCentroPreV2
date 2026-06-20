<?php

namespace App\Policies;

use App\Models\Trabajador;
use App\Models\User;

class TrabajadorPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->can('ver trabajadores');
    }

    public function view(User $user, Trabajador $trabajador): bool
    {
        return $user->can('ver trabajadores');
    }

    public function create(User $user): bool
    {
        return $user->can('crear trabajadores');
    }

    public function update(User $user, Trabajador $trabajador): bool
    {
        return $user->can('editar trabajadores');
    }

    public function delete(User $user, Trabajador $trabajador): bool
    {
        return $user->can('eliminar trabajadores');
    }
}
