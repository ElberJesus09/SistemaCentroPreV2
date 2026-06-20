<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('carreras', function (Blueprint $table): void {
            $table->id();
            $table->string('codigo')->unique();
            $table->string('nombre');
            $table->foreignId('grupo_academico_id')->constrained('grupos_academicos')->restrictOnDelete();
            $table->foreignId('facultad_id')->constrained('facultades')->restrictOnDelete();
            $table->string('enlace')->nullable();
            $table->boolean('es_destacada')->default(false);
            $table->boolean('estado')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('carreras');
    }
};
