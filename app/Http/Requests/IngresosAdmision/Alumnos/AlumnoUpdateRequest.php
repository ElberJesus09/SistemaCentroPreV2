<?php

namespace App\Http\Requests\IngresosAdmision\Alumnos;

use App\Enums\IngresosAdmision\Alumnos\GeneroAlumno;
use App\Enums\IngresosAdmision\Alumnos\ParentescoApoderado;
use App\Models\TipoDocumento;
use App\Services\Documentos\DocumentoIdentidadService;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Validator;

class AlumnoUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('editar alumnos') ?? false;
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'numero_documento' => strtoupper(trim((string) $this->input('numero_documento'))),
            'correo' => $this->filled('correo') ? strtolower(trim((string) $this->input('correo'))) : null,
            'apoderado_numero_documento' => strtoupper(trim((string) $this->input('apoderado_numero_documento'))),
        ]);
    }

    public function rules(): array
    {
        $alumno = $this->route('alumno');

        return [
            'tipo_documento_id' => ['required', 'integer', 'exists:tipos_documento,id'],
            'numero_documento' => [
                'required',
                'string',
                'max:60',
                Rule::unique('alumnos', 'numero_documento')
                    ->where(fn ($query) => $query->where('tipo_documento_id', $this->input('tipo_documento_id')))
                    ->ignore($alumno?->id),
            ],
            'nombres' => ['required', 'string', 'max:255'],
            'apellido_paterno' => ['required', 'string', 'max:255'],
            'apellido_materno' => ['nullable', 'string', 'max:255'],
            'fecha_nacimiento' => ['required', 'date', 'before_or_equal:today'],
            'genero' => ['required', Rule::enum(GeneroAlumno::class)],
            'telefono' => ['required', 'regex:/^9[0-9]{8}$/'],
            'correo' => ['required', 'email', 'max:255'],
            'departamento' => ['required', 'string', 'max:255'],
            'provincia' => ['required', 'string', 'max:255'],
            'distrito' => ['required', 'string', 'max:255'],
            'direccion' => ['required', 'string', 'max:255'],
            'apoderado_tipo_documento_id' => ['nullable', 'integer', 'exists:tipos_documento,id'],
            'apoderado_numero_documento' => ['nullable', 'string', 'max:60'],
            'apoderado_nombres' => ['nullable', 'string', 'max:255'],
            'apoderado_apellido_paterno' => ['nullable', 'string', 'max:255'],
            'apoderado_apellido_materno' => ['nullable', 'string', 'max:255'],
            'apoderado_telefono' => ['nullable', 'regex:/^9[0-9]{8}$/'],
            'parentesco' => ['nullable', Rule::enum(ParentescoApoderado::class)],
            'colegio_nombre' => ['required', 'string', 'max:255'],
            'colegio_departamento' => ['required', 'string', 'max:255'],
            'colegio_provincia' => ['required', 'string', 'max:255'],
            'colegio_distrito' => ['required', 'string', 'max:255'],
            'anio_egreso' => ['required', 'integer', 'digits:4', 'min:1980', 'max:'.((int) now()->year + 1)],
        ];
    }

    public function after(): array
    {
        return [
            function (Validator $validator): void {
                $tipo = TipoDocumento::query()->find($this->input('tipo_documento_id'));

                if (! $tipo) {
                    return;
                }

                try {
                    app(DocumentoIdentidadService::class)->normalizar($tipo, $this->input('numero_documento'));
                } catch (\InvalidArgumentException $e) {
                    $validator->errors()->add('numero_documento', $e->getMessage());
                }

                $hayApoderado = collect([
                    'apoderado_tipo_documento_id',
                    'apoderado_numero_documento',
                    'apoderado_nombres',
                    'apoderado_apellido_paterno',
                    'apoderado_telefono',
                    'parentesco',
                ])->contains(fn (string $field): bool => $this->filled($field));

                if ($hayApoderado) {
                    foreach (['apoderado_tipo_documento_id', 'apoderado_numero_documento', 'apoderado_nombres', 'apoderado_apellido_paterno', 'apoderado_telefono', 'parentesco'] as $field) {
                        if (! $this->filled($field)) {
                            $validator->errors()->add($field, 'Completa los datos obligatorios del apoderado.');
                        }
                    }
                }

                $tipoApoderado = TipoDocumento::query()->find($this->input('apoderado_tipo_documento_id'));
                if ($tipoApoderado && $this->filled('apoderado_numero_documento')) {
                    try {
                        app(DocumentoIdentidadService::class)->normalizar($tipoApoderado, $this->input('apoderado_numero_documento'));
                    } catch (\InvalidArgumentException $e) {
                        $validator->errors()->add('apoderado_numero_documento', $e->getMessage());
                    }
                }
            },
        ];
    }
}
