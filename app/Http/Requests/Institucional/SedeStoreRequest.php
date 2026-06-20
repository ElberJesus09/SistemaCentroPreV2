<?php

namespace App\Http\Requests\Institucional;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Validator;
use App\Models\Sede;

class SedeStoreRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'nombre' => ['required', 'string', 'max:255'],
            'tipo' => ['required', 'in:principal,secundaria,subsede'],
            'direccion' => ['required', 'string', 'max:255'],
            'distrito' => ['nullable', 'string', 'max:255'],
            'provincia' => ['nullable', 'string', 'max:255'],
            'departamento' => ['nullable', 'string', 'max:255'],
            'pais' => ['required', 'string', 'max:255'],
            'horario' => ['nullable', 'string', 'max:255'],
            'correo' => ['nullable', 'email', 'max:255'],
            'telefono' => ['nullable', 'regex:/^(\\+51\\s?)?9[0-9]{8}$/'],
            'mapa_url' => ['nullable', 'url'],
            'es_principal' => ['required', 'boolean'],
            'permite_acceso_sistema' => ['required', 'boolean'],
            'estado' => ['required', 'boolean'],
        ];
    }

    public function after(): array
    {
        return [fn (Validator $validator) => $this->validarSedePrincipal($validator)];
    }

    protected function validarSedePrincipal(Validator $validator): void
    {
        if ($this->boolean('es_principal') && $this->boolean('estado') && Sede::query()->where('es_principal', true)->where('estado', true)->exists()) {
            $validator->errors()->add('es_principal', 'Ya existe una sede principal activa.');
        }
    }
}
