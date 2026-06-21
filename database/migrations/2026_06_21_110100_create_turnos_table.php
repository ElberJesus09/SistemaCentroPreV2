<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('turnos', function (Blueprint $table): void {
            $table->id();
            $table->string('codigo', 40)->unique();
            $table->string('nombre')->unique();
            $table->time('hora_inicio')->nullable();
            $table->time('hora_fin')->nullable();
            $table->boolean('estado')->default(true);
            $table->timestamps();

            $table->index('estado');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('turnos');
    }
};
