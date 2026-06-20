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
        'direccion',
        'telefono',
        'estado',
    ];

    protected function casts(): array
    {
        return [
            'estado' => 'boolean',
        ];
    }

    public function trabajadores(): HasMany
    {
        return $this->hasMany(Trabajador::class);
    }
}
