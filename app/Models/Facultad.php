<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Facultad extends Model
{
    protected $table = 'facultades';

    protected $fillable = [
        'nombre',
        'sigla',
        'enlace',
        'estado',
    ];

    protected function casts(): array
    {
        return [
            'estado' => 'boolean',
        ];
    }

    public function carreras(): HasMany
    {
        return $this->hasMany(Carrera::class);
    }
}
