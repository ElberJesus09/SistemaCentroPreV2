<?php

namespace Database\Seeders;

use App\Models\Alumno;
use App\Models\Apoderado;
use App\Models\Carrera;
use App\Models\CicloAcademico;
use App\Models\Colegio;
use App\Models\ConceptoPago;
use App\Models\Inscripcion;
use App\Models\Matricula;
use App\Models\OfertaAcademica;
use App\Models\Pago;
use App\Models\Sede;
use App\Models\TipoDocumento;
use App\Models\Turno;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use RuntimeException;

class Backup21Seeder extends Seeder
{
    private int $nextAlumnoCodigo = 1;

    public function run(): void
    {
        $path = database_path('seeders/data/backup21.sql');
        if (! is_file($path)) {
            $path = base_path('../Documentacion/backup21.sql');
        }

        if (! is_file($path)) {
            throw new RuntimeException("No existe el backup: {$path}");
        }

        $userId = User::query()->min('id');
        if ($userId === null) {
            throw new RuntimeException('Primero debe existir un usuario para registrar la importacion.');
        }

        $sql = file_get_contents($path);
        if ($sql === false) {
            throw new RuntimeException("No se pudo leer el backup: {$path}");
        }

        $data = $this->loadBackupData($sql);
        $this->nextAlumnoCodigo = ((int) Alumno::query()->max('codigo')) + 1;

        DB::transaction(function () use ($data, $path, $userId): void {
            $tipoDni = TipoDocumento::query()->where('codigo', 'DNI')->firstOrFail();
            $conceptoMatricula = ConceptoPago::query()->where('codigo', 'MATRICULA')->firstOrFail();
            $conceptoPension = ConceptoPago::query()->where('codigo', 'PENSION')->firstOrFail();

            $cycles = $this->importCycles($data['academic_cycles']);
            $sedes = $this->importSedes($data['campuses']);
            $turnos = $this->importTurnos($data['shifts']);
            $carreras = $this->resolveCarreras($data['careers']);
            $ofertas = $this->importOfertas($data['academic_cycle_shifts'], $cycles, $sedes, $turnos);
            $schools = collect($data['schools'])->keyBy('id');
            $guardians = collect($data['guardians'])->keyBy('id');

            foreach ($data['students'] as $student) {
                $dni = trim((string) $student['dni']);
                $alumno = Alumno::query()->firstOrNew([
                    'tipo_documento_id' => $tipoDni->id,
                    'numero_documento' => $dni,
                ]);

                if (! $alumno->exists) {
                    $alumno->codigo = str_pad((string) $this->nextAlumnoCodigo++, 6, '0', STR_PAD_LEFT);
                }

                $ubicacionAlumno = $this->studentAddress((string) $student['address']);

                $alumno->fill([
                    'nombres' => $this->text($student['first_name']),
                    'apellido_paterno' => $this->text($student['last_name']),
                    'apellido_materno' => $this->nullableText($student['mother_last_name']),
                    'fecha_nacimiento' => $student['birth_date'],
                    'genero' => $student['gender'] === 'female' ? 'FEMENINO' : 'MASCULINO',
                    'telefono' => $this->nullableText($student['phone'], false),
                    'correo' => $this->nullableText($student['email'], false),
                    'departamento' => $ubicacionAlumno['departamento'],
                    'provincia' => $ubicacionAlumno['provincia'],
                    'distrito' => $ubicacionAlumno['distrito'],
                    'direccion' => $ubicacionAlumno['direccion'],
                    'estado' => $student['status'] === 'active' ? 'activo' : 'inactivo',
                    'registrado_por' => $userId,
                    'created_at' => $student['created_at'],
                    'updated_at' => now(),
                ])->save();

                $school = $schools->get((int) $student['school_id']);
                $colegio = $this->resolveColegio($school);
                if ($colegio !== null && $school !== null) {
                    $alumno->colegios()->syncWithoutDetaching([
                        $colegio->id => [
                            'anio_egreso' => (int) $school['graduation_year'],
                            'es_principal' => true,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ],
                    ]);
                }

                $guardian = $student['guardian_id'] ? $guardians->get((int) $student['guardian_id']) : null;
                if ($guardian !== null) {
                    $apoderado = $this->resolveApoderado($guardian, $tipoDni->id);
                    $alumno->apoderados()->syncWithoutDetaching([
                        $apoderado->id => [
                            'parentesco' => $this->relationship((string) $guardian['relationship']),
                            'es_principal' => true,
                            'vive_con_alumno' => null,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ],
                    ]);
                }

                $cicloId = $cycles[(int) $student['academic_cycle_id']];
                $ofertaId = $ofertas[(int) $student['academic_cycle_shift_id']];
                $carreraId = $carreras[(int) $student['career_id']];
                $pagoMatricula = $this->findAvailablePayment($dni, (int) $conceptoMatricula->id);
                $pagoPension = $this->findAvailablePayment($dni, (int) $conceptoPension->id);
                $hasMatricula = $pagoMatricula !== null;
                $hasPension = $pagoPension !== null;

                $inscripcion = Inscripcion::query()
                    ->where('alumno_id', $alumno->id)
                    ->whereHas('ofertaAcademica', fn ($query) => $query->where('ciclo_academico_id', $cicloId))
                    ->first();

                if ($inscripcion === null) {
                    $inscripcion = Inscripcion::query()->create([
                        'codigo' => $this->code('INS'),
                        'alumno_id' => $alumno->id,
                        'oferta_academica_id' => $ofertaId,
                        'carrera_id' => $carreraId,
                        'colegio_id' => $colegio?->id,
                        'fecha_inscripcion' => $student['registration_date'],
                        'estado' => $hasMatricula && $hasPension ? 'aprobada' : 'pendiente_pagos',
                        'observacion' => 'Importado desde backup21.sql. Pagos asociados desde Excel si estaban disponibles.',
                        'registrado_por' => $userId,
                        'created_at' => $student['created_at'],
                        'updated_at' => now(),
                    ]);
                } else {
                    $inscripcion->update([
                        'oferta_academica_id' => $ofertaId,
                        'carrera_id' => $carreraId,
                        'colegio_id' => $colegio?->id,
                        'fecha_inscripcion' => $student['registration_date'],
                        'updated_at' => now(),
                    ]);
                }

                $matricula = Matricula::query()->firstOrCreate(
                    ['inscripcion_id' => $inscripcion->id],
                    [
                        'codigo' => $this->code('MAT'),
                        'alumno_id' => $alumno->id,
                        'oferta_academica_id' => $ofertaId,
                        'carrera_id' => $carreraId,
                        'fecha_matricula' => $student['registration_date'],
                        'estado' => $this->matriculaEstado($hasMatricula, $hasPension),
                        'estado_pagos' => $this->pagosEstado($hasMatricula, $hasPension),
                        'registrado_por' => $userId,
                        'activado_at' => null,
                        'created_at' => $student['created_at'],
                        'updated_at' => now(),
                    ],
                );

                $matricula->update([
                    'alumno_id' => $alumno->id,
                    'oferta_academica_id' => $ofertaId,
                    'carrera_id' => $carreraId,
                    'fecha_matricula' => $student['registration_date'],
                    'estado' => $this->matriculaEstado($hasMatricula, $hasPension),
                    'estado_pagos' => $this->pagosEstado($hasMatricula, $hasPension),
                    'activado_at' => $hasMatricula && $hasPension ? now() : null,
                    'updated_at' => now(),
                ]);

                foreach ([$pagoMatricula, $pagoPension] as $pago) {
                    if ($pago === null) {
                        continue;
                    }

                    $pago->update([
                        'inscripcion_id' => $inscripcion->id,
                        'matricula_id' => $matricula->id,
                        'asociado_at' => now(),
                        'asociado_por' => $userId,
                        'estado' => 'asociado',
                    ]);
                }
            }

            $this->refreshOfertas();
        });
    }

