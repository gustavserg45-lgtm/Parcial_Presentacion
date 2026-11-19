<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__ . '/../routes/web.php',
        commands: __DIR__ . '/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->alias([
            'news.admin' => App\Http\Middleware\NewsAdminToken::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        // Los errores se registran mediante la configuración estándar de Laravel.
    })
    ->create();

