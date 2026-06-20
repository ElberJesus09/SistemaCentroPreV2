<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('sedes', function (Blueprint $table): void {
            $table->id();
            $table->string('nombre');
            $table->string('tipo', 30)->default('principal');
            $table->string('direccion');
            $table->string('distrito')->nullable();
            $table->string('provincia')->nullable();
            $table->string('departamento')->nullable();
            $table->string('pais')->default('Peru');
            $table->string('horario')->nullable();
            $table->string('correo')->nullable();
            $table->string('telefono', 20)->nullable();
            $table->text('mapa_url')->nullable();
            $table->boolean('es_principal')->default(false);
            $table->boolean('permite_acceso_sistema')->default(true);
            $table->boolean('estado')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('sedes');
    }
};
