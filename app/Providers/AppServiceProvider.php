<?php

namespace App\Providers;

use App\Mail\Transport\RelayTransport;
use App\Policies\RolePolicy;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\URL;
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
        if ($this->app->environment('production')) {
            URL::forceScheme('https');
        }

        Mail::extend('relay', function (array $config): RelayTransport {
            return new RelayTransport(
                (string) ($config['url'] ?? ''),
                (string) ($config['token'] ?? ''),
                (int) ($config['timeout'] ?? 30),
            );
        });

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
