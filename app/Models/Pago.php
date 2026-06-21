<?php

namespace App\Models;

use App\Enums\IngresosAdmision\Pagos\EstadoPago;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Pago extends Model
{
    protected $table = 'pagos';

    protected $fillable = [
        'tipo_documento',
        'numero_documento',
        'voucher',
        'fecha_pago',
        'agencia',
        'concepto_pago_id',
        'canal_pago_id',
        'importacion_pago_detalle_id',
        'estado',
        'observacion',
    ];

    protected function casts(): array
    {
        return [
            'fecha_pago' => 'date',
            'estado' => EstadoPago::class,
        ];
    }

    public function conceptoPago(): BelongsTo
    {
        return $this->belongsTo(ConceptoPago::class);
    }

    public function canalPago(): BelongsTo
    {
        return $this->belongsTo(CanalPago::class);
    }

    public function importacionPagoDetalle(): BelongsTo
    {
        return $this->belongsTo(ImportacionPagoDetalle::class);
    }
}
