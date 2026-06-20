<?php

namespace App\Models;

use Database\Factories\TrabajadorFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Trabajador extends Model
{
    /** @use HasFactory<TrabajadorFactory> */
    use HasFactory;

    protected $table = 'trabajadores';

    /**
     * @var list<string>
     */
    protected $fillable = [
        'user_id',
        'sede_id',
        'tipo_documento_id',
        'numero_documento',
        'nombres',
        'apellidos',
        'telefono',
        'direccion',
        'correo',
        'estado',
    ];

    protected function casts(): array
    {
        return [
            'estado' => 'boolean',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function sede(): BelongsTo
    {
        return $this->belongsTo(Sede::class);
    }

    public function tipoDocumento(): BelongsTo
    {
        return $this->belongsTo(TipoDocumento::class);
    }
}
