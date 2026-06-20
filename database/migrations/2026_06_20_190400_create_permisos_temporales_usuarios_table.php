<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('permisos_temporales_usuarios', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('permission_id')->constrained('permissions')->cascadeOnDelete();
            $table->foreignId('granted_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('starts_at')->nullable();
            $table->timestamp('expires_at');
            $table->timestamp('revoked_at')->nullable();
            $table->string('reason')->nullable();
            $table->timestamps();

            $table->index(['user_id', 'permission_id', 'expires_at', 'revoked_at'], 'temporary_permissions_active_index');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('permisos_temporales_usuarios');
    }
};
