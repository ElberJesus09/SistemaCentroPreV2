<?php

namespace App\Services\IngresosAdmision\Pagos\Readers;

use RuntimeException;
use ZipArchive;

class BancoNacionExcelReader implements PaymentFileReaderInterface
{
    public function read(string $path): array
    {
        if (! str_ends_with(strtolower($path), '.xlsx')) {
            throw new RuntimeException('Por ahora solo se puede leer XLSX. Para XLS se agregara lector binario.');
        }

        return $this->readXlsx($path);
    }

    /**
     * @return array<int, array{numero_fila: int, datos: array<string, mixed>}>
     */
    private function readXlsx(string $path): array
    {
        $zip = new ZipArchive();
        if ($zip->open($path) !== true) {
            throw new RuntimeException('No se pudo abrir el archivo XLSX.');
        }

        $shared = $this->sharedStrings($zip);
        $sheet = $zip->getFromName('xl/worksheets/sheet1.xml');
        if ($sheet === false) {
            $zip->close();
            throw new RuntimeException('El archivo no contiene una hoja principal valida.');
        }

        $xml = simplexml_load_string($sheet);
        if ($xml === false) {
            $zip->close();
            throw new RuntimeException('No se pudo leer la hoja del archivo.');
        }

        $rows = [];
        foreach ($xml->sheetData->row as $row) {
            $rowNumber = (int) $row['r'];
            $values = [];
            foreach ($row->c as $cell) {
                $reference = (string) $cell['r'];
                $column = preg_replace('/\d+/', '', $reference) ?: '';
                $values[$column] = $this->cellValue($cell, $shared);
            }
            $rows[$rowNumber] = $values;
        }
        $zip->close();

        if ($rows === []) {
            throw new RuntimeException('El archivo no contiene registros.');
        }

        $headerRow = array_key_first($rows);
        $headers = array_map(fn ($value): string => $this->normalizeHeader((string) $value), $rows[$headerRow]);
        $this->validateHeaders($headers);

        $out = [];
        foreach ($rows as $number => $row) {
            if ($number === $headerRow) {
                continue;
            }

            $data = [];
            foreach ($headers as $column => $header) {
                if ($header !== '') {
                    $data[$header] = $row[$column] ?? null;
                }
            }

            if (collect($data)->filter(fn ($value): bool => trim((string) $value) !== '')->isEmpty()) {
                continue;
            }

            $out[] = ['numero_fila' => $number, 'datos' => $data];
        }

        return $out;
    }

    /**
     * @return list<string>
     */
    private function sharedStrings(ZipArchive $zip): array
    {
        $xml = $zip->getFromName('xl/sharedStrings.xml');
        if ($xml === false) {
            return [];
        }

        $data = simplexml_load_string($xml);
        if ($data === false) {
            return [];
        }

        $strings = [];
        foreach ($data->si as $item) {
            if (isset($item->t)) {
                $strings[] = (string) $item->t;
                continue;
            }

            $text = '';
            foreach ($item->r as $run) {
                $text .= (string) $run->t;
            }
            $strings[] = $text;
        }

        return $strings;
    }

    private function cellValue(\SimpleXMLElement $cell, array $shared): mixed
    {
        $type = (string) $cell['t'];
        $raw = isset($cell->v) ? (string) $cell->v : '';

        return match ($type) {
            's' => $shared[(int) $raw] ?? '',
            'inlineStr' => (string) ($cell->is->t ?? ''),
            default => $raw,
        };
    }

    private function normalizeHeader(string $value): string
    {
        $value = strtoupper(trim($value));
        $value = str_replace([' ', '-', '.'], '_', $value);

        return trim(preg_replace('/_+/', '_', $value) ?: '', '_');
    }

    private function validateHeaders(array $headers): void
    {
        $requiredAny = [
            'documento' => ['DOCUMENTO', 'NRO_DOCUMENTO', 'NUMERO_DOCUMENTO'],
            'voucher' => ['VOUCHER', 'NRO_OPERACION', 'NUMERO_OPERACION'],
            'codigo' => ['COD_PAGO', 'CODIGO_PAGO', 'CONCEPTO_PAGO'],
        ];

        foreach ($requiredAny as $label => $candidates) {
            if (count(array_intersect($candidates, $headers)) === 0) {
                throw new RuntimeException("Encabezado requerido no encontrado: {$label}.");
            }
        }
    }
}