    /**
     * @return array<string, list<array<string, mixed>>>
     */
    private function loadBackupData(string $sql): array
    {
        $tables = ['academic_cycles', 'academic_cycle_shifts', 'campuses', 'careers', 'guardians', 'schools', 'shifts', 'students'];

        $data = [];
        foreach ($tables as $table) {
            $data[$table] = $this->rowsFor($sql, $table, $this->columnsFor($sql, $table));
        }

        return $data;
    }

    /**
     * @return list<string>
     */
    private function columnsFor(string $sql, string $table): array
    {
        if (! preg_match('/CREATE TABLE `'.preg_quote($table, '/').'` \((.*?)\)\s+ENGINE=/s', $sql, $match)) {
            throw new RuntimeException("No se encontro la estructura de {$table}");
        }

        preg_match_all('/^\s+`([^`]+)`/m', $match[1], $matches);

        return $matches[1];
    }

    /**
     * @param  list<string>  $columns
     * @return list<array<string, mixed>>
     */
    private function rowsFor(string $sql, string $table, array $columns): array
    {
        if (! preg_match('/INSERT INTO `'.preg_quote($table, '/').'` VALUES\s+(.*?);\s*(?:\/\*!40000 ALTER TABLE|UNLOCK TABLES)/s', $sql, $match)) {
            return [];
        }

        return array_map(
            fn (string $tuple): array => array_combine($columns, $this->parseTuple($tuple)),
            $this->splitTuples($match[1]),
        );
    }

