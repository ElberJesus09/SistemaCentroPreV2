<?php

use App\Services\IngresosAdmision\Pagos\NormalizacionDocumentoService;

test('normaliza dni con ceros al final', function () {
    $service = new NormalizacionDocumentoService();

    expect($service->normalize('DNI', '610742190000'))
        ->toBe(['tipo' => 'DNI', 'numero' => '61074219']);
});

test('no recorta carnet de extranjeria', function () {
    $service = new NormalizacionDocumentoService();

    expect($service->normalize('Carnet de extranjeria', '0012340000'))
        ->toBe(['tipo' => 'CARNET_EXTRANJERIA', 'numero' => '0012340000']);
});

test('observa dni no normalizable', function () {
    $service = new NormalizacionDocumentoService();

    $service->normalize('DNI', '610742191234');
})->throws(InvalidArgumentException::class, 'DNI no normalizable.');
