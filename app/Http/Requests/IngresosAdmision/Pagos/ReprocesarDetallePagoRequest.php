<?php

namespace App\Http\Requests\IngresosAdmision\Pagos;

use Illuminate\Foundation\Http\FormRequest;

class ReprocesarDetallePagoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('reprocesar pagos observados') ?? false;
    }

    public function rules(): array
    {
        return [];
    }
}