    /**
     * @return list<string>
     */
    private function splitTuples(string $values): array
    {
        $tuples = [];
        $depth = 0;
        $inQuote = false;
        $escaped = false;
        $start = null;

        for ($i = 0, $length = strlen($values); $i < $length; $i++) {
            $char = $values[$i];

            if ($inQuote) {
                if ($escaped) {
                    $escaped = false;
                } elseif ($char === '\\') {
                    $escaped = true;
                } elseif ($char === "'") {
                    $inQuote = false;
                }
                continue;
            }

            if ($char === "'") {
                $inQuote = true;
            } elseif ($char === '(') {
                $start ??= $i + 1;
                $depth++;
            } elseif ($char === ')') {
                $depth--;
                if ($depth === 0 && $start !== null) {
                    $tuples[] = substr($values, $start, $i - $start);
                    $start = null;
                }
            }
        }

        return $tuples;
    }

    /**
     * @return list<mixed>
     */
    private function parseTuple(string $tuple): array
    {
        $values = [];
        $buffer = '';
        $inQuote = false;
        $escaped = false;

        for ($i = 0, $length = strlen($tuple); $i < $length; $i++) {
            $char = $tuple[$i];

            if ($inQuote) {
                if ($escaped) {
                    $buffer .= match ($char) {
                        'n' => "\n",
                        'r' => "\r",
                        't' => "\t",
                        default => $char,
                    };
                    $escaped = false;
                } elseif ($char === '\\') {
                    $escaped = true;
                } elseif ($char === "'") {
                    $inQuote = false;
                } else {
                    $buffer .= $char;
                }
                continue;
            }

            if ($char === "'") {
                $inQuote = true;
            } elseif ($char === ',') {
                $values[] = $this->sqlValue($buffer);
                $buffer = '';
            } else {
                $buffer .= $char;
            }
        }

        $values[] = $this->sqlValue($buffer);

        return $values;
    }

    private function sqlValue(string $value): mixed
    {
        $value = trim($value);

        return strtoupper($value) === 'NULL' ? null : $value;
    }

