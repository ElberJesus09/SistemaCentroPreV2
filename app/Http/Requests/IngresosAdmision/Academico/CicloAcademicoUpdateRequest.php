<?php

namespace App\Http\Requests\IngresosAdmision\Academico;

use App\Models\CicloAcademico;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CicloAcademicoUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('gestionar ciclos academicos') ?? false;
    }

    public function rules(): array
    {
        /** @var CicloAcademico|null $ciclo */
        $ciclo = $this->route('ciclo');

        return [
            'codigo' => ['required', 'string', 'max:40', 'alpha_dash', Rule::unique('ciclos_academicos', 'codigo')->ignore($ciclo?->id)],
            'nombre' => ['required', 'string', 'max:255'],
            'fecha_inicio' => ['required', 'date'],
            'fecha_fin' => ['required', 'date', 'after_or_equal:fecha_inicio'],
            'fecha_inicio_inscripcion' => ['nullable', 'date'],
            'fecha_fin_inscripcion' => ['nullable', 'date', 'after_or_equal:fecha_inicio_inscripcion'],
            'estado' => ['required', 'boolean'],
        ];
    }
}
