<?php

namespace App\Models;

use App\Enums\IngresosAdmision\Alumnos\EstadoInscripcion;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Inscripcion extends Model
{
    protected $table = 'inscripciones';

    protected $fillable = [
        'codigo',
        'alumno_id',
        'oferta_academica_id',
        'carrera_id',
        'colegio_id',
        'fecha_inscripcion',
        'estado',
        'observacion',
        'registrado_por',
        'revisado_por',
        'revisado_at',
    ];

    protected function casts(): array
    {
        return [
            'fecha_inscripcion' => 'date',
            'revisado_at' => 'datetime',
            'estado' => EstadoInscripcion::class,
        ];
    }

    public function alumno(): BelongsTo
    {
        return $this->belongsTo(Alumno::class);
    }

    public function ofertaAcademica(): BelongsTo
    {
        return $this->belongsTo(OfertaAcademica::class);
    }

    public function carrera(): BelongsTo
    {
        return $this->belongsTo(Carrera::class);
    }

    public function matricula(): HasOne
    {
        return $this->hasOne(Matricula::class);
    }

    public function pagos(): HasMany
    {
        return $this->hasMany(Pago::class);
    }
}
