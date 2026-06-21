<?php

namespace App\Http\Controllers\IngresosAdmision\Pagos;

use App\Http\Controllers\Controller;
use App\Http\Requests\IngresosAdmision\Pagos\CodigoPagoExternoStoreRequest;
use App\Http\Requests\IngresosAdmision\Pagos\CodigoPagoExternoUpdateRequest;
use App\Models\CanalPago;
use App\Models\CodigoPagoExterno;
use App\Models\ConceptoPago;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class CodigoPagoExternoController extends Controller
{
    public function index(): View
    {
        $codigos = CodigoPagoExterno::query()
            ->with(['canalPago', 'conceptoPago'])
            ->latest()
            ->paginate(20);

        return view('ingresos-admision.pagos.codigos-externos.index', compact('codigos'));
    }

    public function create(): View
    {
        return view('ingresos-admision.pagos.codigos-externos.create', $this->formData());
    }

    public function store(CodigoPagoExternoStoreRequest $request): RedirectResponse
    {
        CodigoPagoExterno::query()->create($request->validated() + ['estado' => $request->boolean('estado')]);

        return redirect()->route('ingresos-admision.pagos.codigos-externos.index')
            ->with('status', 'Codigo externo registrado.');
    }

    public function edit(CodigoPagoExterno $codigoExterno): View
    {
        return view('ingresos-admision.pagos.codigos-externos.edit', $this->formData() + compact('codigoExterno'));
    }

    public function update(CodigoPagoExternoUpdateRequest $request, CodigoPagoExterno $codigoExterno): RedirectResponse
    {
        $codigoExterno->update($request->validated() + ['estado' => $request->boolean('estado')]);

        return redirect()->route('ingresos-admision.pagos.codigos-externos.index')
            ->with('status', 'Codigo externo actualizado.');
    }

    public function destroy(CodigoPagoExterno $codigoExterno): RedirectResponse
    {
        $codigoExterno->delete();

        return redirect()->route('ingresos-admision.pagos.codigos-externos.index')
            ->with('status', 'Codigo externo eliminado.');
    }

    private function formData(): array
    {
        return [
            'canales' => CanalPago::query()->orderBy('nombre')->get(),
            'conceptos' => ConceptoPago::query()->orderBy('nombre')->get(),
        ];
    }
}
