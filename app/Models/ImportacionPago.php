<?php

namespace App\Models;

use App\Enums\IngresosAdmision\Pagos\EstadoImportacionPago;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ImportacionPago extends Model
{
    protected $table = 'importaciones_pago';

    protected $fillable = [
        'canal_pago_id',
        'fecha_referencia',
        'nombre_archivo',
        'nombre_interno',
        'disco',
        'ruta_archivo',
        'mime_type',
        'extension',
        'tamano',
        'hash_archivo',
        'total_registros',
        'registros_procesados',
        'registros_importados',
        'registros_observados',
        'importado_por',
        'estado',
        'iniciado_at',
        'finalizado_at',
        'mensaje_error',
    ];

    protected function casts(): array
    {
        return [
            'fecha_referencia' => 'date',
            'iniciado_at' => 'datetime',
            'finalizado_at' => 'datetime',
            'estado' => EstadoImportacionPago::class,
        ];
    }

    public function canalPago(): BelongsTo
    {
        return $this->belongsTo(CanalPago::class);
    }

    public function importador(): BelongsTo
    {
        return $this->belongsTo(User::class, 'importado_por');
    }

    public function detalles(): HasMany
    {
        return $this->hasMany(ImportacionPagoDetalle::class);
    }
}
