<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Apoderado extends Model
{
    protected $table = 'apoderados';

    protected $fillable = [
        'tipo_documento_id',
        'numero_documento',
        'nombres',
        'apellido_paterno',
        'apellido_materno',
        'telefono',
        'correo',
        'direccion',
        'estado',
    ];

    public function tipoDocumento(): BelongsTo
    {
        return $this->belongsTo(TipoDocumento::class);
    }

    public function alumnos(): BelongsToMany
    {
        return $this->belongsToMany(Alumno::class, 'alumno_apoderado')
            ->withPivot(['parentesco', 'es_principal', 'vive_con_alumno'])
            ->withTimestamps();
    }
}
