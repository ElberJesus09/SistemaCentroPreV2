<?php

namespace App\Http\Controllers\IngresosAdmision\Pagos;

use App\Http\Controllers\Controller;
use App\Http\Requests\IngresosAdmision\Pagos\ReprocesarDetallePagoRequest;
use App\Models\ImportacionPagoDetalle;
use App\Services\IngresosAdmision\Pagos\ReprocesamientoPagoService;
use Illuminate\Http\RedirectResponse;

class ReprocesamientoPagoController extends Controller
{
    public function store(
        ReprocesarDetallePagoRequest $request,
        ImportacionPagoDetalle $detalle,
        ReprocesamientoPagoService $service,
    ): RedirectResponse {
        $service->reprocess($detalle);

        return back()->with('status', 'Detalle reprocesado.');
    }
}
