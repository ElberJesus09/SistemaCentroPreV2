<?php

namespace App\Models;

use App\Enums\IngresosAdmision\Pagos\EstadoDetalleImportacionPago;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class ImportacionPagoDetalle extends Model
{
    protected $table = 'importacion_pago_detalles';

    protected $fillable = [
        'importacion_pago_id',
        'numero_fila',
        'tipo_documento',
        'numero_documento',
        'voucher',
        'fecha_pago',
        'agencia',
        'codigo_pago',
        'datos_origen',
        'estado',
        'mensaje',
        'pago_id',
    ];

    protected function casts(): array
    {
        return [
            'fecha_pago' => 'date',
            'datos_origen' => 'array',
            'estado' => EstadoDetalleImportacionPago::class,
        ];
    }

    public function importacionPago(): BelongsTo
    {
        return $this->belongsTo(ImportacionPago::class);
    }

    public function pago(): HasOne
    {
        return $this->hasOne(Pago::class);
    }
}
