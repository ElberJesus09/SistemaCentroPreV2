@include('errors.partials.page', [
    'code' => '419',
    'title' => 'La sesion expiro',
    'message' => 'Por seguridad, la pagina dejo de ser valida despues de un tiempo sin actividad.',
    'hint' => 'Vuelve a iniciar sesion o recarga el formulario antes de enviarlo otra vez.',
])
