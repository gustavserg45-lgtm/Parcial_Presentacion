<?php

return [
    'name' => env('APP_NAME', 'San Luquitas Digital'),
    'env' => env('APP_ENV', 'production'),
    'debug' => (bool) env('APP_DEBUG', false),
    'url' => env('APP_URL', 'http://localhost'),
    'timezone' => 'America/Bogota',
    'locale' => 'es',
    'fallback_locale' => 'es',
    'faker_locale' => 'es_ES',
    'key' => env('APP_KEY'),
    'cipher' => 'AES-256-CBC',
    'maintenance' => ['driver' => 'file'],
    'providers' => Illuminate\Support\ServiceProvider::defaultProviders()->merge([
        App\Providers\AppServiceProvider::class,
    ])->toArray(),
    'aliases' => [
        'App' => Illuminate\Support\Facades\App::class,
        'DB' => Illuminate\Support\Facades\DB::class,
        'Route' => Illuminate\Support\Facades\Route::class,
        'View' => Illuminate\Support\Facades\View::class,
    ],
];

