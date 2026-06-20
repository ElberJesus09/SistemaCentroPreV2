<?php

namespace App\Policies;

use App\Models\Facultad;
use App\Models\User;

class FacultadPolicy
{
    public function viewAny(User $user): bool { return $user->can('ver facultades'); }
    public function view(User $user, Facultad $facultad): bool { return $user->can('ver facultades'); }
    public function create(User $user): bool { return $user->can('crear facultades'); }
    public function update(User $user, Facultad $facultad): bool { return $user->can('editar facultades'); }
    public function delete(User $user, Facultad $facultad): bool { return $user->can('eliminar facultades'); }
}
