<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ $title ?? 'San Luquitas Digital' }}</title>
    <link rel="stylesheet" href="{{ asset('app.css') }}">
</head>
<body>
<header class="site-header">
    <a class="brand" href="{{ route('home') }}">San Luquitas Digital</a>
    <nav aria-label="Navegación principal">
        <a href="{{ route('home') }}">Inicio</a>
        <a href="{{ route('news.index') }}">Noticias</a>
        <a href="{{ rtrim((string) env('MOODLE_WWWROOT', 'http://localhost:8084'), '/') }}" target="_blank" rel="noreferrer">Aula Moodle</a>
    </nav>
</header>
<main class="container">
    @if (session('status'))<p class="notice" role="status">{{ session('status') }}</p>@endif
    @if ($errors->any())
        <div class="notice error" role="alert"><ul>@foreach ($errors->all() as $error)<li>{{ $error }}</li>@endforeach</ul></div>
    @endif
    @yield('content')
</main>
</body>
</html>

