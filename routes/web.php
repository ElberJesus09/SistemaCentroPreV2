<?php

use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\Institucional\CarreraController;
use App\Http\Controllers\Institucional\ConfiguracionInstitucionalController;
use App\Http\Controllers\Institucional\FacultadController;
use App\Http\Controllers\Institucional\GrupoAcademicoController;
use App\Http\Controllers\Institucional\SedeController;
use App\Http\Controllers\Personal\RolController;
use App\Http\Controllers\Personal\TrabajadorController;
use App\Http\Controllers\Personal\UsuarioPermisoTemporalController;
use App\Http\Controllers\Personal\UsuarioController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return auth()->check()
        ? redirect()->route('dashboard')
        : redirect()->route('login');
});

Route::get('/dashboard', DashboardController::class)
    ->middleware(['auth', 'permission:acceder dashboard'])
    ->name('dashboard');

Route::middleware('guest')->group(function (): void {
    Route::get('/login', [LoginController::class, 'create'])->name('login');
    Route::post('/login', [LoginController::class, 'store'])->name('login.store');
});

Route::post('/logout', [LoginController::class, 'destroy'])
    ->middleware('auth')
    ->name('logout');

Route::middleware(['auth', 'permission:acceder modulo personal'])
    ->prefix('personal')
    ->name('personal.')
    ->group(function (): void {
        Route::resource('trabajadores', TrabajadorController::class)
            ->parameters(['trabajadores' => 'trabajador']);
        Route::resource('usuarios', UsuarioController::class)
            ->parameters(['usuarios' => 'usuario']);
        Route::post('usuarios/{usuario}/permisos-temporales', [UsuarioPermisoTemporalController::class, 'store'])
            ->name('usuarios.permisos-temporales.store');
        Route::delete('usuarios/{usuario}/permisos-temporales/{permisoTemporal}', [UsuarioPermisoTemporalController::class, 'destroy'])
            ->name('usuarios.permisos-temporales.destroy');
        Route::resource('roles', RolController::class)
            ->parameters(['roles' => 'role']);
    });

Route::middleware(['auth', 'permission:acceder modulo institucional'])
    ->prefix('institucional')
    ->name('institucional.')
    ->group(function (): void {
        Route::get('configuracion', [ConfiguracionInstitucionalController::class, 'edit'])
            ->middleware('permission:editar institucional')
            ->name('configuracion.edit');

        Route::put('configuracion', [ConfiguracionInstitucionalController::class, 'update'])
            ->middleware('permission:editar institucional')
            ->name('configuracion.update');

        Route::resource('sedes', SedeController::class);
        Route::resource('grupos-academicos', GrupoAcademicoController::class)
            ->parameters(['grupos-academicos' => 'grupoAcademico']);
        Route::resource('facultades', FacultadController::class)
            ->parameters(['facultades' => 'facultad']);
        Route::resource('carreras', CarreraController::class);
    });
