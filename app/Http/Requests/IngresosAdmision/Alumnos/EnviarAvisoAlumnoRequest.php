<?php

namespace App\Http\Requests\IngresosAdmision\Alumnos;

use Illuminate\Foundation\Http\FormRequest;

class EnviarAvisoAlumnoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('enviar correos alumnos') ?? false;
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'asunto' => trim((string) $this->input('asunto')),
            'mensaje' => trim((string) $this->input('mensaje')),
        ]);
    }

    public function rules(): array
    {
        return [
            'asunto' => ['required', 'string', 'max:150'],
            'mensaje' => ['required', 'string', 'max:3000'],
        ];
    }
}
