<?php

namespace App\Http\Controllers;

use App\Models\News;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class NewsController
{
    public function index(): View
    {
        return view('news.index', [
            'news' => News::query()->latest('published_at')->latest('id')->paginate(10),
        ]);
    }

    public function show(News $news): View
    {
        return view('news.show', compact('news'));
    }

    public function store(Request $request): RedirectResponse
    {
        $data = $request->validate([
            'title' => ['required', 'string', 'max:160'],
            'summary' => ['required', 'string', 'max:300'],
            'body' => ['required', 'string'],
            'published_at' => ['nullable', 'date'],
        ]);

        News::create($data);

        return to_route('news.index')->with('status', 'Noticia registrada.');
    }
}

