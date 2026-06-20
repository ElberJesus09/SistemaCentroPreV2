@include('errors.partials.page', [
    'code' => '403',
    'title' => 'No tienes permiso para entrar',
    'message' => 'Tu usuario no tiene los permisos necesarios para ver esta seccion o realizar esta accion.',
    'hint' => 'Si crees que deberias tener acceso, pide a un administrador que revise tu rol o permisos temporales.',
])
