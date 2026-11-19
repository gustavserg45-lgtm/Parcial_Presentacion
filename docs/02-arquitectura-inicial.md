# Arquitectura inicial de infraestructura

## Topología

```text
LAN/Fedora host
  ├─ :8083 -> portal (Laravel 13 / PHP 8.4 / Apache) -> portal-db (MariaDB 11.8.9)
  └─ :8084 -> moodle (Moodle 5.2 / MoodleHQ PHP 8.3) -> moodle-db (MariaDB 11.8.9)
```

Las bases no publican puertos al host. Cada aplicación tiene una red privada propia y credenciales independientes. `moodledata`, `moodle-db-data` y `portal-db-data` son volúmenes persistentes de Compose.

## Decisiones y límites

- Se usa la imagen mantenida por MoodleHQ para el runtime PHP/Apache de Moodle, no una imagen comunitaria sin trazabilidad.
- Moodle 5.2 se sirve explícitamente desde `/var/www/html/public`; el `config.php` queda fuera del DocumentRoot conforme a la reestructuración de Moodle 5.1+.
- El código Laravel se construye desde `portal/Dockerfile`, tal como exige el enunciado operativo de `AGENTS.md`.
- Moodle se descarga desde la URL oficial durante el bootstrap y se conserva en `.runtime/moodle`, fuera del control de versiones.
- Los secretos se generan localmente con `scripts/init-env.sh`; nunca se imprimen ni se versionan.
- Los tags de imagen son una línea base de laboratorio, no una prueba de producción. En Fedora se deben registrar las versiones y digests efectivos.

