<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <title>Ficha de inscripción</title>
    <style>
        @page { margin: 18px; }
        body { font-family: DejaVu Sans, sans-serif; font-size: 9px; color: #111827; margin: 0; }
        .header { width: 100%; margin-bottom: 8px; }
        .header-table, .grid, table.meta { width: 100%; border-collapse: collapse; }
        .header-table td, .grid td { vertical-align: top; }
        .title { text-align: center; }
        .title h1 { margin: 0; font-size: 18px; color: #0f5f8f; }
        .title h2 { margin: 2px 0 0 0; font-size: 12px; color: #164e63; }
        .mini { font-size: 8px; color: #555; }
        .brand-icon { width: 34px; height: 34px; margin-bottom: 2px; }
        .brand-name { display: block; max-width: 145px; font-size: 8.8px; line-height: 1.2; font-weight: bold; color: #111827; }
        .dni-title { margin-bottom: 4px; font-size: 16px; font-weight: bold; color: #164e63; }
        .dni-label { margin-bottom: 3px; font-size: 8px; font-weight: bold; }
        .dni-boxes { border-collapse: collapse; margin-left: auto; }
        .dni-boxes td { width: 13px; height: 15px; border: 1px solid #164e63; text-align: center; vertical-align: middle; font-size: 9px; font-weight: bold; }
        .grid td { width: 50%; padding: 4px; }
        .section { border: 1px solid #8ab4c8; margin-bottom: 6px; }
        .section-title { background: #0f5f8f; color: white; padding: 4px 6px; font-weight: bold; font-size: 9px; }
        table.meta td { border: 1px solid #cbd5e1; padding: 3px 5px; vertical-align: top; }
        table.meta td.label { width: 36%; background: #edf7fb; font-weight: bold; color: #164e63; }
        .box { border: 1px solid #8ab4c8; padding: 12px 14px; margin-top: 6px; background: #f6fbfd; }
        .declaration-title { margin-bottom: 8px; font-weight: bold; font-size: 12px; text-align: center; color: #164e63; }
        .declaration-list { margin: 6px 0 0 18px; padding: 0; font-size: 10.2px; line-height: 1.52; }
        .declaration-list li { margin-bottom: 7px; padding-left: 4px; text-align: justify; }
        .declaration-columns { width: 100%; border-collapse: collapse; }
        .declaration-columns td { width: 50%; vertical-align: top; padding-right: 12px; }
        .declaration-columns td + td { padding-right: 0; padding-left: 12px; }
        .signatures { width: 100%; margin-top: 30px; }
        .signatures td { width: 50%; text-align: center; }
        .line { border-top: 1px solid #111; width: 130px; margin: 34px auto 0 auto; padding-top: 4px; font-size: 9px; }
    </style>
</head>
<body>
    @php
        $apoderado = $alumno->apoderados->first();
        $colegio = $alumno->colegios->first();
        $inscripcion = $alumno->inscripciones->sortByDesc('id')->first();
        $matricula = $alumno->matriculas->sortByDesc('id')->first();
        $oferta = $matricula?->ofertaAcademica ?? $inscripcion?->ofertaAcademica;
        $carrera = $matricula?->carrera ?? $inscripcion?->carrera;
        $cycleName = $oferta?->cicloAcademico?->nombre ?: 'CICLO ACADEMICO';
        $institutionName = 'Centro Preuniversitario Juan Francisco Aguinaga Castro';
        $documentDigits = str_split((string) $alumno->numero_documento);
        $pago = $matricula?->pagos?->first();
    @endphp

    <div class="header">
        <table class="header-table">
            <tr>
                <td width="27%">
                    <img class="brand-icon" src="{{ public_path('favicon.png') }}" alt="Icono institucional"><br>
                    <span class="brand-name">{{ $institutionName }}</span>
                    <span class="mini">Universidad Nacional Pedro Ruiz Gallo</span>
                </td>
                <td width="46%" class="title">
                    <h1>FICHA DE INSCRIPCIÓN</h1>
                    <h2>{{ e(mb_strtoupper($cycleName)) }}</h2>
                </td>
                <td width="27%" align="right">
                    <div class="dni-title">UNPRG</div>
                    <div class="dni-label">{{ e($alumno->tipoDocumento?->codigo ?? 'DOC') }}:</div>
                    <table class="dni-boxes">
                        <tr>
                            @foreach ($documentDigits as $digit)
                                <td>{{ e($digit) }}</td>
                            @endforeach
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <table class="grid">
        <tr>
            <td>
                <div class="section">
                    <div class="section-title">DATOS PERSONALES</div>
                    <table class="meta">
                        <tr><td class="label">Nombres</td><td>{{ e($alumno->nombreCompleto()) }}</td></tr>
                        <tr><td class="label">Documento</td><td>{{ e($alumno->numero_documento) }}</td></tr>
                        <tr><td class="label">Nacimiento</td><td>{{ $alumno->fecha_nacimiento?->format('d/m/Y') }}</td></tr>
                        <tr><td class="label">Sexo</td><td>{{ e(ucfirst((string) $alumno->genero)) }}</td></tr>
                        <tr><td class="label">Teléfono</td><td>{{ e($alumno->telefono) }}</td></tr>
                        <tr><td class="label">Correo</td><td>{{ e($alumno->correo) }}</td></tr>
                        <tr><td class="label">Dirección</td><td>{{ e(trim("{$alumno->departamento} / {$alumno->provincia} / {$alumno->distrito} - {$alumno->direccion}")) }}</td></tr>
                    </table>
                </div>

                <div class="section">
                    <div class="section-title">DATOS DEL APODERADO</div>
                    <table class="meta">
                        <tr><td class="label">Nombres</td><td>{{ $apoderado ? e(trim("{$apoderado->apellido_paterno} {$apoderado->apellido_materno} {$apoderado->nombres}")) : '-' }}</td></tr>
                        <tr><td class="label">Documento</td><td>{{ $apoderado ? e($apoderado->numero_documento) : '-' }}</td></tr>
                        <tr><td class="label">Teléfono</td><td>{{ $apoderado ? e($apoderado->telefono) : '-' }}</td></tr>
                        <tr><td class="label">Parentesco</td><td>{{ $apoderado ? e($apoderado->pivot?->parentesco ?? '-') : '-' }}</td></tr>
                    </table>
                </div>
            </td>
            <td>
                <div class="section">
                    <div class="section-title">COLEGIO DE PROCEDENCIA</div>
                    <table class="meta">
                        <tr><td class="label">Colegio</td><td>{{ $colegio ? e($colegio->nombre) : '-' }}</td></tr>
                        <tr><td class="label">Ubicación</td><td>{{ $colegio ? e(trim("{$colegio->departamento} / {$colegio->provincia} / {$colegio->distrito}")) : '-' }}</td></tr>
                        <tr><td class="label">Egreso</td><td>{{ $colegio?->pivot?->anio_egreso ?? '-' }}</td></tr>
                    </table>
                </div>

                <div class="section">
                    <div class="section-title">PROGRAMACION ACADEMICA</div>
                    <table class="meta">
                        <tr><td class="label">Carrera</td><td>{{ e($carrera?->nombre ?? '-') }}</td></tr>
                        <tr><td class="label">Sede</td><td>{{ e($oferta?->sede?->nombre ?? '-') }}</td></tr>
                        <tr><td class="label">Ciclo</td><td>{{ e($cycleName) }}</td></tr>
                        <tr><td class="label">Turno</td><td>{{ e($oferta?->turno?->nombre ?? '-') }}</td></tr>
                        <tr><td class="label">Matrícula</td><td>{{ $matricula?->fecha_matricula?->format('d/m/Y') ?? '-' }}</td></tr>
                    </table>
                </div>

                <div class="section">
                    <div class="section-title">DATOS DEL PAGO</div>
                    <table class="meta">
                        <tr><td class="label">Voucher</td><td>{{ e($pago?->voucher ?? '---') }}</td></tr>
                        <tr><td class="label">Agencia</td><td>{{ e($pago?->agencia ?? '---') }}</td></tr>
                        <tr><td class="label">Fecha pago</td><td>{{ $pago?->fecha_pago?->format('d/m/Y') ?? '---' }}</td></tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>

    <div class="box">
        <div class="declaration-title">DECLARACIÓN JURADA</div>

        <table class="declaration-columns">
            <tr>
                <td>
                    <ol class="declaration-list">
                        <li>Acepto inscribirme al {{ e($cycleName) }} del Centro Pre Universitario - UNPRG.</li>
                        <li>Declaro que la información indicada en este documento es totalmente acreditable, de lo contrario me sujeto a las condiciones de registro establecidas por la Comisión de Proceso de Admisión del {{ $institutionName }} - UNPRG.</li>
                        <li>Declaro NO HABER INGRESADO a la UNPRG, a través del CPU, en ciclos programados anteriormente.</li>
                        <li>La aplicación y calificación de los exámenes y Reglamento es de mi conocimiento. Asimismo, la asignación de vacantes y matrícula de los ingresantes se rige por lo dispuesto en el Reglamento de Estudiantes del CPU.</li>
                        <li>Me comprometo a cumplir con lo dispuesto en el Reglamento de Estudiantes del CPU.</li>
                        <li>El pago es unico, por lo que me sujeto a la norma de INHABILIDAD para rendir el Primer Examen Parcial, por motivo de deuda.</li>
                    </ol>
                </td>
                <td>
                    <ol class="declaration-list" start="7">
                        <li>Declaramos haber sido informados de los requisitos y documentación obligatoria que debe presentarse para inscribir/matricular a un estudiante en el CPU.</li>
                        <li>Me comprometo a DENUNCIAR ante las autoridades pertinentes toda irregularidad cometida por personas inescrupulosas que trafican tomando el nombre de esta Institución.</li>
                        <li>Me comprometo a informar a las autoridades del C.P.U. sobre cualquier discapacidad y/o accesorio que pudiera utilizar para desarrollar mis actividades normales.</li>
                        <li>Quedo por información que para asistir a clases y evaluaciones no se permitirá el ingreso con ropa inapropiada ni dispositivos móviles no autorizados.</li>
                        <li>Para las evaluaciones, solo deberá portar su documento de identidad, carnet y útiles. No llevar carteras, billeteras, lentes, cuadernos, libros, etc.</li>
                        <li>De acontecer pérdida de objetos no autorizados, no nos hacemos responsables.</li>
                    </ol>
                </td>
            </tr>
        </table>
    </div>

    <table class="signatures">
        <tr>
            <td><div class="line">Firma de alumno<br>Doc: {{ e($alumno->numero_documento) }}</div></td>
            <td><div class="line">Firma apoderado<br>Doc: {{ $apoderado ? e($apoderado->numero_documento) : '-' }}</div></td>
        </tr>
    </table>
</body>
</html>
