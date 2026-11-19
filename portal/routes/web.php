<?php

use App\Http\Controllers\NewsController;
use Illuminate\Support\Facades\Route;

Route::view('/', 'home')->name('home');
Route::get('/noticias', [NewsController::class, 'index'])->name('news.index');
Route::get('/noticias/{news}', [NewsController::class, 'show'])->name('news.show');
Route::post('/noticias', [NewsController::class, 'store'])
    ->middleware('news.admin')
    ->name('news.store');

