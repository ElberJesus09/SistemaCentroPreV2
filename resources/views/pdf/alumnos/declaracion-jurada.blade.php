<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <title>Declaración jurada</title>
    <style>
        @page { margin: 24px; }
        body { font-family: DejaVu Sans, sans-serif; font-size: 10px; color: #111827; margin: 0; }
        .header { width: 100%; border-bottom: 2px solid #0f5f8f; margin-bottom: 12px; padding-bottom: 8px; }
        .header td { vertical-align: middle; }
        .brand-icon { width: 34px; height: 34px; }
        h1 { margin: 0; text-align: center; font-size: 16px; color: #0f5f8f; line-height: 1.25; }
        .box { border: 1px solid #8ab4c8; padding: 12px 14px; background: #f6fbfd; }
        .declaration-title { margin-bottom: 8px; font-weight: bold; font-size: 13px; text-align: center; color: #164e63; }
        .summary { width: 100%; border-collapse: collapse; margin-bottom: 10px; }
        .summary td { border: 1px solid #cbd5e1; padding: 4px 6px; }
        .summary .label { width: 28%; background: #edf7fb; font-weight: bold; color: #164e63; }
        .declaration-list { margin: 6px 0 0 18px; padding: 0; font-size: 10.2px; line-height: 1.52; }
        .declaration-list li { margin-bottom: 7px; padding-left: 4px; text-align: justify; }
        .declaration-columns { width: 100%; border-collapse: collapse; }
        .declaration-columns td { width: 50%; vertical-align: top; padding-right: 12px; }
        .declaration-columns td + td { padding-right: 0; padding-left: 12px; }
        .signatures { width: 100%; margin-top: 34px; }
        .signatures td { width: 50%; text-align: center; }
        .line { border-top: 1px solid #111; width: 130px; margin: 34px auto 0 auto; padding-top: 4px; font-size: 9px; }
    </style>
</head>
<body>
    @php
        $apoderado = $alumno->apoderados->first();
        $matricula = $alumno->matriculas->sortByDesc('id')->first();
        $inscripcion = $alumno->inscripciones->sortByDesc('id')->first();
        $oferta = $matricula?->ofertaAcademica ?? $inscripcion?->ofertaAcademica;
        $cycleName = $oferta?->cicloAcademico?->nombre ?: 'CICLO ACADEMICO';
        $institutionName = 'Centro Preuniversitario Juan Francisco Aguinaga Castro';
    @endphp

    <table class="header">
        <tr>
            <td style="width:44px;">
                <img class="brand-icon" src="{{ public_path('favicon.png') }}" alt="Icono institucional">
            </td>
            <td>
                <h1>DECLARACIÓN JURADA<br>{{ e($institutionName) }}</h1>
            </td>
        </tr>
    </table>

    <table class="summary">
        <tr><td class="label">Alumno</td><td>{{ e($alumno->nombreCompleto()) }}</td></tr>
        <tr><td class="label">Documento</td><td>{{ e($alumno->numero_documento) }}</td></tr>
        <tr><td class="label">Ciclo</td><td>{{ e($cycleName) }}</td></tr>
        <tr><td class="label">Matrícula</td><td>{{ e($matricula?->codigo ?? '-') }}</td></tr>
    </table>

    <div class="box">
        <div class="declaration-title">DECLARACIÓN JURADA</div>
        <table class="declaration-columns">
            <tr>
                <td>
                    <ol class="declaration-list">
                        <li>Acepto inscribirme al {{ e($cycleName) }} del Centro Pre Universitario - UNPRG.</li>
                        <li>Declaro que la informacion indicada en este documento es totalmente acreditable; de lo contrario me sujeto a las condiciones de registro establecidas por la Comision de Proceso de Admision del {{ $institutionName }} - UNPRG.</li>
                        <li>Declaro NO HABER INGRESADO a la UNPRG, a traves del CPU, en ciclos programados anteriormente.</li>
                        <li>La aplicacion y calificacion de los examenes y Reglamento es de mi conocimiento. Asimismo, la asignacion de vacantes y matricula de los ingresantes se rige por lo dispuesto en el Reglamento de Estudiantes del CPU.</li>
                        <li>Me comprometo a cumplir con lo dispuesto en el Reglamento de Estudiantes del CPU.</li>
                        <li>El pago es unico, por lo que me sujeto a la norma de INHABILIDAD para rendir el Primer Examen Parcial, por motivo de deuda.</li>
                    </ol>
                </td>
                <td>
                    <ol class="declaration-list" start="7">
                        <li>Declaro haber sido informado de los requisitos y documentacion obligatoria que debe presentarse para inscribir o matricular a un estudiante en el CPU.</li>
                        <li>Me comprometo a denunciar ante las autoridades pertinentes toda irregularidad cometida por personas inescrupulosas que trafican tomando el nombre de esta institucion.</li>
                        <li>Me comprometo a informar a las autoridades del CPU sobre cualquier discapacidad o accesorio que pudiera utilizar para desarrollar mis actividades normales.</li>
                        <li>Quedo informado de que para asistir a clases y evaluaciones no se permitira el ingreso con ropa inapropiada ni dispositivos no autorizados.</li>
                        <li>Para las evaluaciones solo debera portar su documento de identidad, carnet y utiles permitidos.</li>
                        <li>De acontecer perdida de objetos no autorizados, la institucion no se hace responsable.</li>
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
