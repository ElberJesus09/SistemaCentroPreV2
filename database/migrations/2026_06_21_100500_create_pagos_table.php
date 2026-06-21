<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pagos', function (Blueprint $table) {
            $table->id();
            $table->string('tipo_documento', 60);
            $table->string('numero_documento', 60);
            $table->string('voucher', 120);
            $table->date('fecha_pago');
            $table->string('agencia', 60)->nullable();
            $table->foreignId('concepto_pago_id')->constrained('conceptos_pago')->cascadeOnUpdate()->restrictOnDelete();
            $table->foreignId('canal_pago_id')->constrained('canales_pago')->cascadeOnUpdate()->restrictOnDelete();
            $table->foreignId('importacion_pago_detalle_id')->unique()->constrained('importacion_pago_detalles')->cascadeOnUpdate()->restrictOnDelete();
            $table->string('estado', 60);
            $table->text('observacion')->nullable();
            $table->timestamps();

            $table->unique(['canal_pago_id', 'voucher'], 'pagos_canal_voucher_unique');
            $table->index('tipo_documento');
            $table->index('numero_documento');
            $table->index('voucher');
            $table->index('fecha_pago');
            $table->index('concepto_pago_id');
            $table->index('canal_pago_id');
            $table->index('estado');
        });

        Schema::table('importacion_pago_detalles', function (Blueprint $table) {
            $table->foreign('pago_id')->references('id')->on('pagos')->cascadeOnUpdate()->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('importacion_pago_detalles', function (Blueprint $table) {
            $table->dropForeign(['pago_id']);
        });
        Schema::dropIfExists('pagos');
    }
};
