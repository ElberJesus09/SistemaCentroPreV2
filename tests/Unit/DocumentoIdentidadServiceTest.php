<?php

use App\Models\TipoDocumento;
use App\Services\Documentos\DocumentoIdentidadService;

test('acepta carne de extranjeria numerico de 9 digitos', function () {
    $tipo = new TipoDocumento([
        'codigo' => 'CE',
        'longitud_minima' => 9,
        'longitud_maxima' => 9,
        'es_numerico' => false,
        'permite_letras' => true,
    ]);

    expect(app(DocumentoIdentidadService::class)->normalizar($tipo, '123456789'))
        ->toBe('123456789');
});

test('acepta carne de extranjeria antiguo con n y 8 digitos', function () {
    $tipo = new TipoDocumento([
        'codigo' => 'CE',
        'longitud_minima' => 9,
        'longitud_maxima' => 9,
        'es_numerico' => false,
        'permite_letras' => true,
    ]);

    expect(app(DocumentoIdentidadService::class)->normalizar($tipo, 'n12345678'))
        ->toBe('N12345678');
});

test('rechaza carne de extranjeria con separadores o letras no permitidas', function (string $numero) {
    $tipo = new TipoDocumento([
        'codigo' => 'CE',
        'longitud_minima' => 9,
        'longitud_maxima' => 9,
        'es_numerico' => false,
        'permite_letras' => true,
    ]);

    app(DocumentoIdentidadService::class)->normalizar($tipo, $numero);
})->with(['123 456789', '123-456789', 'A12345678'])->throws(InvalidArgumentException::class);
