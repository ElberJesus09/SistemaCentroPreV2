<?php

namespace App\Http\Controllers\Institucional;

use App\Http\Controllers\Controller;
use App\Http\Requests\Institucional\ConfiguracionInstitucionalUpdateRequest;
use App\Services\Institucional\ConfiguracionInstitucionalService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class ConfiguracionInstitucionalController extends Controller
{
    public function __construct(private readonly ConfiguracionInstitucionalService $service)
    {
    }

    public function edit(): View
    {
        return view('institucional.configuracion.edit', [
            'configuracion' => $this->service->obtenerActual(),
        ]);
    }

    public function update(ConfiguracionInstitucionalUpdateRequest $request): RedirectResponse
    {
        $this->service->actualizar($this->service->obtenerActual(), $request->validated());

        return redirect()->route('institucional.configuracion.edit')->with('status', 'Configuracion institucional actualizada.');
    }
}
