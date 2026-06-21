<?php

use App\Models\CanalPago;
use App\Models\CodigoPagoExterno;
use App\Models\ConceptoPago;
use Database\Seeders\CanalPagoSeeder;
use Database\Seeders\CodigoPagoExternoSeeder;
use Database\Seeders\ConceptoPagoSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

test('crea canales iniciales de pago', function () {
    $this->seed(CanalPagoSeeder::class);

    expect(CanalPago::query()->pluck('codigo')->all())
        ->toContain('BANCO_NACION')
        ->toContain('PAGALO_PE');
});

test('crea conceptos iniciales de pago', function () {
    $this->seed(ConceptoPagoSeeder::class);

    expect(ConceptoPago::query()->pluck('codigo')->all())
        ->toContain('MATRICULA')
        ->toContain('PENSION');
});

test('crea codigos externos iniciales del banco de la nacion', function () {
    $this->seed([CanalPagoSeeder::class, ConceptoPagoSeeder::class, CodigoPagoExternoSeeder::class]);

    $codigos = CodigoPagoExterno::query()
        ->with('conceptoPago')
        ->pluck('concepto_pago_id', 'codigo_externo');

    $matriculaId = ConceptoPago::query()->where('codigo', 'MATRICULA')->value('id');
    $pensionId = ConceptoPago::query()->where('codigo', 'PENSION')->value('id');

    expect($codigos['00001096'])->toBe($matriculaId)
        ->and($codigos['00001097'])->toBe($pensionId);
});
