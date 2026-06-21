<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Aviso del Centro Pre</title>
</head>
<body style="margin:0;padding:0;background-color:#f4f4f5;font-family:Arial,sans-serif;">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color:#f4f4f5;padding:32px 12px;">
        <tr>
            <td align="center">
                <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="max-width:560px;background-color:#ffffff;border-radius:8px;border:1px solid #e4e4e7;overflow:hidden;">
                    <tr>
                        <td style="padding:28px;">
                            <p style="margin:0;font-size:11px;letter-spacing:0.08em;text-transform:uppercase;color:#2563eb;">{{ e(config('app.name')) }}</p>
                            <h1 style="margin:12px 0 0 0;font-size:20px;color:#18181b;">Aviso para el alumno</h1>
                            <p style="margin:16px 0 0 0;font-size:15px;line-height:1.6;color:#3f3f46;">
                                Estimado/a <strong>{{ e($alumno->nombreCompleto()) }}</strong>,
                            </p>
                            <div style="margin:16px 0 0 0;padding:16px;border:1px solid #e4e4e7;border-radius:6px;background-color:#fafafa;font-size:15px;line-height:1.6;color:#3f3f46;white-space:pre-line;">{{ e($mensaje) }}</div>
                            <p style="margin:16px 0 0 0;font-size:13px;line-height:1.6;color:#71717a;">
                                Enviado por: {{ e($enviadoPor) }}.
                            </p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
