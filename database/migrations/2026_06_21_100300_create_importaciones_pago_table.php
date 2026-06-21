<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('importaciones_pago', function (Blueprint $table) {
            $table->id();
            $table->foreignId('canal_pago_id')->constrained('canales_pago')->cascadeOnUpdate()->restrictOnDelete();
            $table->date('fecha_referencia');
            $table->string('nombre_archivo');
            $table->string('nombre_interno')->nullable();
            $table->string('disco', 60)->nullable();
            $table->string('ruta_archivo')->nullable();
            $table->string('mime_type')->nullable();
            $table->string('extension', 20)->nullable();
            $table->unsignedBigInteger('tamano')->nullable();
            $table->string('hash_archivo', 64)->unique();
            $table->unsignedInteger('total_registros')->default(0);
            $table->unsignedInteger('registros_procesados')->default(0);
            $table->unsignedInteger('registros_importados')->default(0);
            $table->unsignedInteger('registros_observados')->default(0);
            $table->foreignId('importado_por')->constrained('users')->cascadeOnUpdate()->restrictOnDelete();
            $table->string('estado', 60);
            $table->timestamp('iniciado_at')->nullable();
            $table->timestamp('finalizado_at')->nullable();
            $table->text('mensaje_error')->nullable();
            $table->timestamps();

            $table->index('canal_pago_id');
            $table->index('fecha_referencia');
            $table->index('importado_por');
            $table->index('estado');
            $table->index('created_at');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('importaciones_pago');
    }
};
