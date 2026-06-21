@props([
    'name',
])

@php
    $icons = [
        'university' => [
            'viewBox' => '0 0 24 24',
            'paths' => [
                'M12 2 3 6.5v2h18v-2L12 2Zm-5 8v7H5v2h14v-2h-2v-7h-2v7h-3v-7h-2v7H9v-7H7Zm-3 11v2h16v-2H4Z',
            ],
        ],
        'instagram' => [
            'viewBox' => '0 0 24 24',
            'paths' => [
                'M7.8 2h8.4C19.4 2 22 4.6 22 7.8v8.4c0 3.2-2.6 5.8-5.8 5.8H7.8C4.6 22 2 19.4 2 16.2V7.8C2 4.6 4.6 2 7.8 2Zm-.2 2A3.6 3.6 0 0 0 4 7.6v8.8A3.6 3.6 0 0 0 7.6 20h8.8a3.6 3.6 0 0 0 3.6-3.6V7.6A3.6 3.6 0 0 0 16.4 4H7.6Zm9.65 1.5a1.25 1.25 0 1 1 0 2.5 1.25 1.25 0 0 1 0-2.5ZM12 7a5 5 0 1 1 0 10 5 5 0 0 1 0-10Zm0 2a3 3 0 1 0 0 6 3 3 0 0 0 0-6Z',
            ],
        ],
        'youtube' => [
            'viewBox' => '0 0 24 24',
            'paths' => [
                'M23.5 6.2a3 3 0 0 0-2.1-2.1C19.5 3.5 12 3.5 12 3.5s-7.5 0-9.4.6A3 3 0 0 0 .5 6.2 31 31 0 0 0 0 12a31 31 0 0 0 .5 5.8 3 3 0 0 0 2.1 2.1c1.9.6 9.4.6 9.4.6s7.5 0 9.4-.6a3 3 0 0 0 2.1-2.1A31 31 0 0 0 24 12a31 31 0 0 0-.5-5.8ZM9.6 15.5v-7l6.3 3.5-6.3 3.5Z',
            ],
        ],
        'facebook' => [
            'viewBox' => '0 0 24 24',
            'paths' => [
                'M24 12.1C24 5.4 18.6 0 12 0S0 5.4 0 12.1c0 6 4.4 11 10.1 11.9v-8.4h-3v-3.5h3V9.4c0-3 1.8-4.7 4.5-4.7 1.3 0 2.7.2 2.7.2v3h-1.5c-1.5 0-2 .9-2 1.9v2.3h3.4l-.5 3.5h-2.9V24c5.7-.9 10.2-5.9 10.2-11.9Z',
            ],
        ],
    ];

    $icon = $icons[$name] ?? $icons['university'];
@endphp

<svg
    {{ $attributes->merge(['class' => 'h-5 w-5']) }}
    xmlns="http://www.w3.org/2000/svg"
    viewBox="{{ $icon['viewBox'] }}"
    fill="currentColor"
    aria-hidden="true"
    focusable="false"
>
    @foreach ($icon['paths'] as $path)
        <path d="{{ $path }}" />
    @endforeach
</svg>
