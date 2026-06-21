<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class CicloAcademico extends Model
{
    protected $table = 'ciclos_academicos';

    protected $fillable = [
        'codigo',
        'nombre',
        'fecha_inicio',
        'fecha_fin',
        'fecha_inicio_inscripcion',
        'fecha_fin_inscripcion',
        'estado',
    ];

    protected function casts(): array
    {
        return [
            'fecha_inicio' => 'date',
            'fecha_fin' => 'date',
            'fecha_inicio_inscripcion' => 'date',
            'fecha_fin_inscripcion' => 'date',
            'estado' => 'boolean',
        ];
    }

    public function ofertasAcademicas(): HasMany
    {
        return $this->hasMany(OfertaAcademica::class);
    }
}
