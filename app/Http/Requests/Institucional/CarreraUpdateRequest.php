<?php

namespace App\Http\Requests\Institucional;

use App\Models\Carrera;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CarreraUpdateRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        /** @var Carrera|null $carrera */
        $carrera = $this->route('carrera');

        return [
            'codigo' => ['required', 'string', 'max:50', Rule::unique('carreras', 'codigo')->ignore($carrera?->id)],
            'nombre' => ['required', 'string', 'max:255'],
            'grupo_academico_id' => ['required', 'integer', 'exists:grupos_academicos,id'],
            'facultad_id' => ['required', 'integer', 'exists:facultades,id'],
            'enlace' => ['nullable', 'url', 'max:255'],
            'es_destacada' => ['required', 'boolean'],
            'estado' => ['required', 'boolean'],
        ];
    }
}
