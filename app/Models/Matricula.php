<?php

namespace App\Models;

use App\Enums\IngresosAdmision\Alumnos\EstadoMatricula;
use App\Enums\IngresosAdmision\Alumnos\EstadoPagosMatricula;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Matricula extends Model
{
    protected $table = 'matriculas';

    protected $fillable = [
        'codigo',
        'alumno_id',
        'inscripcion_id',
        'oferta_academica_id',
        'carrera_id',
        'fecha_matricula',
        'estado',
        'estado_pagos',
        'registrado_por',
        'activado_at',
    ];

    protected function casts(): array
    {
        return [
            'fecha_matricula' => 'date',
            'activado_at' => 'datetime',
            'estado' => EstadoMatricula::class,
            'estado_pagos' => EstadoPagosMatricula::class,
        ];
    }

    public function alumno(): BelongsTo
    {
        return $this->belongsTo(Alumno::class);
    }

    public function inscripcion(): BelongsTo
    {
        return $this->belongsTo(Inscripcion::class);
    }

    public function ofertaAcademica(): BelongsTo
    {
        return $this->belongsTo(OfertaAcademica::class);
    }

    public function carrera(): BelongsTo
    {
        return $this->belongsTo(Carrera::class);
    }

    public function pagos(): HasMany
    {
        return $this->hasMany(Pago::class);
    }
}
