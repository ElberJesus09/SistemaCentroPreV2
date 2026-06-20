<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ConfiguracionInstitucional extends Model
{
    protected $table = 'configuracion_institucional';

    protected $fillable = [
        'nombre',
        'institucion_relacionada',
        'proposito_portal',
        'descripcion_publica',
        'correo',
        'telefono',
        'sitio_web',
        'logo',
        'estado',
    ];

    protected function casts(): array
    {
        return [
            'estado' => 'boolean',
        ];
    }
}
