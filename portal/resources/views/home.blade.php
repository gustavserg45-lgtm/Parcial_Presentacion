@extends('layouts.app')

@section('content')
<section class="hero">
    <p class="eyebrow">Institución educativa ficticia</p>
    <h1>Aprender, compartir y construir comunidad.</h1>
    <p>Portal institucional de San Luquitas Digital, integrado con un aula Moodle para las experiencias de aprendizaje.</p>
    <div class="actions">
        <a class="button" href="{{ route('news.index') }}">Ver noticias</a>
        <a class="button secondary" href="{{ rtrim((string) env('MOODLE_WWWROOT', 'http://localhost:8084'), '/') }}" target="_blank" rel="noreferrer">Ingresar al aula</a>
    </div>
</section>
<section class="cards" aria-label="Información institucional">
    <article><h2>Quiénes somos</h2><p>Una comunidad educativa ficticia que usa tecnología abierta para acompañar trayectorias de aprendizaje.</p></article>
    <article><h2>Recursos</h2><p>Materiales, actividades y espacios de intercambio publicados desde el aula virtual.</p></article>
    <article><h2>Contacto</h2><p>La información de contacto se definirá con los datos institucionales aprobados para la entrega académica.</p></article>
</section>
@endsection

