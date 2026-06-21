<?php

namespace App\Http\Requests\IngresosAdmision\Academico;

use App\Models\OfertaAcademica;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Validator;

class OfertaAcademicaUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('gestionar ofertas academicas') ?? false;
    }

    public function rules(): array
    {
        return [
            'ciclo_academico_id' => ['required', 'integer', 'exists:ciclos_academicos,id'],
            'sede_id' => ['required', 'integer', 'exists:sedes,id'],
            'turno_id' => ['required', 'integer', 'exists:turnos,id'],
            'capacidad' => ['required', 'integer', 'min:1', 'max:10000'],
            'costo_matricula' => ['nullable', 'numeric', 'min:0'],
            'costo_pension' => ['nullable', 'numeric', 'min:0'],
            'fecha_inicio_inscripcion' => ['nullable', 'date'],
            'fecha_fin_inscripcion' => ['nullable', 'date', 'after_or_equal:fecha_inicio_inscripcion'],
            'estado' => ['required', 'boolean'],
        ];
    }

    public function after(): array
    {
        return [
            function (Validator $validator): void {
                /** @var OfertaAcademica|null $oferta */
                $oferta = $this->route('oferta');
                if ($oferta !== null && (int) $this->input('capacidad') < $oferta->matriculados) {
                    $validator->errors()->add('capacidad', 'La capacidad no puede ser menor que los matriculados actuales.');
                }
            },
        ];
    }
}
