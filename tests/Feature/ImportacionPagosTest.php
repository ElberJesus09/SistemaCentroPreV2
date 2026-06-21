<?php

use App\Models\CanalPago;
use App\Models\CodigoPagoExterno;
use App\Models\ConceptoPago;
use App\Models\ImportacionPago;
use App\Models\Pago;
use App\Models\User;
use App\Services\IngresosAdmision\Pagos\ImportacionPagoService;
use Database\Seeders\CanalPagoSeeder;
use Database\Seeders\ConceptoPagoSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Carbon;

uses(RefreshDatabase::class);

test('importa pagos validos y observa filas invalidas', function () {
    $this->seed([CanalPagoSeeder::class, ConceptoPagoSeeder::class]);

    $canal = CanalPago::query()->where('codigo', 'BANCO_NACION')->firstOrFail();
    $matricula = ConceptoPago::query()->where('codigo', 'MATRICULA')->firstOrFail();
    CodigoPagoExterno::query()->create([
        'canal_pago_id' => $canal->id,
        'concepto_pago_id' => $matricula->id,
        'codigo_externo' => 'MAT001',
        'estado' => true,
    ]);

    $user = User::factory()->create();
    $file = new UploadedFile(
        createTestXlsx([
            ['NOMBRE_TDOC', 'DOCUMENTO', 'VOUCHER', 'COD_PAGO', 'FECHA_PAGO', 'AGENCIA'],
            ['DNI', '610742190000', 'V001', 'MAT001', '2026-06-16', '0001'],
            ['DNI', '610742191234', 'V002', 'MAT001', '2026-06-16', '0001'],
        ]),
        'pagos.xlsx',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        null,
        true,
    );

    app(ImportacionPagoService::class)->import($canal, Carbon::parse('2026-06-16'), $file, $user->id);

    expect(Pago::query()->count())->toBe(1)
        ->and(Pago::query()->first()->numero_documento)->toBe('61074219')
        ->and(ImportacionPago::query()->first()->registros_observados)->toBe(1);
});

test('lee formato banco nacion con age y codigos con ceros', function () {
    $this->seed([CanalPagoSeeder::class, ConceptoPagoSeeder::class]);

    $canal = CanalPago::query()->where('codigo', 'BANCO_NACION')->firstOrFail();
    $matricula = ConceptoPago::query()->where('codigo', 'MATRICULA')->firstOrFail();
    CodigoPagoExterno::query()->create([
        'canal_pago_id' => $canal->id,
        'concepto_pago_id' => $matricula->id,
        'codigo_externo' => '00001096',
        'estado' => true,
    ]);

    $user = User::factory()->create();
    $file = new UploadedFile(
        createTestXlsx([
            ['NRO', 'COD.', 'COD_ALUMNO', 'DOCUMENTO', 'VOUCHER', 'CODIGO_TDOC', 'NOMBRE_TDOC', 'SITUACION', 'COD_PAGO', 'CONCEPTO_PAGO', 'APELLIDOS_NOMBRES', 'CUENTA', 'FECHA_PAGO', 'HORA', 'IMPORTE_S/.', 'CAJ.', 'AGE.'],
            ['9', '004', '-', '75808207000000', '3037659', '01', 'DNI', '00090009', '1096', '*** DESCONOCIDO ***', 'CAMPOVERDE PARIATON NATALIA EL', '0301029403', '16-06-2026', '16:22:03', '200', '6434', '0248'],
        ]),
        'banco.xlsx',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        null,
        true,
    );

    app(ImportacionPagoService::class)->import($canal, Carbon::parse('2026-06-16'), $file, $user->id);

    $pago = Pago::query()->first();

    expect($pago)->not->toBeNull()
        ->and($pago->numero_documento)->toBe('75808207')
        ->and($pago->agencia)->toBe('0248')
        ->and($pago->voucher)->toBe('3037659');
});

test('reconoce xlsx aunque la ruta temporal no tenga extension', function () {
    $this->seed([CanalPagoSeeder::class]);

    $canal = CanalPago::query()->where('codigo', 'BANCO_NACION')->firstOrFail();
    $xlsx = createTestXlsx([
        ['DOCUMENTO', 'VOUCHER', 'COD_PAGO', 'AGENCIA'],
        ['75808207000000', '3037659', '1096', '0248'],
    ]);
    $temporalSinExtension = tempnam(sys_get_temp_dir(), 'upload');
    copy($xlsx, $temporalSinExtension);

    $rows = app(ImportacionPagoService::class)->readRows($canal, $temporalSinExtension, 'xlsx');

    expect($rows)->toHaveCount(1)
        ->and($rows[0]['datos']['DOCUMENTO'])->toBe('75808207000000');
});

/**
 * @param  list<list<string>>  $rows
 */
function createTestXlsx(array $rows): string
{
    $path = tempnam(sys_get_temp_dir(), 'pagos').'.xlsx';
    $sheetRows = '';

    foreach ($rows as $index => $row) {
        $number = $index + 1;
        $cells = '';
        foreach ($row as $columnIndex => $value) {
            $column = chr(65 + $columnIndex);
            $escaped = htmlspecialchars($value, ENT_XML1);
            $cells .= "<c r=\"{$column}{$number}\" t=\"inlineStr\"><is><t>{$escaped}</t></is></c>";
        }
        $sheetRows .= "<row r=\"{$number}\">{$cells}</row>";
    }

    $xml = '<?xml version="1.0" encoding="UTF-8"?>'
        .'<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">'
        ."<sheetData>{$sheetRows}</sheetData>"
        .'</worksheet>';

    $zip = new \ZipArchive();
    $zip->open($path, \ZipArchive::CREATE);
    $zip->addFromString('xl/worksheets/sheet1.xml', $xml);
    $zip->close();

    return $path;
}
