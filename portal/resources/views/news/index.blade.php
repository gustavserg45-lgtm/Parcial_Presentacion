@extends('layouts.app')

@section('content')
<div class="page-heading"><div><p class="eyebrow">Actualidad</p><h1>Noticias</h1></div></div>
<details>
    <summary>Registrar novedad</summary>
    <form method="post" action="{{ route('news.store') }}">
        @csrf
        <p><label>Título <input name="title" maxlength="160" required></label></p>
        <p><label>Resumen <textarea name="summary" maxlength="300" required></textarea></label></p>
        <p><label>Contenido <textarea name="body" required></textarea></label></p>
        <p><label>Fecha de publicación <input name="published_at" type="date"></label></p>
        <p><label>Token de administración <input name="password" type="password" autocomplete="off" required></label></p>
        <button type="submit">Registrar</button>
    </form>
</details>
@forelse ($news as $item)
    <article class="news-item">
        <p class="eyebrow">{{ optional($item->published_at)->format('d/m/Y') ?? 'Sin fecha' }}</p>
        <h2><a href="{{ route('news.show', $item) }}">{{ $item->title }}</a></h2>
        <p>{{ $item->summary }}</p>
    </article>
@empty
    <p class="empty">Todavía no hay noticias publicadas.</p>
@endforelse
{{ $news->links() }}
@endsection

