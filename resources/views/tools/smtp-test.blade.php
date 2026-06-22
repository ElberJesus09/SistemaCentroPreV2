@extends('layouts.app')

@section('title', 'Prueba SMTP')

@section('content')
    <div class="mx-auto max-w-3xl">
        <div class="mb-6">
            <h1 class="text-2xl font-black text-slate-950">Prueba SMTP</h1>
            <p class="mt-1 text-sm text-slate-500">Envio de correo usando la configuracion actual del servidor.</p>
        </div>

        @if (session('status'))
            <div class="mb-4 rounded-lg border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm font-bold text-emerald-700">
                {{ session('status') }}
            </div>
        @endif

        @if (session('smtp_error'))
            <div class="mb-4 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                {{ session('smtp_error') }}
            </div>
        @endif

        <div class="mb-4 grid gap-3 rounded-xl bg-white p-4 text-sm shadow-sm sm:grid-cols-2">
            <div><span class="font-black text-slate-500">Mailer:</span> {{ $mailConfig['mailer'] }}</div>
            <div><span class="font-black text-slate-500">SMTP:</span> {{ $mailConfig['host'] }}:{{ $mailConfig['port'] }}</div>
            <div><span class="font-black text-slate-500">From:</span> {{ $mailConfig['from'] }}</div>
            <div><span class="font-black text-slate-500">Nombre:</span> {{ $mailConfig['name'] }}</div>
        </div>

        <form method="POST" action="{{ route('smtp-test.store') }}" class="space-y-4 rounded-xl bg-white p-5 shadow-sm">
            @csrf

            <div>
                <label for="to" class="mb-1 block text-sm font-black text-slate-700">Correo destino</label>
                <input
                    id="to"
                    name="to"
                    type="email"
                    value="{{ old('to') }}"
                    required
                    class="w-full rounded-lg border border-slate-200 px-4 py-2.5 text-sm outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
                    placeholder="destino@correo.com"
                >
                @error('to') <p class="mt-1 text-xs font-bold text-red-600">{{ $message }}</p> @enderror
            </div>

            <div>
                <label for="subject" class="mb-1 block text-sm font-black text-slate-700">Asunto</label>
                <input
                    id="subject"
                    name="subject"
                    value="{{ old('subject', 'Prueba SMTP Centro Pre') }}"
                    required
                    class="w-full rounded-lg border border-slate-200 px-4 py-2.5 text-sm outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
                >
                @error('subject') <p class="mt-1 text-xs font-bold text-red-600">{{ $message }}</p> @enderror
            </div>

            <div>
                <label for="message" class="mb-1 block text-sm font-black text-slate-700">Mensaje</label>
                <textarea
                    id="message"
                    name="message"
                    rows="6"
                    required
                    class="w-full rounded-lg border border-slate-200 px-4 py-2.5 text-sm outline-none focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
                >{{ old('message', 'Correo de prueba enviado desde el VPS.') }}</textarea>
                @error('message') <p class="mt-1 text-xs font-bold text-red-600">{{ $message }}</p> @enderror
            </div>

            <button class="rounded-lg bg-blue-700 px-4 py-2.5 text-sm font-black text-white hover:bg-blue-800">
                Enviar prueba
            </button>
        </form>
    </div>
@endsection
