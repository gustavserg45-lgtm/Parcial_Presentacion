<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        // Reservado para bindings propios del portal.
    }

    public function boot(): void
    {
        // Reservado para configuración no sensible del portal.
    }
}

