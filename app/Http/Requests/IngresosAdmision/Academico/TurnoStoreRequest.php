<?php

namespace App\Http\Requests\IngresosAdmision\Academico;

use Illuminate\Foundation\Http\FormRequest;

class TurnoStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('gestionar turnos') ?? false;
    }

    public function rules(): array
    {
        return [
            'codigo' => ['required', 'string', 'max:40', 'alpha_dash', 'unique:turnos,codigo'],
            'nombre' => ['required', 'string', 'max:255', 'unique:turnos,nombre'],
            'hora_inicio' => ['nullable', 'date_format:H:i'],
            'hora_fin' => ['nullable', 'date_format:H:i', 'after:hora_inicio'],
            'estado' => ['required', 'boolean'],
        ];
    }
}
