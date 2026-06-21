<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class OfertaAcademica extends Model
{
    protected $table = 'ofertas_academicas';

    protected $fillable = [
        'ciclo_academico_id',
        'sede_id',
        'turno_id',
        'capacidad',
        'matriculados',
        'costo_matricula',
        'costo_pension',
        'fecha_inicio_inscripcion',
        'fecha_fin_inscripcion',
        'estado',
    ];

    protected function casts(): array
    {
        return [
            'capacidad' => 'integer',
            'matriculados' => 'integer',
            'costo_matricula' => 'decimal:2',
            'costo_pension' => 'decimal:2',
            'fecha_inicio_inscripcion' => 'date',
            'fecha_fin_inscripcion' => 'date',
            'estado' => 'boolean',
        ];
    }

    public function cicloAcademico(): BelongsTo
    {
        return $this->belongsTo(CicloAcademico::class);
    }

    public function sede(): BelongsTo
    {
        return $this->belongsTo(Sede::class);
    }

    public function turno(): BelongsTo
    {
        return $this->belongsTo(Turno::class);
    }

    public function inscripciones(): HasMany
    {
        return $this->hasMany(Inscripcion::class);
    }

    public function matriculas(): HasMany
    {
        return $this->hasMany(Matricula::class);
    }

    public function vacantesDisponibles(): int
    {
        return max(0, $this->capacidad - $this->matriculados);
    }
}
