<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('trabajadores', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $table->foreignId('sede_id')->nullable()->constrained('sedes')->nullOnDelete();
            $table->foreignId('tipo_documento_id')->constrained('tipos_documento')->restrictOnDelete();
            $table->string('numero_documento', 30);
            $table->string('nombres');
            $table->string('apellidos');
            $table->string('telefono', 20)->nullable();
            $table->string('direccion')->nullable();
            $table->string('correo')->nullable();
            $table->boolean('estado')->default(true);
            $table->timestamps();

            $table->unique(['tipo_documento_id', 'numero_documento']);
            $table->unique('user_id');
            $table->index(['apellidos', 'nombres']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('trabajadores');
    }
};