    /**
     * @param  list<array<string, mixed>>  $rows
     * @return array<int, int>
     */
    private function importCycles(array $rows): array
    {
        $map = [];
        foreach ($rows as $row) {
            $cycle = CicloAcademico::query()->updateOrCreate(
                ['codigo' => $this->cycleCode((string) $row['name'])],
                [
                    'nombre' => $this->text($row['name']),
                    'fecha_inicio' => $row['start_date'],
                    'fecha_fin' => $row['end_date'],
                    'fecha_inicio_inscripcion' => $row['start_date'],
                    'fecha_fin_inscripcion' => $row['end_date'],
                    'estado' => (bool) $row['status'],
                ],
            );
            $map[(int) $row['id']] = $cycle->id;
        }

        return $map;
    }

    private function cycleCode(string $name): string
    {
        return preg_match('/(\d{4}-[A-Z]+)/i', $name, $match)
            ? Str::upper($match[1])
            : Str::upper(Str::slug($name));
    }

    /**
     * @param  list<array<string, mixed>>  $rows
     * @return array<int, int>
     */
    private function importSedes(array $rows): array
    {
        $map = [];
        foreach ($rows as $row) {
            $sede = Sede::query()->updateOrCreate(
                ['nombre' => $this->text($row['name'])],
                [
                    'tipo' => 'principal',
                    'direccion' => $this->nullableText($row['address']) ?? 'SIN DIRECCION',
                    'pais' => 'Peru',
                    'es_principal' => (int) $row['id'] === 1,
                    'permite_acceso_sistema' => true,
                    'estado' => (bool) $row['status'],
                ],
            );
            $map[(int) $row['id']] = $sede->id;
        }

        return $map;
    }

    /**
     * @param  list<array<string, mixed>>  $rows
     * @return array<int, int>
     */
    private function importTurnos(array $rows): array
    {
        $map = [];
        foreach ($rows as $row) {
            $turno = Turno::query()->updateOrCreate(
                ['nombre' => $this->text($row['name'])],
                [
                    'codigo' => $this->turnoCode((string) $row['name']),
                    'estado' => (bool) $row['status'],
                ],
            );
            $map[(int) $row['id']] = $turno->id;
        }

        return $map;
    }

    private function turnoCode(string $name): string
    {
        return match (Str::of($name)->ascii()->lower()->toString()) {
            'manana' => 'MANANA',
            'tarde' => 'TARDE',
            'noche' => 'NOCHE',
            default => Str::upper(Str::slug($name, '_')),
        };
    }

    /**
     * @param  list<array<string, mixed>>  $rows
     * @return array<int, int>
     */
    private function resolveCarreras(array $rows): array
    {
        $map = [];
        foreach ($rows as $row) {
            $career = Carrera::query()->where('codigo', $row['code'])->firstOrFail();
            $map[(int) $row['id']] = $career->id;
        }

        return $map;
    }

    /**
     * @param  list<array<string, mixed>>  $rows
     * @param  array<int, int>  $cycles
     * @param  array<int, int>  $sedes
     * @param  array<int, int>  $turnos
     * @return array<int, int>
     */
    private function importOfertas(array $rows, array $cycles, array $sedes, array $turnos): array
    {
        $map = [];
        foreach ($rows as $row) {
            $oferta = OfertaAcademica::query()->updateOrCreate(
                [
                    'ciclo_academico_id' => $cycles[(int) $row['academic_cycle_id']],
                    'sede_id' => $sedes[(int) $row['campus_id']],
                    'turno_id' => $turnos[(int) $row['shift_id']],
                ],
                [
                    'capacidad' => (int) $row['capacity'],
                    'estado' => (bool) $row['status'],
                ],
            );
            $map[(int) $row['id']] = $oferta->id;
        }

        return $map;
    }

    private function findAvailablePayment(string $dni, int $conceptoPagoId): ?Pago
    {
        return Pago::query()
            ->where('numero_documento', $dni)
            ->where('concepto_pago_id', $conceptoPagoId)
            ->whereIn('estado', ['disponible', 'asociado'])
            ->whereHas('importacionPagoDetalle.importacionPago', fn ($query) => $query->where('extension', 'xlsx'))
            ->orderBy('fecha_pago')
            ->orderBy('id')
            ->first();
    }

