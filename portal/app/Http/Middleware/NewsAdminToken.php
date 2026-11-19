<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class NewsAdminToken
{
    public function handle(Request $request, Closure $next): Response
    {
        $expected = (string) config('services.news_admin_token');
        $provided = $request->header('X-Admin-Token') ?? $request->input('password');

        if ($expected === '' || ! is_string($provided) || ! hash_equals($expected, $provided)) {
            abort(403, 'Token de administración inválido.');
        }

        return $next($request);
    }
}

