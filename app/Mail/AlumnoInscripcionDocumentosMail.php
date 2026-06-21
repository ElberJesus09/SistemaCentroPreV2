<?php

namespace App\Mail;

use App\Models\Alumno;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Attachment;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class AlumnoInscripcionDocumentosMail extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * @param  array<string, string>  $pdfAbsolutePaths
     * @param  array<string, string>  $attachmentNames
     */
    public function __construct(
        public Alumno $alumno,
        public array $pdfAbsolutePaths,
        public array $attachmentNames,
    ) {}

    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Documentos de inscripcion - '.config('app.name'),
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.alumnos.inscripcion-documentos',
            with: ['alumno' => $this->alumno],
        );
    }

    /**
     * @return array<int, Attachment>
     */
    public function attachments(): array
    {
        $attachments = [];

        foreach ($this->pdfAbsolutePaths as $key => $path) {
            $attachments[] = Attachment::fromPath($path)
                ->as($this->attachmentNames[$key] ?? basename($path))
                ->withMime('application/pdf');
        }

        return $attachments;
    }
}
