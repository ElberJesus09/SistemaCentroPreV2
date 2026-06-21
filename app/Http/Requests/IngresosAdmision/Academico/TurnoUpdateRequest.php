<?php

namespace App\Http\Requests\IngresosAdmision\Academico;

use App\Models\Turno;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class TurnoUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('gestionar turnos') ?? false;
    }

    public function rules(): array
    {
        /** @var Turno|null $turno */
        $turno = $this->route('turno');

        return [
            'codigo' => ['required', 'string', 'max:40', 'alpha_dash', Rule::unique('turnos', 'codigo')->ignore($turno?->id)],
            'nombre' => ['required', 'string', 'max:255', Rule::unique('turnos', 'nombre')->ignore($turno?->id)],
            'hora_inicio' => ['nullable', 'date_format:H:i'],
            'hora_fin' => ['nullable', 'date_format:H:i', 'after:hora_inicio'],
            'estado' => ['required', 'boolean'],
        ];
    }
}
