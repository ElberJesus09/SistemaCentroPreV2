<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ciclos_academicos', function (Blueprint $table): void {
            $table->id();
            $table->string('codigo', 40)->unique();
            $table->string('nombre');
            $table->date('fecha_inicio');
            $table->date('fecha_fin');
            $table->date('fecha_inicio_inscripcion')->nullable();
            $table->date('fecha_fin_inscripcion')->nullable();
            $table->boolean('estado')->default(true);
            $table->timestamps();

            $table->index('fecha_inicio');
            $table->index('fecha_fin');
            $table->index('estado');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ciclos_academicos');
    }
};
