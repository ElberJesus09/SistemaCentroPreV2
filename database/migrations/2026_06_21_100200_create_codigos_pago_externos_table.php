<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('codigos_pago_externos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('canal_pago_id')->constrained('canales_pago')->cascadeOnUpdate()->restrictOnDelete();
            $table->foreignId('concepto_pago_id')->constrained('conceptos_pago')->cascadeOnUpdate()->restrictOnDelete();
            $table->string('codigo_externo', 120);
            $table->string('descripcion_externa')->nullable();
            $table->boolean('estado')->default(true);
            $table->timestamps();

            $table->unique(['canal_pago_id', 'codigo_externo'], 'codigos_pago_externos_canal_codigo_unique');
            $table->index('concepto_pago_id');
            $table->index('codigo_externo');
            $table->index('estado');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('codigos_pago_externos');
    }
};
