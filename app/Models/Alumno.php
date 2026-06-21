<?php

namespace App\Models;

use App\Enums\IngresosAdmision\Alumnos\EstadoAlumno;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Alumno extends Model
{
    protected $table = 'alumnos';

    protected $fillable = [
        'codigo',
        'tipo_documento_id',
        'numero_documento',
        'nombres',
        'apellido_paterno',
        'apellido_materno',
        'fecha_nacimiento',
        'genero',
        'telefono',
        'correo',
        'departamento',
        'provincia',
        'distrito',
        'direccion',
        'estado',
        'registrado_por',
    ];

    protected function casts(): array
    {
        return [
            'fecha_nacimiento' => 'date',
            'estado' => EstadoAlumno::class,
        ];
    }

    public function tipoDocumento(): BelongsTo
    {
        return $this->belongsTo(TipoDocumento::class);
    }

    public function registrador(): BelongsTo
    {
        return $this->belongsTo(User::class, 'registrado_por');
    }

    public function apoderados(): BelongsToMany
    {
        return $this->belongsToMany(Apoderado::class, 'alumno_apoderado')
            ->withPivot(['parentesco', 'es_principal', 'vive_con_alumno'])
            ->withTimestamps();
    }

    public function colegios(): BelongsToMany
    {
        return $this->belongsToMany(Colegio::class, 'alumno_colegio')
            ->withPivot(['anio_egreso', 'es_principal'])
            ->withTimestamps();
    }

    public function inscripciones(): HasMany
    {
        return $this->hasMany(Inscripcion::class);
    }

    public function matriculas(): HasMany
    {
        return $this->hasMany(Matricula::class);
    }

    public function nombreCompleto(): string
    {
        return trim("{$this->apellido_paterno} {$this->apellido_materno} {$this->nombres}");
    }
}
