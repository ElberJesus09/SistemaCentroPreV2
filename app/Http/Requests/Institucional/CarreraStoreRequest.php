<?php

namespace App\Http\Requests\Institucional;

use Illuminate\Foundation\Http\FormRequest;

class CarreraStoreRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'codigo' => ['required', 'string', 'max:50', 'unique:carreras,codigo'],
            'nombre' => ['required', 'string', 'max:255'],
            'grupo_academico_id' => ['required', 'integer', 'exists:grupos_academicos,id'],
            'facultad_id' => ['required', 'integer', 'exists:facultades,id'],
            'enlace' => ['nullable', 'url', 'max:255'],
            'es_destacada' => ['required', 'boolean'],
            'estado' => ['required', 'boolean'],
        ];
    }
}
