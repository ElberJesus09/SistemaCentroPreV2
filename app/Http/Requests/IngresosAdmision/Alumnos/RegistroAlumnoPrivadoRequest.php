<?php

namespace App\Http\Requests\IngresosAdmision\Alumnos;

use App\Enums\IngresosAdmision\Alumnos\GeneroAlumno;
use App\Enums\IngresosAdmision\Alumnos\ParentescoApoderado;
use App\Models\TipoDocumento;
use App\Services\Documentos\DocumentoIdentidadService;
use App\Services\IngresosAdmision\Alumnos\ReglaApoderadoService;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Validator;

class RegistroAlumnoPrivadoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('crear alumnos') ?? false;
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'numero_documento' => strtoupper(trim((string) $this->input('numero_documento'))),
            'correo' => $this->filled('correo') ? strtolower(trim((string) $this->input('correo'))) : null,
            'apoderado_numero_documento' => strtoupper(trim((string) $this->input('apoderado_numero_documento'))),
            'apoderado_correo' => $this->filled('apoderado_correo') ? strtolower(trim((string) $this->input('apoderado_correo'))) : null,
            'voucher_matricula' => trim((string) $this->input('voucher_matricula')),
            'voucher_pension' => trim((string) $this->input('voucher_pension')),
        ]);
    }

    public function rules(): array
    {
        return [
            'tipo_documento_id' => ['required', 'integer', 'exists:tipos_documento,id'],
            'numero_documento' => ['required', 'string', 'max:60'],
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
            'carrera_id' => ['required', 'integer', 'exists:carreras,id'],
            'oferta_academica_id' => ['required', 'integer', 'exists:ofertas_academicas,id'],
            'voucher_matricula' => ['nullable', 'string', 'max:120'],
            'agencia_matricula' => ['nullable', 'required_with:voucher_matricula', 'digits:4'],
            'fecha_pago_matricula' => ['nullable', 'required_with:voucher_matricula', 'date', 'before_or_equal:today'],
            'voucher_pension' => ['nullable', 'string', 'max:120', 'different:voucher_matricula'],
            'agencia_pension' => ['nullable', 'required_with:voucher_pension', 'digits:4'],
            'fecha_pago_pension' => ['nullable', 'required_with:voucher_pension', 'date', 'before_or_equal:today'],
            'observacion' => ['nullable', 'string', 'max:1000'],
        ];
    }

    public function after(): array
    {
        return [
            function (Validator $validator): void {
                $documentos = app(DocumentoIdentidadService::class);
                $tipo = TipoDocumento::query()->find($this->input('tipo_documento_id'));
                if ($tipo) {
                    try {
                        $documentos->normalizar($tipo, $this->input('numero_documento'));
                    } catch (\InvalidArgumentException $e) {
                        $validator->errors()->add('numero_documento', $e->getMessage());
                    }
                }

                $requiereApoderado = app(ReglaApoderadoService::class)->requiereApoderado((string) $this->input('fecha_nacimiento'));
                $hayApoderado = collect([
                    'apoderado_tipo_documento_id',
                    'apoderado_numero_documento',
                    'apoderado_nombres',
                    'apoderado_apellido_paterno',
                    'apoderado_telefono',
                    'parentesco',
                ])->contains(fn (string $field): bool => $this->filled($field));

                if ($requiereApoderado || $hayApoderado) {
                    foreach (['apoderado_tipo_documento_id', 'apoderado_numero_documento', 'apoderado_nombres', 'apoderado_apellido_paterno', 'apoderado_apellido_materno', 'apoderado_telefono', 'parentesco'] as $field) {
                        if (! $this->filled($field)) {
                            $validator->errors()->add($field, 'El apoderado es obligatorio o debe completarse correctamente.');
                        }
                    }
                }

                $tipoApoderado = TipoDocumento::query()->find($this->input('apoderado_tipo_documento_id'));
                if ($tipoApoderado && $this->filled('apoderado_numero_documento')) {
                    try {
                        $documentos->normalizar($tipoApoderado, $this->input('apoderado_numero_documento'));
                    } catch (\InvalidArgumentException $e) {
                        $validator->errors()->add('apoderado_numero_documento', $e->getMessage());
                    }
                }
            },
        ];
    }
}
