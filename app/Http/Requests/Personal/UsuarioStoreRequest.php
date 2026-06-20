<?php

namespace App\Http\Requests\Personal;

use App\Models\User;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UsuarioStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        if (! ($this->user()?->can('create', User::class) ?? false)) {
            return false;
        }

        return $this->puedeAsignarRoles();
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'email', 'max:255', 'unique:users,email'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
            'estado' => ['required', 'boolean'],
            'roles' => ['nullable', 'array'],
            'roles.*' => ['string', Rule::exists('roles', 'name')->where('guard_name', 'web')],
        ];
    }

    private function puedeAsignarRoles(): bool
    {
        return ! $this->has('roles') || ($this->user()?->can('asignar roles') ?? false);
    }

}
