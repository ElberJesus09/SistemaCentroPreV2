<?php

namespace App\Http\Requests\Institucional;

use App\Models\Facultad;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class FacultadUpdateRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        /** @var Facultad|null $facultad */
        $facultad = $this->route('facultad');

        return [
            'nombre' => ['required', 'string', 'max:255'],
            'sigla' => ['required', 'string', 'max:50', Rule::unique('facultades', 'sigla')->ignore($facultad?->id)],
            'enlace' => ['nullable', 'url', 'max:255'],
            'estado' => ['required', 'boolean'],
        ];
    }
}
