<?php

namespace App\Http\Controllers\IngresosAdmision\Pagos;

use App\Http\Controllers\Controller;
use App\Http\Requests\IngresosAdmision\Pagos\ImportarPagosRequest;
use App\Enums\IngresosAdmision\Pagos\EstadoDetalleImportacionPago;
use App\Models\CanalPago;
use App\Models\ImportacionPago;
use App\Services\IngresosAdmision\Pagos\ImportacionPagoService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Carbon;
use Illuminate\Support\Str;
use Illuminate\View\View;
use Symfony\Component\HttpFoundation\StreamedResponse;

class ImportacionPagoController extends Controller
{
    public function index(): View
    {
        $importaciones = ImportacionPago::query()
            ->with(['canalPago', 'importador'])
            ->latest()
            ->paginate(20);

        return view('ingresos-admision.pagos.importaciones.index', compact('importaciones'));
    }

    public function create(): View
    {
        $canal = CanalPago::query()->where('codigo', 'BANCO_NACION')->firstOrFail();

        return view('ingresos-admision.pagos.importaciones.create', compact('canal'));
    }

    public function store(ImportarPagosRequest $request, ImportacionPagoService $service): RedirectResponse
    {
        $canal = CanalPago::query()->where('codigo', 'BANCO_NACION')->firstOrFail();
        $importacion = $service->import(
            $canal,
            Carbon::parse($request->date('fecha_referencia')),
            $request->file('archivo'),
            (int) $request->user()->id,
        );

        return redirect()
            ->route('ingresos-admision.pagos.importaciones.show', $importacion)
            ->with('status', 'Importacion procesada.');
    }

    public function preview(ImportarPagosRequest $request, ImportacionPagoService $service): View|RedirectResponse
    {
        $canal = CanalPago::query()->where('codigo', 'BANCO_NACION')->firstOrFail();
        $archivo = $request->file('archivo');
        $extension = strtolower($archivo->getClientOriginalExtension());
        $token = (string) Str::uuid();

        $metadata = [
            'nombre_archivo' => $archivo->getClientOriginalName(),
            'mime_type' => $archivo->getClientMimeType(),
            'tamano' => $archivo->getSize(),
            'extension' => $extension,
            'hash_archivo' => hash_file('sha256', $archivo->getRealPath()),
            'fecha_referencia' => Carbon::parse($request->date('fecha_referencia'))->toDateString(),
        ];

        try {
            $rows = $service->readRows(
                $canal,
                $archivo->getRealPath(),
                $extension,
            );
            $preview = $service->previewRows($canal, Carbon::parse($metadata['fecha_referencia']), $rows);
        } catch (\Throwable $e) {
            return back()
                ->withInput()
                ->withErrors(['archivo' => $e->getMessage()]);
        }

        session()->put("pagos_importacion_preview.{$token}", [
            'metadata' => $metadata,
            'rows' => $rows,
        ]);

        return view('ingresos-admision.pagos.importaciones.preview', compact('canal', 'metadata', 'preview', 'token'));
    }

    public function confirm(Request $request, ImportacionPagoService $service): RedirectResponse
    {
        $validated = $request->validate([
            'token' => ['required', 'string'],
        ]);

        $token = $validated['token'];
        $payload = session()->get("pagos_importacion_preview.{$token}");
        if (! is_array($payload) || ! is_array($payload['metadata'] ?? null) || ! is_array($payload['rows'] ?? null)) {
            return redirect()
                ->route('ingresos-admision.pagos.importaciones.create')
                ->withErrors(['archivo' => 'La previsualizacion ya no esta disponible. Vuelve a cargar el archivo.']);
        }

        $metadata = $payload['metadata'];
        $rows = $payload['rows'];
        $canal = CanalPago::query()->where('codigo', 'BANCO_NACION')->firstOrFail();
        $preview = $service->previewRows(
            $canal,
            Carbon::parse($metadata['fecha_referencia']),
            $rows,
        );

        if ($preview['observados'] > 0) {
            return back()->withErrors([
                'archivo' => 'Corrige las observaciones antes de confirmar la importacion.',
            ]);
        }

        $importacion = $service->importFromRows(
            $canal,
            Carbon::parse($metadata['fecha_referencia']),
            $metadata,
            $rows,
            (int) $request->user()->id,
        );

        session()->forget("pagos_importacion_preview.{$token}");

        return redirect()
            ->route('ingresos-admision.pagos.importaciones.show', $importacion)
            ->with('status', 'Importacion procesada.');
    }

    public function show(ImportacionPago $importacion): View
    {
        $importacion->load(['canalPago', 'importador']);
        $observaciones = $importacion->detalles()
            ->where('estado', EstadoDetalleImportacionPago::Observada)
            ->orderBy('numero_fila')
            ->limit(10)
            ->get(['id', 'numero_fila', 'tipo_documento', 'numero_documento', 'voucher', 'codigo_pago', 'mensaje']);
        $detalles = $importacion->detalles()
            ->with('pago.conceptoPago')
            ->orderBy('numero_fila')
            ->paginate(50);

        return view('ingresos-admision.pagos.importaciones.show', compact('importacion', 'detalles', 'observaciones'));
    }

    public function download(ImportacionPago $importacion): StreamedResponse
    {
        $this->authorize('download', $importacion);

        abort_if($importacion->disco === null || $importacion->ruta_archivo === null, 404);
        abort_unless(Storage::disk($importacion->disco)->exists($importacion->ruta_archivo), 404);

        return Storage::disk($importacion->disco)->download(
            $importacion->ruta_archivo,
            $importacion->nombre_archivo,
            ['X-Content-Type-Options' => 'nosniff'],
        );
    }
}
