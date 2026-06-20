<?php

namespace App\Policies;

use App\Models\GrupoAcademico;
use App\Models\User;

class GrupoAcademicoPolicy
{
    public function viewAny(User $user): bool { return $user->can('ver grupos academicos'); }
    public function view(User $user, GrupoAcademico $grupoAcademico): bool { return $user->can('ver grupos academicos'); }
    public function create(User $user): bool { return $user->can('crear grupos academicos'); }
    public function update(User $user, GrupoAcademico $grupoAcademico): bool { return $user->can('editar grupos academicos'); }
    public function delete(User $user, GrupoAcademico $grupoAcademico): bool { return $user->can('eliminar grupos academicos'); }
}
