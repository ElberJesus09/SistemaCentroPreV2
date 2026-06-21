<?php

namespace App\Http\Controllers\IngresosAdmision\Alumnos;

use App\Http\Controllers\Controller;
use App\Models\Alumno;
use App\Services\IngresosAdmision\Alumnos\AlumnoPdfService;
use Symfony\Component\HttpFoundation\Response;

class AlumnoDocumentoController extends Controller
{
    public function __invoke(Alumno $alumno, string $documento, AlumnoPdfService $pdfService): Response
    {
        return $pdfService->downloadRegistrationDocument($alumno, $documento);
    }
}
