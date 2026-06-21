<?php

namespace App\Models;

use Database\Factories\TipoDocumentoFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class TipoDocumento extends Model
{
    /** @use HasFactory<TipoDocumentoFactory> */
    use HasFactory;

    protected $table = 'tipos_documento';

    /**
     * @var list<string>
     */
    protected $fillable = [
        'nombre',
        'codigo',
        'longitud_minima',
        'longitud_maxima',
        'es_numerico',
        'permite_letras',
        'estado',
    ];

    protected function casts(): array
    {
        return [
            'es_numerico' => 'boolean',
            'permite_letras' => 'boolean',
            'estado' => 'boolean',
        ];
    }

    public function trabajadores(): HasMany
    {
        return $this->hasMany(Trabajador::class);
    }
}
