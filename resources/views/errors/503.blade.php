@include('errors.partials.page', [
    'code' => '503',
    'title' => 'Servicio no disponible',
    'message' => 'El sistema esta temporalmente en mantenimiento o no puede responder en este momento.',
    'hint' => 'Espera unos minutos y vuelve a intentarlo.',
])
