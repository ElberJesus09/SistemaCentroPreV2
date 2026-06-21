<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ConceptoPago extends Model
{
    protected $table = 'conceptos_pago';

    protected $fillable = ['codigo', 'nombre', 'estado'];

    protected function casts(): array
    {
        return ['estado' => 'boolean'];
    }

    public function codigosExternos(): HasMany
    {
        return $this->hasMany(CodigoPagoExterno::class);
    }

    public function pagos(): HasMany
    {
        return $this->hasMany(Pago::class);
    }
}
