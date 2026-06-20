<?php

namespace App\Http\Requests\Institucional;

use App\Models\GrupoAcademico;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class GrupoAcademicoUpdateRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        /** @var GrupoAcademico|null $grupoAcademico */
        $grupoAcademico = $this->route('grupoAcademico');

        return [
            'codigo' => ['required', 'string', 'max:255', Rule::unique('grupos_academicos', 'codigo')->ignore($grupoAcademico?->id)],
            'nombre' => ['required', 'string', 'max:255', Rule::unique('grupos_academicos', 'nombre')->ignore($grupoAcademico?->id)],
            'descripcion' => ['nullable', 'string'],
            'estado' => ['required', 'boolean'],
        ];
    }
}
