# Estado del proyecto

Fecha: 2026-11-19 (America/Bogota)

## Resumen

Fase actual: **EN PROGRESO — Fase 0 auditoría + Fase 1 esqueleto de infraestructura**.

| Área | Estado | Evidencia |
| --- | --- | --- |
| Repo y reglas | VALIDADO localmente | `AGENTS.md`, `README.md`, `git ls-tree` |
| Prompt maestro y requisitos | PENDIENTE | Los archivos referenciados no existen en el checkout |
| Preflight Fedora | EN PROGRESO | Resultado manual recibido: Fedora 44, 1.9 GiB RAM, 18 GiB libres, Docker ausente; falta ejecutar el script desde el checkout |
| Compose y redes privadas | EN PROGRESO | `compose.yaml` creado; no ejecutado todavía |
| Laravel portal | EN PROGRESO | Esqueleto y Dockerfile creados; no construido ni probado |
| Moodle | EN PROGRESO | Bootstrap/config creados; descarga e instalación pendientes |
| Scripts de instalación/verificación | EN PROGRESO | `scripts/install-stack.sh` y `scripts/verify-stack.sh`; no ejecutados |
| Curso y roles Moodle | PENDIENTE | Requiere instalación y requisitos académicos fuente |
| Pruebas de persistencia/backups | PENDIENTE | Requiere Fedora y servicios funcionando |
| Informe APA/OVA | BLOQUEADO | Faltan plantilla y requisitos originales; OVA requiere acceso al host VirtualBox |

## Resultado Fedora recibido

El usuario ejecutó comandos desde `root@servidor-rural-acaceres163` el 2026-11-19. Se observó Fedora 44, IPs `10.0.2.15` y `192.168.56.103`, memoria total de aproximadamente 1.9 GiB, swap de 5.9 GiB y 18 GiB libres en `/`. `docker` no está instalado y `scripts/preflight-fedora.sh` no se encontró porque el comando se ejecutó desde `/root`, fuera del checkout del proyecto.

Este resultado es válido como diagnóstico inicial, no como validación del stack. La VM tiene disco suficiente para continuar, pero la memoria es ajustada para construir y ejecutar Moodle, Laravel y dos bases simultáneamente; se vigilarán errores OOM y se recomienda aumentar la RAM a 4 GiB si VirtualBox lo permite.

## Regla de actualización

Ninguna fila pasa a VALIDADO sin comando, resultado real, fecha y evidencia asociada. La revisión local de archivos no equivale a prueba Fedora.

