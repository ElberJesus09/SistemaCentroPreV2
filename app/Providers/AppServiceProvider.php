<?php

namespace App\Providers;

use App\Policies\RolePolicy;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\ServiceProvider;
use Spatie\Permission\Models\Role;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Gate::before(function ($user, string $ability): ?bool {
            if ($user->hasRole('Superadmin')) {
                return true;
            }

            if ($user->hasActiveTemporaryPermission($ability)) {
                return true;
            }

            return null;
        });

        Gate::policy(Role::class, RolePolicy::class);
    }
}
