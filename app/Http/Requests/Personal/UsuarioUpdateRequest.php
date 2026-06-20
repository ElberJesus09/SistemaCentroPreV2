<?php

namespace App\Http\Requests\Personal;

use App\Models\User;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UsuarioUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        /** @var User|null $usuario */
        $usuario = $this->route('usuario');

        if (! ($this->user()?->can('update', $usuario) ?? false)) {
            return false;
        }

        return $this->puedeAsignarRoles();
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        /** @var User|null $usuario */
        $usuario = $this->route('usuario');

        return [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'email', 'max:255', Rule::unique('users', 'email')->ignore($usuario?->id)],
            'password' => ['nullable', 'string', 'min:8', 'confirmed'],
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
