<?php

namespace App\Services\IngresosAdmision\Alumnos;

use App\Models\Alumno;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Str;
use InvalidArgumentException;
use Symfony\Component\HttpFoundation\Response;

class AlumnoPdfService
{
    /**
     * @param  list<string>|null  $documents
     * @return array<string, string>
     */
    public function buildRegistrationAttachmentFiles(Alumno $alumno, ?array $documents = null): array
    {
        $this->loadRelations($alumno);
        $documents ??= ['ficha', 'reglamento'];

        $directory = storage_path('app/tmp/alumno-mail');
        if (! is_dir($directory) && ! mkdir($directory, 0755, true) && ! is_dir($directory)) {
            throw new InvalidArgumentException('No se pudo crear la carpeta temporal para PDF.');
        }

        $token = (string) Str::ulid();
        $paths = [];

        if (in_array('ficha', $documents, true)) {
            $path = $directory.DIRECTORY_SEPARATOR."ficha-{$token}.pdf";
            Pdf::loadView('pdf.alumnos.ficha-inscripcion', ['alumno' => $alumno])
                ->setPaper('a4')
                ->save($path);

            $paths['ficha'] = $path;
        }

        if (in_array('declaracion', $documents, true)) {
            $path = $directory.DIRECTORY_SEPARATOR."declaracion-{$token}.pdf";
            Pdf::loadView('pdf.alumnos.declaracion-jurada', ['alumno' => $alumno])
                ->setPaper('a4')
                ->save($path);

            $paths['declaracion'] = $path;
        }

        if (in_array('reglamento', $documents, true)) {
            $path = $directory.DIRECTORY_SEPARATOR."reglamento-{$token}.pdf";
            Pdf::loadView('pdf.alumnos.reglamento-academico', ['alumno' => $alumno])
                ->setPaper('a4')
                ->save($path);

            $paths['reglamento'] = $path;
        }

        return $paths;
    }

    public function downloadRegistrationDocument(Alumno $alumno, string $document): Response
    {
        $this->loadRelations($alumno);

        [$view, $filename] = match ($document) {
            'ficha' => ['pdf.alumnos.ficha-inscripcion', (string) config('alumno_mail.attachment_enrollment_filename')],
            'declaracion' => ['pdf.alumnos.declaracion-jurada', (string) config('alumno_mail.attachment_declaration_filename')],
            'reglamento' => ['pdf.alumnos.reglamento-academico', (string) config('alumno_mail.attachment_regulations_filename')],
            default => abort(404),
        };

        return Pdf::loadView($view, ['alumno' => $alumno])
            ->setPaper('a4')
            ->download($filename);
    }

    /**
     * @param  array<string, string>  $paths
     */
    public function deleteIfExists(array $paths): void
    {
        foreach ($paths as $path) {
            if (is_file($path)) {
                @unlink($path);
            }
        }
    }

    public function loadRelations(Alumno $alumno): void
    {
        $alumno->loadMissing([
            'tipoDocumento',
            'apoderados.tipoDocumento',
            'colegios',
            'inscripciones.carrera',
            'inscripciones.ofertaAcademica.cicloAcademico',
            'inscripciones.ofertaAcademica.sede',
            'inscripciones.ofertaAcademica.turno',
            'matriculas.carrera',
            'matriculas.ofertaAcademica.cicloAcademico',
            'matriculas.ofertaAcademica.sede',
            'matriculas.ofertaAcademica.turno',
            'matriculas.pagos.conceptoPago',
        ]);
    }
}
