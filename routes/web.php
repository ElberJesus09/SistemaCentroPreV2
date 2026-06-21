<?php

use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\Institucional\CarreraController;
use App\Http\Controllers\Institucional\ConfiguracionInstitucionalController;
use App\Http\Controllers\Institucional\FacultadController;
use App\Http\Controllers\Institucional\GrupoAcademicoController;
use App\Http\Controllers\IngresosAdmision\Pagos\CodigoPagoExternoController;
use App\Http\Controllers\IngresosAdmision\Academico\CicloAcademicoController;
use App\Http\Controllers\IngresosAdmision\Academico\OfertaAcademicaController;
use App\Http\Controllers\IngresosAdmision\Academico\TurnoController;
use App\Http\Controllers\IngresosAdmision\Alumnos\AlumnoCorreoController;
use App\Http\Controllers\IngresosAdmision\Alumnos\AlumnoController;
use App\Http\Controllers\IngresosAdmision\Alumnos\AlumnoDocumentoController;
use App\Http\Controllers\IngresosAdmision\Pagos\ImportacionPagoController;
use App\Http\Controllers\IngresosAdmision\Pagos\PagoController;
use App\Http\Controllers\IngresosAdmision\Pagos\ReprocesamientoPagoController;
use App\Http\Controllers\Institucional\SedeController;
use App\Http\Controllers\Personal\RolController;
use App\Http\Controllers\Personal\TrabajadorController;
use App\Http\Controllers\Personal\UsuarioPermisoTemporalController;
use App\Http\Controllers\Personal\UsuarioController;
use App\Http\Controllers\Publico\CarreraController as CarreraPublicaController;
use App\Http\Controllers\Publico\InicioController;
use App\Http\Controllers\Publico\SedeController as SedePublicaController;
use Illuminate\Support\Facades\Route;

Route::get('/', InicioController::class)->name('inicio');
Route::get('/carreras', CarreraPublicaController::class)->name('publico.carreras');
Route::get('/sedes', SedePublicaController::class)->name('publico.sedes');

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

Route::middleware(['auth', 'permission:acceder modulo ingresos admision'])
    ->prefix('ingresos-admision')
    ->name('ingresos-admision.')
    ->group(function (): void {
        Route::resource('ciclos', CicloAcademicoController::class)
            ->middleware([
                'index' => 'permission:ver ciclos academicos',
                'create' => 'permission:gestionar ciclos academicos',
                'store' => 'permission:gestionar ciclos academicos',
                'edit' => 'permission:gestionar ciclos academicos',
                'update' => 'permission:gestionar ciclos academicos',
                'destroy' => 'permission:gestionar ciclos academicos',
            ])
            ->parameters(['ciclos' => 'ciclo'])
            ->except(['show']);

        Route::resource('turnos', TurnoController::class)
            ->middleware([
                'index' => 'permission:ver turnos',
                'create' => 'permission:gestionar turnos',
                'store' => 'permission:gestionar turnos',
                'edit' => 'permission:gestionar turnos',
                'update' => 'permission:gestionar turnos',
                'destroy' => 'permission:gestionar turnos',
            ])
            ->except(['show']);

        Route::resource('ofertas', OfertaAcademicaController::class)
            ->middleware([
                'index' => 'permission:ver ofertas academicas',
                'create' => 'permission:gestionar ofertas academicas',
                'store' => 'permission:gestionar ofertas academicas',
                'edit' => 'permission:gestionar ofertas academicas',
                'update' => 'permission:gestionar ofertas academicas',
                'destroy' => 'permission:gestionar ofertas academicas',
            ])
            ->parameters(['ofertas' => 'oferta'])
            ->except(['show']);

        Route::get('alumnos', [AlumnoController::class, 'index'])
            ->middleware('permission:ver alumnos')
            ->name('alumnos.index');
        Route::get('alumnos/create', [AlumnoController::class, 'create'])
            ->middleware('permission:crear alumnos')
            ->name('alumnos.create');
        Route::post('alumnos', [AlumnoController::class, 'store'])
            ->middleware('permission:crear alumnos')
            ->name('alumnos.store');
        Route::post('alumnos/verificar-pagos', [AlumnoController::class, 'verificarPagos'])
            ->middleware('permission:crear alumnos')
            ->name('alumnos.verificar-pagos');
        Route::get('alumnos/{alumno}', [AlumnoController::class, 'show'])
            ->middleware('permission:ver alumnos')
            ->whereNumber('alumno')
            ->name('alumnos.show');
        Route::get('alumnos/{alumno}/edit', [AlumnoController::class, 'edit'])
            ->middleware('permission:editar alumnos')
            ->whereNumber('alumno')
            ->name('alumnos.edit');
        Route::put('alumnos/{alumno}', [AlumnoController::class, 'update'])
            ->middleware('permission:editar alumnos')
            ->whereNumber('alumno')
            ->name('alumnos.update');
        Route::delete('alumnos/{alumno}', [AlumnoController::class, 'destroy'])
            ->middleware('permission:desactivar alumnos')
            ->whereNumber('alumno')
            ->name('alumnos.destroy');
        Route::get('alumnos/{alumno}/documentos/{documento}', AlumnoDocumentoController::class)
            ->middleware('permission:ver alumnos')
            ->whereNumber('alumno')
            ->whereIn('documento', ['ficha', 'declaracion', 'reglamento'])
            ->name('alumnos.documentos.download');
        Route::post('alumnos/{alumno}/correos/documentos', [AlumnoCorreoController::class, 'documentos'])
            ->middleware('permission:enviar correos alumnos')
            ->whereNumber('alumno')
            ->name('alumnos.correos.documentos');
        Route::post('alumnos/{alumno}/correos/aviso', [AlumnoCorreoController::class, 'aviso'])
            ->middleware('permission:enviar correos alumnos')
            ->whereNumber('alumno')
            ->name('alumnos.correos.aviso');

        Route::prefix('pagos')
            ->name('pagos.')
            ->group(function (): void {
                Route::get('/', [PagoController::class, 'index'])
                    ->middleware('permission:ver pagos')
                    ->name('index');

                Route::post('importaciones/previsualizar', [ImportacionPagoController::class, 'preview'])
                    ->middleware('permission:importar pagos')
                    ->name('importaciones.preview');

                Route::post('importaciones/confirmar', [ImportacionPagoController::class, 'confirm'])
                    ->middleware('permission:importar pagos')
                    ->name('importaciones.confirm');

                Route::resource('importaciones', ImportacionPagoController::class)
                    ->middleware([
                        'index' => 'permission:ver importaciones de pagos',
                        'create' => 'permission:importar pagos',
                        'show' => 'permission:ver detalles de importacion',
                    ])
                    ->parameters(['importaciones' => 'importacion'])
                    ->only(['index', 'create', 'show']);
                Route::get('importaciones/{importacion}/descargar', [ImportacionPagoController::class, 'download'])
                    ->middleware('permission:descargar archivos de pagos')
                    ->name('importaciones.download');

                Route::post('detalles/{detalle}/reprocesar', [ReprocesamientoPagoController::class, 'store'])
                    ->middleware('permission:reprocesar pagos observados')
                    ->name('detalles.reprocesar');

                Route::resource('codigos-externos', CodigoPagoExternoController::class)
                    ->middleware('permission:gestionar codigos externos de pago')
                    ->parameters(['codigos-externos' => 'codigoExterno'])
                    ->except(['show']);

                Route::get('/{pago}', [PagoController::class, 'show'])
                    ->middleware('permission:ver pagos')
                    ->whereNumber('pago')
                    ->name('show');
            });
    });
