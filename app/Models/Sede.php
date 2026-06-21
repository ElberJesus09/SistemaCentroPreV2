<?php

namespace App\Models;

use Database\Factories\SedeFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Sede extends Model
{
    /** @use HasFactory<SedeFactory> */
    use HasFactory;

    protected $table = 'sedes';

    /**
     * @var list<string>
     */
    protected $fillable = [
        'nombre',
        'tipo',
        'direccion',
        'distrito',
        'provincia',
        'departamento',
        'pais',
        'horario',
        'correo',
        'telefono',
        'mapa_url',
        'es_principal',
        'permite_acceso_sistema',
        'estado',
    ];

    protected function casts(): array
    {
        return [
            'es_principal' => 'boolean',
            'permite_acceso_sistema' => 'boolean',
            'estado' => 'boolean',
        ];
    }

    public function trabajadores(): HasMany
    {
        return $this->hasMany(Trabajador::class);
    }

    public function ofertasAcademicas(): HasMany
    {
        return $this->hasMany(OfertaAcademica::class);
    }
}
