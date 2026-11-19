<?php

use Illuminate\Support\Facades\Artisan;

Artisan::command('about-project', function (): void {
    $this->comment('San Luquitas Digital — portal institucional.');
})->purpose('Muestra información breve del proyecto');

