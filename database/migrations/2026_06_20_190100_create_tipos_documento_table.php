<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('tipos_documento', function (Blueprint $table): void {
            $table->id();
            $table->string('nombre');
            $table->string('codigo', 20)->unique();
            $table->unsignedTinyInteger('longitud_minima')->nullable();
            $table->unsignedTinyInteger('longitud_maxima')->nullable();
            $table->boolean('es_numerico')->default(false);
            $table->boolean('estado')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('tipos_documento');
    }
};
