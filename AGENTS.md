# Instrucciones persistentes para Codex — San Luquitas Digital

## Misión
Implementar el proyecto académico descrito en `docs/01-requisitos.md`, con énfasis en **infraestructura demostrable y reproducible**. No convertirlo en un proyecto de diseño visual ni hacer los 7 ejercicios del manual en lugar del proyecto final.

## Entorno real y límites
- El usuario tiene VirtualBox, una VM con **Fedora** (versión exacta aún no verificada), PowerShell conectado a la VM de algún modo (método SSH/compartición no confirmado), GitHub y Codex.
- NO asumir Docker, Compose, PHP, MariaDB, conectividad LAN o RAM ya instalados. Diagnosticar antes.
- No afirmar que se ejecutó una prueba en Fedora si Codex sólo revisó archivos localmente.
- No manipular el host VirtualBox ni simular la exportación OVA sin acceso real.
- No ejecutar comandos destructivos (`docker compose down -v`, `docker volume rm`, `prune --volumes`, borrado de bases, formateo) sin comprobar impacto y consentimiento.

## Estrategia
1. Inspeccionar estado de repo y confirmar SO/recursos mediante script seguro `scripts/preflight-fedora.sh` si se tiene ejecución en Fedora; de lo contrario dar al usuario **un solo bloque listo para pegar** por paso.
2. Documentar versión real de Fedora, Docker/Compose, recursos e IP privada. Si faltan paquetes, usar el método oficial de Fedora adecuado a la versión del SO; Fedora moderno usa DNF5.
3. Implementar **modo contenerizado**: Moodle, Laravel y bases de datos con Compose. El enunciado admite esta modalidad, y exige Docker para Laravel. Crear Dockerfile propio para Laravel, servidor HTTP adecuado, volúmenes de bases/moodledata y cron de Moodle. Comprobar imágenes, etiquetas, compatibilidad PHP/extensiones y DB desde fuentes oficiales ANTES de fijar versiones.
4. Preferencia: Laravel 13 si es compatible y sencillo; si hay impedimento, documentar versión compatible. Moodle 5.2 o versión oficialmente soportada y compatible (enunciado cita 5.2). Dos bases y usuarios separados; nunca usar root desde las apps.
5. Portal: inicio, información de institución ficticia, recursos, noticias CRUD mínimo registrar/consultar y link a Moodle. Evitar construir autenticación avanzada, e-commerce o APIs que no pide el profesor.
6. Moodle: sitio San Luquitas Digital, curso exacto, 3 unidades, >=3 recursos, un cuestionario o tarea, un foro, administrador, docente y >=3 estudiantes ficticios con roles probados.
7. Pruebas: acceso localhost y LAN, respuesta HTTP, coexistencia, operaciones DB, roles, reinicio, persistencia tras **recrear sin borrar volúmenes**, backup y restauración de Moodle/portal, seguridad de red/credenciales/puertos, logs. Registrar comando, resultado real, fecha y evidencia.
8. Documento técnico usando la plantilla APA suministrada (la portada original es UNAD: adaptar a UNAB y datos que el usuario confirme). **20 secciones** exactas, sin inventar resultados.
9. Exportación OVA desde VirtualBox del equipo anfitrión, validar importación si es viable y entregar instrucciones.

## Calidad y seguridad
- Fedora SELinux activo: usar volúmenes nombrados cuando convenga; para bind mounts sólo rutas del proyecto y etiquetas `:Z` o `:z` justificadas. NO deshabilitar SELinux ni firewalld indiscriminadamente.
- DB sin puertos publicados en interfaces externas salvo razón justificada; red interna Docker para DB; apps con puertos distintos disponibles (preferencia Laravel 8083 y Moodle 8084, verificar conflictos).
- Variables en `.env` no versionado; publicar `.env.example` sin secretos. Generar contraseñas locales de laboratorio y no imprimirlas en screenshots ni logs.
- Volúmenes persistentes; respaldos consistentes DB + archivos (`moodledata`, `config.php`, código/config Laravel y uploads si los hay), prueba de restauración real.
- No prometer acceso offline completo. Explicar que se puede servir desde LAN sin Internet **si las dependencias/imágenes ya están descargadas**, con limitaciones para recursos externos.
- Documentación clara para estudiante: comandos exactos, para qué sirven y resultado esperado.
- Capturas: únicamente cuando `docs/04-evidencias.md` lo indique. Evitar sobrecargar al usuario.
- Mantener `docs/09-estado.md` actualizado con PENDIENTE / EN PROGRESO / VALIDADO, nunca marcar VALIDADO sin prueba.

## Forma de colaboración
Para cada fase entregar: objetivo, archivos editados, comando(s) para ejecutar, resultado esperado, cómo diagnosticar error, punto de captura **sí/no**. No exigir copiar docenas de comandos manualmente; automatizar con scripts idempotentes que registren logs sin secretos. Usar commits pequeños y mensajes descriptivos; evitar cambios globales que afecten otros repositorios o la VM fuera de este proyecto.

## Prioridad ante poco tiempo
A) Preflight y Docker; B) servicios Moodle/Laravel y DB; C) curso/CRUD; D) pruebas y backups; E) informe/OVA. Si algo falla, entregar estado honesto con evidencias de lo que sí funciona. Documentación y scripts deben crearse en paralelo, no al final.

## Integración Codex local/cloud
Leer también `docs/10-flujo-codex-powershell.md`. No suponer que Codex Cloud puede acceder a la VM de Windows; preferir Codex local si se desea ejecutar PowerShell automáticamente.
