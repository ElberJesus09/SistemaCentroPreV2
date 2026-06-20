<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('configuracion_institucional', function (Blueprint $table): void {
            $table->id();
            $table->string('nombre');
            $table->string('institucion_relacionada');
            $table->text('proposito_portal')->nullable();
            $table->text('descripcion_publica')->nullable();
            $table->string('correo')->nullable();
            $table->string('telefono', 20)->nullable();
            $table->string('sitio_web')->nullable();
            $table->string('logo')->nullable();
            $table->boolean('estado')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('configuracion_institucional');
    }
};
