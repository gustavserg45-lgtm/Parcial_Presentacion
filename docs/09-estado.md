# Estado del proyecto

Fecha: 2026-11-19 (America/Bogota)

## Resumen

Fase actual: **EN PROGRESO — Fase 0 auditoría + Fase 1 esqueleto de infraestructura**.

| Área | Estado | Evidencia |
| --- | --- | --- |
| Repo y reglas | VALIDADO localmente | `AGENTS.md`, `README.md`, `git ls-tree` |
| Prompt maestro y requisitos | PENDIENTE | Los archivos referenciados no existen en el checkout |
| Preflight Fedora | PENDIENTE | Debe ejecutarse en la VM real |
| Compose y redes privadas | EN PROGRESO | `compose.yaml` creado; no ejecutado todavía |
| Laravel portal | EN PROGRESO | Esqueleto y Dockerfile creados; no construido ni probado |
| Moodle | EN PROGRESO | Bootstrap/config creados; descarga e instalación pendientes |
| Curso y roles Moodle | PENDIENTE | Requiere instalación y requisitos académicos fuente |
| Pruebas de persistencia/backups | PENDIENTE | Requiere Fedora y servicios funcionando |
| Informe APA/OVA | BLOQUEADO | Faltan plantilla y requisitos originales; OVA requiere acceso al host VirtualBox |

## Regla de actualización

Ninguna fila pasa a VALIDADO sin comando, resultado real, fecha y evidencia asociada. La revisión local de archivos no equivale a prueba Fedora.

