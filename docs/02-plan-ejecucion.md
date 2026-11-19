# Plan de implementación por fases y orden de trabajo

**Restricción del usuario:** concluir lo antes posible, meta personal antes del 19/11/2026 14:00 (hora Colombia). El curso muestra cierre 19/11/2026 23:59, pero seguir la meta personal. No inventar avances ni dar garantía de cumplir hora exacta.

| Orden | Fase | Entregable comprobable | Evidencia |
|---:|---|---|---|
| 0 | Diagnóstico | Fedora, RAM, disco, red, Docker/Compose y permisos identificados | E01 cuando haya resultados |
| 1 | Red/servicios | VM accesible por LAN, Docker operativo | E02 |
| 2 | Aplicaciones | Moodle + Laravel y BD con Compose, Dockerfile, health checks | E03 |
| 3 | Funcionalidad | Moodle (curso/roles), Laravel (registrar/consultar novedades) | E04/E05 |
| 4 | Persistencia | Recreación sin pérdida de datos | E06 |
| 5 | Seguridad/backup | Firewall, DB interna, respaldo y restauración probados | E07/E08 |
| 6 | Entrega | Documento APA + PDF, OVA, guía, demo | E09/E10 |

## Prioridades
**P0 críticas:** Moodle y Laravel simultáneos; Laravel+DB+Docker; Moodle+DB; volumen persistente; prueba real. **P1 importantes:** curso completo, LAN, backups/restauración, seguridad. **P2 entregables:** PDF, matriz comparativa, OVA y sustentación. Asegurar documentación y registro IA durante todas las fases.

## Regla de ejecución
No empezar una fase suponiendo éxito de la anterior. Ante error: registrar comando y salida, leer logs, ajustar y repetir. Mantener `docs/09-estado.md` actualizado. Tomar capturas sólo si `docs/04-evidencias.md` lo señala. No sustituir una prueba con captura ficticia o salida predeterminada.

## Reparto de trabajo
- **Codex:** modificar código/archivos, scripts bash, Compose, Dockerfile, Moodle automatizable, generar contenido didáctico, README, matriz, documento técnico; tests automatizados.
- **Usuario:** ejecutar cuando Codex no tenga acceso a Fedora, proporcionar resultados y screenshots, validar acceso desde otro dispositivo, generar OVA en host VirtualBox, enviar evidencias reales al repositorio de forma voluntaria.
- **PowerShell/SSH:** consola/puente para ejecutar comandos en Fedora; no duplicar la instalación en Windows.
