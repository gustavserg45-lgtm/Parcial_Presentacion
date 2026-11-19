@extends('layouts.app')

@section('content')
<div class="page-heading"><div><p class="eyebrow">Actualidad</p><h1>Noticias</h1></div></div>
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

