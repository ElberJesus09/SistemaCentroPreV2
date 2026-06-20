<?php

namespace App\Http\Requests\Institucional;

use Illuminate\Foundation\Http\FormRequest;

class FacultadStoreRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'nombre' => ['required', 'string', 'max:255'],
            'sigla' => ['required', 'string', 'max:50', 'unique:facultades,sigla'],
            'enlace' => ['nullable', 'url', 'max:255'],
            'estado' => ['required', 'boolean'],
        ];
    }
}
