# Registro transparente de uso de inteligencia artificial

| Fecha | Herramienta | Prompt / archivo | Resultado generado | Validación técnica real | Cambios manuales | Uso final |
|---|---|---|---|---|---|---|
| 2026-11-19 | ChatGPT | `prompts/00-PROMPT-MAESTRO-CODEX.md` y kit inicial | Plan, requisitos, instrucciones y scripts de diagnóstico | Revisión textual; despliegue en Fedora **aún pendiente** | Por completar | Planificación y documentación |

**Codex:** añadir registro por cada contribución sustancial: generación de Compose, Laravel, configuración Moodle, backups, prueba, diagramas o documento. No falsear ejecución. No guardar tokens o contraseñas ni datos reales de estudiantes.

## Trabas reales y mitigaciones

Estas incidencias forman parte de la bitácora técnica y se presentan como aprendizaje del proceso, no como resultados inventados:

| Traba observada | Causa comprobada | Mitigación aplicada | Prevención reproducible |
|---|---|---|---|
| El canal remoto tardó aproximadamente 90 minutos en quedar operativo | Se mezclaron comandos de PowerShell, Bash, autenticación SSH y registro del host remoto en Codex | Se separaron los entornos, se creó el alias `fedora-sanluquitas`, se instaló/autenticó Codex CLI en Fedora y se verificó la ejecución remota | Checklist de shells, alias SSH, prueba `CODEX_REMOTE_OK` y preflight antes de ejecutar el proyecto |
| Comandos con barras invertidas produjeron continuaciones inesperadas | PowerShell no usa `\\` como continuación de línea | Se ejecutaron comandos separados y se eliminaron las barras finales | Instrucciones con shell explícito y comandos de una línea cuando corresponda |
| La clave pública era aceptada pero la autenticación no terminaba | ACL, passphrase, agente SSH y firma de clave requerían verificaciones separadas | Se verificaron fingerprints, permisos, passphrase, `ssh-agent` y conexión interactiva | Clave accesible, agente configurado y prueba SSH antes de abrir el proyecto remoto |
| La aplicación mostraba Cloud Environment en lugar del host Fedora | Se estaba usando el flujo GitHub/GitLab, distinto de Remote SSH | Se distinguió Cloud Environment de Settings > Connections > SSH | Procedimiento de conexión documentado con alias concreto |

La duración aproximada de la primera traba se declara como tiempo observado durante la sesión y debe reemplazarse por un dato medido si se dispone de timestamps completos.
