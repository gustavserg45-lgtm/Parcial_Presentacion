<?php

namespace Tests\Feature;

use App\Models\News;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class NewsTest extends TestCase
{
    use RefreshDatabase;

    public function test_public_can_read_news(): void
    {
        $news = News::create([
            'title' => 'Noticia de prueba',
            'summary' => 'Resumen',
            'body' => 'Contenido',
        ]);

        $this->get('/noticias')
            ->assertOk()
            ->assertSee($news->title);
    }

    public function test_admin_token_is_required_to_create_news(): void
    {
        $payload = [
            'title' => 'Nueva noticia',
            'summary' => 'Resumen',
            'body' => 'Contenido',
        ];

        $this->post('/noticias', $payload)->assertForbidden();

        $this->withHeader('X-Admin-Token', 'test-token')
            ->post('/noticias', $payload)
            ->assertForbidden();
    }
}