    /**
     * @param  array<string, mixed>|null  $school
     */
    private function resolveColegio(?array $school): ?Colegio
    {
        if ($school === null) {
            return null;
        }

        return Colegio::query()->firstOrCreate(
            [
                'codigo_modular' => null,
                'nombre' => $this->text($school['name']),
                'departamento' => $this->nullableText($school['department']),
                'provincia' => $this->nullableText($school['province']),
                'distrito' => $this->nullableText($school['district']),
            ],
            ['tipo_gestion' => null, 'estado' => true],
        );
    }

    /**
     * @param  array<string, mixed>  $guardian
     */
    private function resolveApoderado(array $guardian, int $tipoDocumentoId): Apoderado
    {
        return Apoderado::query()->updateOrCreate(
            ['tipo_documento_id' => $tipoDocumentoId, 'numero_documento' => $guardian['dni']],
            [
                'nombres' => $this->text($guardian['first_name']),
                'apellido_paterno' => $this->text($guardian['last_name']),
                'apellido_materno' => $this->nullableText($guardian['mother_last_name']),
                'telefono' => $guardian['phone'],
                'correo' => null,
                'direccion' => null,
                'estado' => 'activo',
            ],
        );
    }

    private function refreshOfertas(): void
    {
        foreach (OfertaAcademica::query()->pluck('id') as $id) {
            OfertaAcademica::query()
                ->whereKey($id)
                ->update(['matriculados' => Matricula::query()->where('oferta_academica_id', $id)->count()]);
        }
    }

    private function matriculaEstado(bool $hasMatricula, bool $hasPension): string
    {
        return match (true) {
            $hasMatricula && $hasPension => 'activa',
            $hasMatricula => 'pendiente_pago_pension',
            $hasPension => 'pendiente_pago_matricula',
            default => 'pendiente_pagos',
        };
    }

    private function pagosEstado(bool $hasMatricula, bool $hasPension): string
    {
        return match (true) {
            $hasMatricula && $hasPension => 'completo',
            $hasMatricula => 'pendiente_pension',
            $hasPension => 'pendiente_matricula',
            default => 'pendiente_ambos',
        };
    }

    private function relationship(string $value): string
    {
        return match ($value) {
            'father' => 'PADRE',
            'mother' => 'MADRE',
            default => 'APODERADO',
        };
    }

    /**
     * @return array{direccion:?string,distrito:?string,provincia:?string,departamento:?string}
     */
    private function studentAddress(string $address): array
    {
        $parts = array_values(array_filter(
            array_map(fn (string $part): string => trim($part), explode(',', $address)),
            fn (string $part): bool => $part !== '',
        ));

        if (count($parts) < 4) {
            return [
                'direccion' => $this->nullableText($address),
                'distrito' => null,
                'provincia' => null,
                'departamento' => null,
            ];
        }

        $departamento = array_pop($parts);
        $provincia = array_pop($parts);
        $distrito = array_pop($parts);

        return [
            'direccion' => $this->nullableText(implode(', ', $parts)),
            'distrito' => $this->nullableText($distrito),
            'provincia' => $this->nullableText($provincia),
            'departamento' => $this->nullableText($departamento),
        ];
    }

    private function code(string $prefix): string
    {
        return $prefix.'-'.now()->format('YmdHis').'-'.Str::upper(Str::random(6));
    }

    private function text(mixed $value): string
    {
        return Str::upper(trim(strip_tags((string) $value)));
    }

    private function nullableText(mixed $value, bool $upper = true): ?string
    {
        $value = trim(strip_tags((string) $value));
        if ($value === '') {
            return null;
        }

        return $upper ? Str::upper($value) : $value;
    }
}
