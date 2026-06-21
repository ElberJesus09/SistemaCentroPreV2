<?php

namespace App\Http\Requests\IngresosAdmision\Pagos;

use App\Models\CodigoPagoExterno;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CodigoPagoExternoUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('gestionar codigos externos de pago') ?? false;
    }

    public function rules(): array
    {
        $codigo = $this->route('codigoExterno');
        $id = $codigo instanceof CodigoPagoExterno ? $codigo->id : null;

        return [
            'canal_pago_id' => ['required', 'integer', Rule::exists('canales_pago', 'id')],
            'concepto_pago_id' => ['required', 'integer', Rule::exists('conceptos_pago', 'id')],
            'codigo_externo' => [
                'required',
                'string',
                'max:120',
                Rule::unique('codigos_pago_externos', 'codigo_externo')
                    ->where(fn ($query) => $query->where('canal_pago_id', $this->input('canal_pago_id')))
                    ->ignore($id),
            ],
            'descripcion_externa' => ['nullable', 'string', 'max:255'],
            'estado' => ['nullable', 'boolean'],
        ];
    }
}
