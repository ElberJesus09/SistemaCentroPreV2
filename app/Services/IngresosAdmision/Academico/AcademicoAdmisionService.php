<?php

namespace App\Services\IngresosAdmision\Academico;

use App\Models\CicloAcademico;
use App\Models\OfertaAcademica;
use App\Models\Turno;
use Illuminate\Validation\ValidationException;

class AcademicoAdmisionService
{
    public function deleteCiclo(CicloAcademico $ciclo): void
    {
        if ($ciclo->ofertasAcademicas()->exists()) {
            throw ValidationException::withMessages([
                'delete' => ['No se puede eliminar el ciclo porque tiene ofertas academicas.'],
            ]);
        }

        $ciclo->delete();
    }

    public function deleteTurno(Turno $turno): void
    {
        if ($turno->ofertasAcademicas()->exists()) {
            throw ValidationException::withMessages([
                'delete' => ['No se puede eliminar el turno porque esta usado en ofertas academicas.'],
            ]);
        }

        $turno->delete();
    }

    public function deleteOferta(OfertaAcademica $oferta): void
    {
        if ($oferta->matriculados > 0 || $oferta->inscripciones()->exists() || $oferta->matriculas()->exists()) {
            throw ValidationException::withMessages([
                'delete' => ['No se puede eliminar la oferta porque tiene alumnos, inscripciones o matriculas.'],
            ]);
        }

        $oferta->delete();
    }
}
