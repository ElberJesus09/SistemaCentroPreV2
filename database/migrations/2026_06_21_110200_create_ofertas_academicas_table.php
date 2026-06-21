<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ofertas_academicas', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('ciclo_academico_id')->constrained('ciclos_academicos')->cascadeOnUpdate()->restrictOnDelete();
            $table->foreignId('sede_id')->constrained('sedes')->cascadeOnUpdate()->restrictOnDelete();
            $table->foreignId('turno_id')->constrained('turnos')->cascadeOnUpdate()->restrictOnDelete();
            $table->unsignedInteger('capacidad');
            $table->unsignedInteger('matriculados')->default(0);
            $table->decimal('costo_matricula', 10, 2)->nullable();
            $table->decimal('costo_pension', 10, 2)->nullable();
            $table->date('fecha_inicio_inscripcion')->nullable();
            $table->date('fecha_fin_inscripcion')->nullable();
            $table->boolean('estado')->default(true);
            $table->timestamps();

            $table->unique(['ciclo_academico_id', 'sede_id', 'turno_id'], 'ofertas_ciclo_sede_turno_unique');
            $table->index('ciclo_academico_id');
            $table->index('sede_id');
            $table->index('turno_id');
            $table->index('estado');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ofertas_academicas');
    }
};
