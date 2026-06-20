<?php

namespace App\Http\Requests\Institucional;

use App\Models\Sede;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Validator;

class SedeUpdateRequest extends SedeStoreRequest
{
    protected function validarSedePrincipal(Validator $validator): void
    {
        /** @var Sede|null $sede */
        $sede = $this->route('sede');

        if ($this->boolean('es_principal') && $this->boolean('estado') && Sede::query()->where('es_principal', true)->where('estado', true)->whereKeyNot($sede?->id)->exists()) {
            $validator->errors()->add('es_principal', 'Ya existe una sede principal activa.');
        }
    }
}
