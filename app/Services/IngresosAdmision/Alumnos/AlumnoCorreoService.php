<?php

namespace App\Services\IngresosAdmision\Alumnos;

use App\Mail\AlumnoAvisoMail;
use App\Mail\AlumnoInscripcionDocumentosMail;
use App\Models\Alumno;
use App\Models\User;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use RuntimeException;
use Throwable;

class AlumnoCorreoService
{
    public function __construct(
        private readonly AlumnoPdfService $pdfService,
    ) {}

    public function enviarDocumentosInscripcion(Alumno $alumno, User $trabajador): void
    {
        $email = $this->validEmail($alumno);
        $paths = [];

        try {
            $paths = $this->pdfService->buildRegistrationAttachmentFiles($alumno, ['ficha', 'reglamento']);
            $this->ensureAttachments($paths, ['ficha', 'reglamento']);

            Mail::to($email)->send(new AlumnoInscripcionDocumentosMail(
                $alumno,
                $paths,
                [
                    'ficha' => (string) config('alumno_mail.attachment_enrollment_filename'),
                    'reglamento' => (string) config('alumno_mail.attachment_regulations_filename'),
                ],
            ));

            Log::info('alumno_inscripcion_documentos_mail_sent', [
                'alumno_id' => $alumno->id,
                'trabajador_id' => $trabajador->id,
                'recipient' => $email,
            ]);
        } catch (Throwable $e) {
            Log::error('alumno_inscripcion_documentos_mail_failed', [
                'alumno_id' => $alumno->id,
                'trabajador_id' => $trabajador->id,
                'recipient' => $email,
                'exception' => $e::class,
                'message' => $e->getMessage(),
            ]);

            throw new RuntimeException($this->friendlyMailMessage($e), previous: $e);
        } finally {
            $this->pdfService->deleteIfExists($paths);
        }
    }

    public function enviarAviso(Alumno $alumno, User $trabajador, string $asunto, string $mensaje): void
    {
        $email = $this->validEmail($alumno);

        try {
            Mail::to($email)->send(new AlumnoAvisoMail(
                $alumno,
                $asunto,
                $mensaje,
                $trabajador->name,
            ));

            Log::info('alumno_aviso_mail_sent', [
                'alumno_id' => $alumno->id,
                'trabajador_id' => $trabajador->id,
                'recipient' => $email,
                'subject' => $asunto,
            ]);
        } catch (Throwable $e) {
            Log::error('alumno_aviso_mail_failed', [
                'alumno_id' => $alumno->id,
                'trabajador_id' => $trabajador->id,
                'recipient' => $email,
                'exception' => $e::class,
                'message' => $e->getMessage(),
            ]);

            throw new RuntimeException($this->friendlyMailMessage($e), previous: $e);
        }
    }

    private function validEmail(Alumno $alumno): string
    {
        $email = $alumno->correo;

        if (! is_string($email) || ! filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new RuntimeException('El alumno no tiene un correo válido registrado.');
        }

        return $email;
    }

    /**
     * @param  array<string, string>  $paths
     * @param  list<string>  $documents
     */
    private function ensureAttachments(array $paths, array $documents): void
    {
        foreach ($documents as $document) {
            $path = $paths[$document] ?? null;
            if (! is_string($path) || ! is_file($path) || filesize($path) === 0) {
                throw new RuntimeException('No se pudieron generar los documentos PDF.');
            }
        }
    }

    private function friendlyMailMessage(Throwable $e): string
    {
        $message = mb_strtolower($e->getMessage());

        if (str_contains($message, 'username') || str_contains($message, 'password') || str_contains($message, 'authenticate')) {
            return 'No se pudo enviar el correo. Revisa el usuario y la contraseña SMTP de Gmail.';
        }

        if (str_contains($message, 'connection') || str_contains($message, 'timed out')) {
            return 'No se pudo conectar al servidor SMTP. Revisa la configuración de correo.';
        }

        return 'No se pudo enviar el correo en este momento. Revisa la configuración SMTP o intenta nuevamente.';
    }
}
