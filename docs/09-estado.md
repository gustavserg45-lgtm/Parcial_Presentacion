# Estado real del proyecto

Fecha de la sesión: 2026-11-19 UTC. Checkout Fedora: `/root/Parcial_Presentacion`, rama `main`. El árbol estaba limpio en `4fa417a` y se actualizó por avance rápido a `65ab263`.

| Entregable | Estado | Resultado observado |
|---|---|---|
| Fedora y recursos | VALIDADO | Fedora 44, kernel 6.19.10-300.fc44.x86_64, 2 CPU, 1.9 GiB de RAM y 16 GiB libres al inicio del despliegue. Evidencia E01. |
| Docker y Compose | VALIDADO | Cliente y daemon 29.10.0, Compose v5.8.0, overlayfs y cgroup v2. Evidencia E01. |
| Configuración Compose | VALIDADO | `docker compose --env-file .env -f infra/compose.yaml config --quiet` correcto. Sólo el portal y Moodle declaran puertos publicados. |
| Portal Laravel y bases | VALIDADO | Laravel 13.43.0 responde internamente, migró `news` y portal-db está saludable con MariaDB 11.8.9. |
| Moodle | VALIDADO | Moodle 5.2.5+ instalado, responde internamente con redirección HTTP 303 y moodle-db está saludable. Cron activo. |
| Curso y roles Moodle | PENDIENTE | Requiere configurar el curso y probar los permisos. |
| Persistencia | VALIDADO | `bash scripts/verify-persistence.sh` recreó portal, Moodle y ambas bases sin eliminar volúmenes. La novedad, el sitio y el archivo de `moodledata` se conservaron. Log `artifacts/evidence/20261119T212151Z-persistencia.log`. |
| Seguridad | EN PROGRESO | Firewalld activo y SELinux deshabilitado según el preflight. `.env` local con permisos 600. La verificación confirmó que MariaDB no publica puertos. |
| Acceso LAN | PENDIENTE | Preflight vio 10.0.2.15 y 192.168.56.103. Falta comprobar desde un segundo dispositivo. |
| Backup y restauración | PENDIENTE | Falta respaldo y prueba en un destino aislado. |
| Informe APA, PDF, OVA | PENDIENTE | Requieren evidencias finales y acceso al host de VirtualBox para la exportación. |

## Bitácora UTC

| Hora | Resultado |
|---|---|
| 20:56:32 | El clon atrasado no tenía `scripts/run-fedora.sh`. Salida 127 en `artifacts/runtime/20261119T205632Z-inicio.log`. |
| 20:58:14 | Preflight correcto. El generador de `.env` se detuvo por falta del comando `openssl`. Se usó el generador aleatorio del kernel y Coreutils. |
| 20:58:47 y 21:00:01 | Se reprodujo el error `Luquitas: command not found`. Se citaron las dos variables de nombre Moodle en el generador, la plantilla y el entorno local sin rotar secretos. |
| 21:00:42 | El ZIP se descargó, pero el script buscó `version.php` en la raíz. El listado oficial descargado confirmó `public/version.php` y `admin/cli/install_database.php` en la raíz del código. |
| 21:02:30 | Moodle se descargó y las imágenes de Moodle y MariaDB se obtuvieron en Fedora. Build de Laravel en curso. |
| 21:17:48 | La instalación de Moodle terminó. El portal falló inicialmente por ausencia de `portal/artisan`; se añadió el lanzador estándar, se reconstruyó la imagen y las migraciones terminaron correctamente. |
| 21:21:04 | Verificación técnica PASS. Laravel 13.43.0, Moodle 5.2.5+, MariaDB 11.8.9 y aislamiento de DB confirmados. Los puertos publicados no fueron accesibles desde el propio entorno de ejecución, aunque los servicios respondieron dentro de sus contenedores. |
| 21:21:51 | Persistencia PASS tras recreación de contenedores sin `-v`. |

Los logs de ejecución se guardan en `artifacts/runtime/` y las evidencias de prueba en `artifacts/evidence/`, con sello UTC. El preflight completo de las 21:02:30 UTC quedó copiado como `20261119T210230Z-E01-fedora.log`.
