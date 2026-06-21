<?php

namespace App\Http\Requests\IngresosAdmision\Academico;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CicloAcademicoStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('gestionar ciclos academicos') ?? false;
    }

    public function rules(): array
    {
        return [
            'codigo' => ['required', 'string', 'max:40', 'alpha_dash', 'unique:ciclos_academicos,codigo'],
            'nombre' => ['required', 'string', 'max:255'],
            'fecha_inicio' => ['required', 'date'],
            'fecha_fin' => ['required', 'date', 'after_or_equal:fecha_inicio'],
            'fecha_inicio_inscripcion' => ['nullable', 'date'],
            'fecha_fin_inscripcion' => ['nullable', 'date', 'after_or_equal:fecha_inicio_inscripcion'],
            'estado' => ['required', 'boolean'],
        ];
    }
}
