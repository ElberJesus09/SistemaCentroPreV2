<?php

namespace App\Http\Requests\IngresosAdmision\Pagos;

use Illuminate\Foundation\Http\FormRequest;

class ImportarPagosRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('importar pagos') ?? false;
    }

    public function rules(): array
    {
        return [
            'fecha_referencia' => ['required', 'date'],
            'archivo' => ['required', 'file', 'max:10240', 'extensions:xlsx'],
        ];
    }
}
