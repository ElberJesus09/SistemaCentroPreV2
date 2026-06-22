<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\View\View;
use Throwable;

class SmtpTestController extends Controller
{
    public function create(): View
    {
        return view('tools.smtp-test', [
            'mailConfig' => [
                'mailer' => config('mail.default'),
                'host' => config('mail.mailers.smtp.host'),
                'port' => config('mail.mailers.smtp.port'),
                'from' => config('mail.from.address'),
                'name' => config('mail.from.name'),
            ],
        ]);
    }

    public function store(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'to' => ['required', 'email'],
            'subject' => ['required', 'string', 'max:150'],
            'message' => ['required', 'string', 'max:2000'],
        ]);

        try {
            Mail::raw($validated['message'], function ($mail) use ($validated): void {
                $mail->to($validated['to'])
                    ->subject($validated['subject']);
            });
        } catch (Throwable $e) {
            return back()
                ->withInput()
                ->with('smtp_error', $e->getMessage());
        }

        return back()->with('status', 'Correo de prueba enviado correctamente.');
    }
}
