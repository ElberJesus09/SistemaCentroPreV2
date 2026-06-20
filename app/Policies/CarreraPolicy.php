<?php

namespace App\Policies;

use App\Models\Carrera;
use App\Models\User;

class CarreraPolicy
{
    public function viewAny(User $user): bool { return $user->can('ver carreras'); }
    public function view(User $user, Carrera $carrera): bool { return $user->can('ver carreras'); }
    public function create(User $user): bool { return $user->can('crear carreras'); }
    public function update(User $user, Carrera $carrera): bool { return $user->can('editar carreras'); }
    public function delete(User $user, Carrera $carrera): bool { return $user->can('eliminar carreras'); }
}
