<?php

namespace App\Http\Requests\Personal;

use App\Models\TipoDocumento;
use App\Models\Trabajador;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Validator;

class TrabajadorUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('update', $this->route('trabajador')) ?? false;
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        /** @var Trabajador|null $trabajador */
        $trabajador = $this->route('trabajador');

        return [
            'user_id' => ['nullable', 'integer', 'exists:users,id', Rule::unique('trabajadores', 'user_id')->ignore($trabajador?->id)],
            'sede_id' => ['nullable', 'integer', 'exists:sedes,id'],
            'tipo_documento_id' => ['required', 'integer', 'exists:tipos_documento,id'],
            'numero_documento' => [
                'required',
                'string',
                'max:30',
                Rule::unique('trabajadores', 'numero_documento')
                    ->where(fn ($query) => $query->where('tipo_documento_id', $this->input('tipo_documento_id')))
                    ->ignore($trabajador?->id),
            ],
            'nombres' => ['required', 'string', 'max:255'],
            'apellidos' => ['required', 'string', 'max:255'],
            'telefono' => ['nullable', 'regex:/^9[0-9]{8}$/'],
            'direccion' => ['nullable', 'string', 'max:255'],
            'correo' => ['nullable', 'email', 'max:255', Rule::unique('trabajadores', 'correo')->ignore($trabajador?->id)],
            'estado' => ['required', 'boolean'],
        ];
    }

    public function after(): array
    {
        return [
            function (Validator $validator): void {
                $this->validarDocumento($validator);
            },
        ];
    }

    private function validarDocumento(Validator $validator): void
    {
        $tipoDocumento = TipoDocumento::query()->find($this->input('tipo_documento_id'));
        $numeroDocumento = (string) $this->input('numero_documento', '');

        if ($tipoDocumento === null || $numeroDocumento === '') {
            return;
        }

        if ($tipoDocumento->codigo === 'DNI' && ! preg_match('/^[0-9]{8}$/', $numeroDocumento)) {
            $validator->errors()->add('numero_documento', 'El DNI debe tener exactamente 8 digitos.');
        }

        if ($tipoDocumento->codigo !== 'DNI' && ! preg_match('/^[A-Za-z0-9]+$/', $numeroDocumento)) {
            $validator->errors()->add('numero_documento', 'El documento debe contener solo letras y numeros.');
        }
    }
}
