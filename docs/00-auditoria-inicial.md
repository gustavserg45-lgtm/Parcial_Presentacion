# Auditoría inicial del repositorio

Fecha de revisión: 2026-11-19 (America/Bogota).

## Resultado verificable

Se leyó completamente `AGENTS.md` y `README.md`. El repositorio clonado desde GitHub contiene únicamente esos dos archivos; no existen todavía `docs/`, `prompts/` ni `referencias/` en ninguna revisión local (`main`, `origin/main` ni el commit inicial).

Por lo tanto, el prompt maestro, los requisitos del proyecto, la plantilla APA, el protocolo de evidencias y el flujo Codex/PowerShell referenciados por `AGENTS.md` no pudieron leerse porque no fueron publicados en este checkout. No se inventan sus contenidos ni se marca ninguna validación académica como completada.

La comprobación local de acceso a Fedora tampoco encontró un canal directo: no hay configuración SSH ni `VBoxManage` disponible para controlar la VM desde este entorno. Fedora debe validarse mediante el comando que ejecute el usuario en la VM.

El primer resultado manual de la VM confirma que Fedora 44 está operativo, pero Docker aún no está instalado y el script se lanzó desde `/root`, no desde el checkout del proyecto. Por eso todavía no existe evidencia E-01 del script oficial.

## Decisión provisional

Se inicia únicamente el esqueleto reproducible de infraestructura pedido por el usuario: Compose con redes privadas, dos bases MariaDB aisladas, portal Laravel y MoodleHQ. La personalización académica de Moodle, las 20 secciones del informe y las evidencias finales quedan pendientes de los documentos fuente.

## Fuentes técnicas consultadas

- Laravel 13 requiere PHP >= 8.3.
- Moodle 5.2 requiere PHP 8.3/8.4 y MariaDB >= 10.11.
- La imagen `moodlehq/moodle-php-apache` publica tags para PHP 8.3 y documenta extensiones Moodle.
- Se fijan temporalmente PHP 8.3 para Moodle, PHP 8.4 para Laravel y MariaDB 11.8.9; la compatibilidad debe confirmarse con `docker compose config` y pruebas reales en Fedora, no en este entorno Windows.

