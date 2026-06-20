@include('errors.partials.page', [
    'code' => '500',
    'title' => 'Ocurrio un error inesperado',
    'message' => 'El sistema encontro un problema al procesar la solicitud.',
    'hint' => 'Intenta nuevamente. Si el problema continua, revisa el log o avisa al administrador tecnico.',
])
