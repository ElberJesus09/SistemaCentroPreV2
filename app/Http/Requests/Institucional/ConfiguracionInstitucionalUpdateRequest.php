<?php

namespace App\Http\Requests\Institucional;

use Illuminate\Foundation\Http\FormRequest;

class ConfiguracionInstitucionalUpdateRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'nombre' => ['required', 'string', 'max:255'],
            'institucion_relacionada' => ['required', 'string', 'max:255'],
            'proposito_portal' => ['nullable', 'string'],
            'descripcion_publica' => ['nullable', 'string'],
            'correo' => ['nullable', 'email', 'max:255'],
            'telefono' => ['nullable', 'regex:/^(\\+51\\s?)?9[0-9]{8}$/'],
            'sitio_web' => ['nullable', 'url', 'max:255'],
            'estado' => ['required', 'boolean'],
        ];
    }
}
