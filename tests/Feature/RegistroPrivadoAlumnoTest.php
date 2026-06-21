<?php

use App\Enums\IngresosAdmision\Pagos\EstadoPago;
use App\Models\CanalPago;
use App\Models\Carrera;
use App\Models\CicloAcademico;
use App\Models\CodigoPagoExterno;
use App\Models\ConceptoPago;
use App\Models\Facultad;
use App\Models\GrupoAcademico;
use App\Models\OfertaAcademica;
use App\Models\Pago;
use App\Models\Sede;
use App\Models\TipoDocumento;
use App\Models\Turno;
use App\Models\User;
use Database\Seeders\RolePermissionSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

test('secretaria registra alumno con solo pago de matricula y queda pendiente de pension', function () {
    $this->seed(RolePermissionSeeder::class);
    $user = User::factory()->create();
    $user->assignRole('Secretaria');

    [$dni, $carrera, $oferta] = admisionBase();
    $matricula = ConceptoPago::query()->create(['codigo' => 'MATRICULA', 'nombre' => 'Matricula', 'estado' => true]);
    $canal = CanalPago::query()->create(['codigo' => 'BANCO_NACION', 'nombre' => 'Banco de la Nacion', 'estado' => true]);
    Pago::query()->create([
        'tipo_documento' => 'DNI',
        'numero_documento' => '75808207',
        'voucher' => '3037659',
        'fecha_pago' => '2026-06-16',
        'agencia' => '0248',
        'concepto_pago_id' => $matricula->id,
        'canal_pago_id' => $canal->id,
        'importacion_pago_detalle_id' => importacionDetalleId(),
        'estado' => EstadoPago::Disponible,
    ]);

    $response = $this->actingAs($user)->post(route('ingresos-admision.alumnos.store'), payloadAlumno($dni->id, $carrera->id, $oferta->id, [
        'voucher_matricula' => '3037659',
        'agencia_matricula' => '0248',
        'fecha_pago_matricula' => '2026-06-16',
    ]));

    expect($response->getStatusCode())->toBe(302);
    expect(Pago::query()->first()->estado)->toBe(EstadoPago::Asociado);
    $this->assertDatabaseHas('matriculas', ['estado' => 'pendiente_pago_pension', 'estado_pagos' => 'pendiente_pension']);
});

test('rechaza alumno menor sin apoderado', function () {
    $this->seed(RolePermissionSeeder::class);
    $user = User::factory()->create();
    $user->assignRole('Secretaria');

    [$dni, $carrera, $oferta] = admisionBase();

    $response = $this->actingAs($user)->post(route('ingresos-admision.alumnos.store'), payloadAlumno($dni->id, $carrera->id, $oferta->id, [
        'fecha_nacimiento' => now()->subYears(16)->toDateString(),
    ]));

    $response->assertSessionHasErrors(['apoderado_tipo_documento_id']);
});

function admisionBase(): array
{
    $dni = TipoDocumento::query()->create([
        'nombre' => 'Documento Nacional de Identidad',
        'codigo' => 'DNI',
        'longitud_minima' => 8,
        'longitud_maxima' => 8,
        'es_numerico' => true,
        'permite_letras' => false,
        'estado' => true,
    ]);
    $sede = Sede::query()->create([
        'nombre' => 'Sede Central',
        'tipo' => 'principal',
        'direccion' => 'Av. Principal',
        'distrito' => 'Lambayeque',
        'provincia' => 'Lambayeque',
        'departamento' => 'Lambayeque',
        'pais' => 'Peru',
        'estado' => true,
    ]);
    $grupo = GrupoAcademico::query()->create(['codigo' => 'A', 'nombre' => 'Grupo A', 'estado' => true]);
    $facultad = Facultad::query()->create(['sigla' => 'FACH', 'nombre' => 'Facultad', 'estado' => true]);
    $carrera = Carrera::query()->create(['codigo' => 'CAR', 'nombre' => 'Carrera', 'grupo_academico_id' => $grupo->id, 'facultad_id' => $facultad->id, 'estado' => true]);
    $ciclo = CicloAcademico::query()->create(['codigo' => '2026-I', 'nombre' => 'Ciclo 2026-I', 'fecha_inicio' => '2026-01-01', 'fecha_fin' => '2026-06-30', 'estado' => true]);
    $turno = Turno::query()->create(['codigo' => 'MANANA', 'nombre' => 'Manana', 'estado' => true]);
    $oferta = OfertaAcademica::query()->create(['ciclo_academico_id' => $ciclo->id, 'sede_id' => $sede->id, 'turno_id' => $turno->id, 'capacidad' => 10, 'estado' => true]);

    return [$dni, $carrera, $oferta];
}

function payloadAlumno(int $tipoDocumentoId, int $carreraId, int $ofertaId, array $override = []): array
{
    return array_merge([
        'tipo_documento_id' => $tipoDocumentoId,
        'numero_documento' => '75808207',
        'nombres' => 'Natalia',
        'apellido_paterno' => 'Campo',
        'apellido_materno' => 'Verde',
        'fecha_nacimiento' => '2000-01-01',
        'genero' => 'femenino',
        'telefono' => '987654321',
        'correo' => 'alumna@test.pe',
        'departamento' => 'Lambayeque',
        'provincia' => 'Lambayeque',
        'distrito' => 'Lambayeque',
        'direccion' => 'Av. Principal 123',
        'colegio_nombre' => 'Colegio Nacional',
        'colegio_departamento' => 'Lambayeque',
        'colegio_provincia' => 'Lambayeque',
        'colegio_distrito' => 'Lambayeque',
        'anio_egreso' => '2025',
        'carrera_id' => $carreraId,
        'oferta_academica_id' => $ofertaId,
    ], $override);
}

function importacionDetalleId(): int
{
    $importacion = \App\Models\ImportacionPago::query()->create([
        'canal_pago_id' => CanalPago::query()->first()->id,
        'fecha_referencia' => '2026-06-16',
        'nombre_archivo' => 'banco.xlsx',
        'extension' => 'xlsx',
        'tamano' => 100,
        'hash_archivo' => str_repeat('a', 64),
        'importado_por' => User::factory()->create()->id,
        'estado' => 'procesada',
    ]);

    return \App\Models\ImportacionPagoDetalle::query()->create([
        'importacion_pago_id' => $importacion->id,
        'numero_fila' => 2,
        'datos_origen' => [],
        'estado' => 'procesada',
    ])->id;
}
