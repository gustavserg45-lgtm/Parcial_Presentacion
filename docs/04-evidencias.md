# Evidencias requeridas

No se generaron capturas en esta fase. Solo se debe capturar cuando el resultado real esté disponible en Fedora.

| ID | Momento | Evidencia | Captura |
| --- | --- | --- | --- |
| E-01 | Preflight | Fedora, Docker/Compose, RAM, disco, IP, SELinux, firewalld y puertos 8083/8084 | Sí |
| E-02 | Primer arranque | `docker compose ps`, logs sin secretos y respuestas HTTP del portal/Moodle | Sí |
| E-03 | Moodle | Sitio, curso, tres unidades, recursos, actividad, foro y roles ficticios | Sí |
| E-04 | Persistencia | Reinicio/recreación sin borrar volúmenes y datos aún presentes | Sí |
| E-05 | Backup/restore | Comandos, archivos resultantes y restauración comprobada | Sí |
| E-06 | Seguridad | Puertos publicados y comprobación de que las bases no son accesibles desde LAN | Sí |

Los logs completos se conservarán en `artifacts/` sin contraseñas. Antes de entregar se revisará que ninguna captura o salida incluya secretos.

