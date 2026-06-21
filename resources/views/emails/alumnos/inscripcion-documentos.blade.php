<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Documentos de inscripción</title>
</head>
<body style="margin:0;padding:0;background-color:#f4f4f5;font-family:Arial,sans-serif;">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color:#f4f4f5;padding:32px 12px;">
        <tr>
            <td align="center">
                <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="max-width:560px;background-color:#ffffff;border-radius:8px;border:1px solid #e4e4e7;overflow:hidden;">
                    <tr>
                        <td style="padding:28px;">
                            <p style="margin:0;font-size:11px;letter-spacing:0.08em;text-transform:uppercase;color:#2563eb;">{{ e(config('app.name')) }}</p>
                            <h1 style="margin:12px 0 0 0;font-size:20px;color:#18181b;">Documentos de inscripción</h1>
                            <p style="margin:16px 0 0 0;font-size:15px;line-height:1.6;color:#3f3f46;">
                                Estimado/a <strong>{{ e($alumno->nombreCompleto()) }}</strong>,<br>
                                adjuntamos su ficha de inscripción con declaración jurada y el reglamento académico en formato PDF.
                            </p>
                            <p style="margin:16px 0 0 0;font-size:13px;line-height:1.6;color:#71717a;">
                                Revise los datos y conserve estos documentos para los tramites del Centro Preuniversitario.
                            </p>
                        </td>
                    </tr>
                </table>
                <p style="margin:20px 0 0 0;font-size:11px;color:#a1a1aa;">Este correo fue enviado por el personal autorizado del Centro Pre.</p>
            </td>
        </tr>
    </table>
</body>
</html>
