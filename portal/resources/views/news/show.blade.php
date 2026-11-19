@extends('layouts.app')

@section('content')
<article class="news-detail">
    <p class="eyebrow">{{ optional($news->published_at)->format('d/m/Y') ?? 'Sin fecha' }}</p>
    <h1>{{ $news->title }}</h1>
    <p class="lead">{{ $news->summary }}</p>
    <div class="prose">{!! nl2br(e($news->body)) !!}</div>
    <a href="{{ route('news.index') }}">← Volver a noticias</a>
</article>
@endsection

