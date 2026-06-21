<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class CodigoPagoExterno extends Model
{
    protected $table = 'codigos_pago_externos';

    protected $fillable = [
        'canal_pago_id',
        'concepto_pago_id',
        'codigo_externo',
        'descripcion_externa',
        'estado',
    ];

    protected function casts(): array
    {
        return ['estado' => 'boolean'];
    }

    public function canalPago(): BelongsTo
    {
        return $this->belongsTo(CanalPago::class);
    }

    public function conceptoPago(): BelongsTo
    {
        return $this->belongsTo(ConceptoPago::class);
    }
}
