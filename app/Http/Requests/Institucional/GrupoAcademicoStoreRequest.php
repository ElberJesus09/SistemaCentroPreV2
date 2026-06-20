<?php

namespace App\Http\Requests\Institucional;

use Illuminate\Foundation\Http\FormRequest;

class GrupoAcademicoStoreRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'codigo' => ['required', 'string', 'max:255', 'unique:grupos_academicos,codigo'],
            'nombre' => ['required', 'string', 'max:255', 'unique:grupos_academicos,nombre'],
            'descripcion' => ['nullable', 'string'],
            'estado' => ['required', 'boolean'],
        ];
    }
}
