<?php

namespace App\Mail;

use App\Models\Alumno;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class AlumnoAvisoMail extends Mailable
{
    use Queueable, SerializesModels;

    public function __construct(
        public Alumno $alumno,
        public string $asunto,
        public string $mensaje,
        public string $enviadoPor,
    ) {}

    public function envelope(): Envelope
    {
        return new Envelope(subject: $this->asunto);
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.alumnos.aviso',
            with: [
                'alumno' => $this->alumno,
                'mensaje' => $this->mensaje,
                'enviadoPor' => $this->enviadoPor,
            ],
        );
    }
}
