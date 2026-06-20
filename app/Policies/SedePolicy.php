<?php

namespace App\Policies;

use App\Models\Sede;
use App\Models\User;

class SedePolicy
{
    public function viewAny(User $user): bool { return $user->can('ver sedes'); }
    public function view(User $user, Sede $sede): bool { return $user->can('ver sedes'); }
    public function create(User $user): bool { return $user->can('crear sedes'); }
    public function update(User $user, Sede $sede): bool { return $user->can('editar sedes'); }
    public function delete(User $user, Sede $sede): bool { return $user->can('eliminar sedes'); }
}
