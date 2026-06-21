<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Colegio extends Model
{
    protected $table = 'colegios';

    protected $fillable = [
        'codigo_modular',
        'nombre',
        'tipo_gestion',
        'departamento',
        'provincia',
        'distrito',
        'estado',
    ];

    protected function casts(): array
    {
        return [
            'estado' => 'boolean',
        ];
    }

    public function alumnos(): BelongsToMany
    {
        return $this->belongsToMany(Alumno::class, 'alumno_colegio')
            ->withPivot(['anio_egreso', 'es_principal'])
            ->withTimestamps();
    }
}
