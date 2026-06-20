<?php

namespace App\Http\Requests\Personal;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class PermisoTemporalStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('asignar permisos') ?? false;
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        return [
            'permission_id' => ['required', 'integer', Rule::exists('permissions', 'id')->where('guard_name', 'web')],
            'expires_at' => ['required', 'date', 'after:now'],
            'reason' => ['nullable', 'string', 'max:255'],
        ];
    }
}
