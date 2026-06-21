<?php

namespace App\Http\Controllers\IngresosAdmision\Alumnos;

use App\Http\Controllers\Controller;
use App\Http\Requests\IngresosAdmision\Alumnos\EnviarAvisoAlumnoRequest;
use App\Models\Alumno;
use App\Services\IngresosAdmision\Alumnos\AlumnoCorreoService;
use Illuminate\Http\RedirectResponse;
use RuntimeException;

class AlumnoCorreoController extends Controller
{
    public function documentos(Alumno $alumno, AlumnoCorreoService $correoService): RedirectResponse
    {
        try {
            $correoService->enviarDocumentosInscripcion($alumno, request()->user());
        } catch (RuntimeException $e) {
            return back()->withErrors(['correo' => $e->getMessage()]);
        }

        return back()->with('status', 'Correo con ficha de inscripcion y declaracion enviado correctamente.');
    }

    public function aviso(EnviarAvisoAlumnoRequest $request, Alumno $alumno, AlumnoCorreoService $correoService): RedirectResponse
    {
        $validated = $request->validated();

        try {
            $correoService->enviarAviso(
                $alumno,
                $request->user(),
                $validated['asunto'],
                $validated['mensaje'],
            );
        } catch (RuntimeException $e) {
            return back()->withErrors(['correo' => $e->getMessage()]);
        }

        return back()->with('status', 'Aviso enviado correctamente al alumno.');
    }
}
