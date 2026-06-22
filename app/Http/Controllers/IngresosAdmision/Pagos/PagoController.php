<?php

namespace App\Http\Controllers\IngresosAdmision\Pagos;

use App\Http\Controllers\Controller;
use App\Models\Pago;
use Illuminate\Http\Request;
use Illuminate\View\View;

class PagoController extends Controller
{
    public function index(Request $request): View
    {
        $pagos = Pago::query()
            ->with(['canalPago', 'conceptoPago'])
            ->when($request->filled('buscar'), function ($query) use ($request): void {
                $buscar = trim((string) $request->query('buscar'));
                $query->where(function ($q) use ($buscar): void {
                    $q->where('numero_documento', 'like', "%{$buscar}%")
                        ->orWhere('voucher', 'like', "%{$buscar}%");
                });
            })
            ->latest('fecha_pago')
            ->latest('id')
            ->paginate(20)
            ->withQueryString();

        return view('ingresos-admision.pagos.index', compact('pagos'));
    }

    public function show(Pago $pago): View
    {
        $pago->load(['canalPago', 'conceptoPago']);

        return view('ingresos-admision.pagos.show', compact('pago'));
    }
}
