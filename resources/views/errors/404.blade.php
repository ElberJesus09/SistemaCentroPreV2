@include('errors.partials.page', [
    'code' => '404',
    'title' => 'Pagina no encontrada',
    'message' => 'La direccion que intentas abrir no existe, fue movida o ya no esta disponible.',
    'hint' => 'Revisa la URL o vuelve al panel para continuar trabajando.',
])
