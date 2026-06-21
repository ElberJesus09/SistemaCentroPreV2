<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('importacion_pago_detalles', function (Blueprint $table) {
            $table->id();
            $table->foreignId('importacion_pago_id')->constrained('importaciones_pago')->cascadeOnUpdate()->cascadeOnDelete();
            $table->unsignedInteger('numero_fila');
            $table->string('tipo_documento', 60)->nullable();
            $table->string('numero_documento', 60)->nullable();
            $table->string('voucher', 120)->nullable();
            $table->date('fecha_pago')->nullable();
            $table->string('agencia', 60)->nullable();
            $table->string('codigo_pago', 120)->nullable();
            $table->json('datos_origen')->nullable();
            $table->string('estado', 60);
            $table->text('mensaje')->nullable();
            $table->unsignedBigInteger('pago_id')->nullable();
            $table->timestamps();

            $table->unique(['importacion_pago_id', 'numero_fila'], 'importacion_pago_detalle_fila_unique');
            $table->index('importacion_pago_id');
            $table->index('tipo_documento');
            $table->index('numero_documento');
            $table->index('voucher');
            $table->index('codigo_pago');
            $table->index('estado');
            $table->index('pago_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('importacion_pago_detalles');
    }
};
