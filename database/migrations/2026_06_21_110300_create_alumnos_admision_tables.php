<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('alumnos', function (Blueprint $table): void {
            $table->id();
            $table->string('codigo', 6)->unique();
            $table->foreignId('tipo_documento_id')->constrained('tipos_documento')->cascadeOnUpdate()->restrictOnDelete();
            $table->string('numero_documento', 60);
            $table->string('nombres');
            $table->string('apellido_paterno');
            $table->string('apellido_materno')->nullable();
            $table->date('fecha_nacimiento');
            $table->string('genero', 30);
            $table->string('telefono', 20)->nullable();
            $table->string('correo')->nullable();
            $table->string('departamento')->nullable();
            $table->string('provincia')->nullable();
            $table->string('distrito')->nullable();
            $table->string('direccion')->nullable();
            $table->string('estado', 40);
            $table->foreignId('registrado_por')->nullable()->constrained('users')->cascadeOnUpdate()->nullOnDelete();
            $table->timestamps();

            $table->index('codigo');
            $table->unique(['tipo_documento_id', 'numero_documento'], 'alumnos_tipo_numero_unique');
            $table->index('numero_documento');
            $table->index('estado');
            $table->index('registrado_por');
        });

        Schema::create('apoderados', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('tipo_documento_id')->constrained('tipos_documento')->cascadeOnUpdate()->restrictOnDelete();
            $table->string('numero_documento', 60);
            $table->string('nombres');
            $table->string('apellido_paterno');
            $table->string('apellido_materno')->nullable();
            $table->string('telefono', 20);
            $table->string('correo')->nullable();
            $table->string('direccion')->nullable();
            $table->string('estado', 40);
            $table->timestamps();

            $table->unique(['tipo_documento_id', 'numero_documento'], 'apoderados_tipo_numero_unique');
            $table->index('numero_documento');
            $table->index('estado');
        });

        Schema::create('alumno_apoderado', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('alumno_id')->constrained('alumnos')->cascadeOnUpdate()->cascadeOnDelete();
            $table->foreignId('apoderado_id')->constrained('apoderados')->cascadeOnUpdate()->restrictOnDelete();
            $table->string('parentesco', 40);
            $table->boolean('es_principal')->default(true);
            $table->boolean('vive_con_alumno')->nullable();
            $table->timestamps();

            $table->unique(['alumno_id', 'apoderado_id'], 'alumno_apoderado_unique');
            $table->index('parentesco');
        });

        Schema::create('colegios', function (Blueprint $table): void {
            $table->id();
            $table->string('codigo_modular', 40)->nullable()->unique();
            $table->string('nombre');
            $table->string('tipo_gestion', 40)->nullable();
            $table->string('departamento')->nullable();
            $table->string('provincia')->nullable();
            $table->string('distrito')->nullable();
            $table->boolean('estado')->default(true);
            $table->timestamps();

            $table->index('nombre');
            $table->index(['departamento', 'provincia', 'distrito'], 'colegios_ubicacion_index');
            $table->index('estado');
        });

        Schema::create('alumno_colegio', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('alumno_id')->constrained('alumnos')->cascadeOnUpdate()->cascadeOnDelete();
            $table->foreignId('colegio_id')->constrained('colegios')->cascadeOnUpdate()->restrictOnDelete();
            $table->unsignedSmallInteger('anio_egreso');
            $table->boolean('es_principal')->default(true);
            $table->timestamps();

            $table->unique(['alumno_id', 'colegio_id', 'anio_egreso'], 'alumno_colegio_unique');
        });

        Schema::create('inscripciones', function (Blueprint $table): void {
            $table->id();
            $table->string('codigo', 40)->unique();
            $table->foreignId('alumno_id')->constrained('alumnos')->cascadeOnUpdate()->restrictOnDelete();
            $table->foreignId('oferta_academica_id')->constrained('ofertas_academicas')->cascadeOnUpdate()->restrictOnDelete();
            $table->foreignId('carrera_id')->constrained('carreras')->cascadeOnUpdate()->restrictOnDelete();
            $table->foreignId('colegio_id')->nullable()->constrained('colegios')->cascadeOnUpdate()->nullOnDelete();
            $table->date('fecha_inscripcion');
            $table->string('estado', 60);
            $table->text('observacion')->nullable();
            $table->foreignId('registrado_por')->constrained('users')->cascadeOnUpdate()->restrictOnDelete();
            $table->foreignId('revisado_por')->nullable()->constrained('users')->cascadeOnUpdate()->nullOnDelete();
            $table->timestamp('revisado_at')->nullable();
            $table->timestamps();

            $table->index('alumno_id');
            $table->index('oferta_academica_id');
            $table->index('carrera_id');
            $table->index('estado');
            $table->index('fecha_inscripcion');
        });

        Schema::create('matriculas', function (Blueprint $table): void {
            $table->id();
            $table->string('codigo', 40)->unique();
            $table->foreignId('alumno_id')->constrained('alumnos')->cascadeOnUpdate()->restrictOnDelete();
            $table->foreignId('inscripcion_id')->unique()->constrained('inscripciones')->cascadeOnUpdate()->restrictOnDelete();
            $table->foreignId('oferta_academica_id')->constrained('ofertas_academicas')->cascadeOnUpdate()->restrictOnDelete();
            $table->foreignId('carrera_id')->constrained('carreras')->cascadeOnUpdate()->restrictOnDelete();
            $table->date('fecha_matricula');
            $table->string('estado', 60);
            $table->string('estado_pagos', 60);
            $table->foreignId('registrado_por')->constrained('users')->cascadeOnUpdate()->restrictOnDelete();
            $table->timestamp('activado_at')->nullable();
            $table->timestamps();

            $table->index('alumno_id');
            $table->index('oferta_academica_id');
            $table->index('carrera_id');
            $table->index('estado');
            $table->index('estado_pagos');
        });

        Schema::create('historial_estados_inscripcion', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('inscripcion_id')->constrained('inscripciones')->cascadeOnUpdate()->cascadeOnDelete();
            $table->string('estado_anterior', 60)->nullable();
            $table->string('estado_nuevo', 60);
            $table->text('observacion')->nullable();
            $table->foreignId('cambiado_por')->constrained('users')->cascadeOnUpdate()->restrictOnDelete();
            $table->timestamps();
        });

        Schema::create('historial_estados_matricula', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('matricula_id')->constrained('matriculas')->cascadeOnUpdate()->cascadeOnDelete();
            $table->string('estado_anterior', 60)->nullable();
            $table->string('estado_nuevo', 60);
            $table->text('observacion')->nullable();
            $table->foreignId('cambiado_por')->constrained('users')->cascadeOnUpdate()->restrictOnDelete();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('historial_estados_matricula');
        Schema::dropIfExists('historial_estados_inscripcion');
        Schema::dropIfExists('matriculas');
        Schema::dropIfExists('inscripciones');
        Schema::dropIfExists('alumno_colegio');
        Schema::dropIfExists('colegios');
        Schema::dropIfExists('alumno_apoderado');
        Schema::dropIfExists('apoderados');
        Schema::dropIfExists('alumnos');
    }
};
