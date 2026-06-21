<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Turno extends Model
{
    protected $table = 'turnos';

    protected $fillable = [
        'codigo',
        'nombre',
        'hora_inicio',
        'hora_fin',
        'estado',
    ];

    protected function casts(): array
    {
        return [
            'hora_inicio' => 'datetime:H:i',
            'hora_fin' => 'datetime:H:i',
            'estado' => 'boolean',
        ];
    }

    public function ofertasAcademicas(): HasMany
    {
        return $this->hasMany(OfertaAcademica::class);
    }
}
