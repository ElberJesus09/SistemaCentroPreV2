<?php

namespace App\Policies;

use App\Models\User;

class UserPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->can('ver usuarios');
    }

    public function view(User $user, User $usuario): bool
    {
        return $user->can('ver usuarios');
    }

    public function create(User $user): bool
    {
        return $user->can('crear usuarios');
    }

    public function update(User $user, User $usuario): bool
    {
        return $user->can('editar usuarios');
    }

    public function delete(User $user, User $usuario): bool
    {
        return $user->can('eliminar usuarios') && $user->isNot($usuario);
    }
}
