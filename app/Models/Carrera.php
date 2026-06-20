<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Carrera extends Model
{
    protected $table = 'carreras';

    protected $fillable = [
        'codigo',
        'nombre',
        'grupo_academico_id',
        'facultad_id',
        'enlace',
        'es_destacada',
        'estado',
    ];

    protected function casts(): array
    {
        return [
            'es_destacada' => 'boolean',
            'estado' => 'boolean',
        ];
    }

    public function grupoAcademico(): BelongsTo
    {
        return $this->belongsTo(GrupoAcademico::class);
    }

    public function facultad(): BelongsTo
    {
        return $this->belongsTo(Facultad::class);
    }
}
