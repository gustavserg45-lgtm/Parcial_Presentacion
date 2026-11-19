# Paquete consolidado de evidencias

Este documento es una plantilla para reunir únicamente evidencias reales del despliegue. El chat remoto debe tomar capturas solo después de que cada resultado haya sido comprobado y debe guardarlas en `artifacts/evidence/<YYYY-MM-DD>/`. No se deben crear imágenes simuladas ni capturas decorativas.

## Convención de archivos

Usar nombres cortos y ordenables:

```text
E01-01-preflight.png
E02-01-servicios-http.png
E03-01-moodle-curso.png
E04-01-persistencia.png
E05-01-backup-restore.png
E06-01-puertos-seguridad.png
E07-01-laravel-crud.png
E08-01-reinicio.png
E09-01-acceso-lan.png
E10-01-estado-final.png
```

No capturar contraseñas, tokens, `.env`, cookies, claves privadas ni salidas que expongan secretos.

## Formato visual solicitado

Las capturas de terminal deben conservar el estilo de una sesión real de PowerShell o Fedora, como en el ejemplo proporcionado por el usuario:

- incluir el prompt, el comando ejecutado y la salida relevante;
- mostrar suficiente contexto para identificar el host o la sesión;
- mantener texto nítido, completo y legible;
- evitar recortes que oculten el comando o el resultado;
- no incluir passphrases, contraseñas, tokens ni datos sensibles;
- tomar una sola captura por prueba cuando esa captura sea suficiente.

## E-01 — Preflight Fedora

**Resultado:** ________________________________________________

**Fecha/hora UTC:** ___________________________________________

**Evidencia mínima:** versión de Fedora, recursos, Docker, Compose y red.

**Captura:** `[PEGAR E01-01-preflight.png AQUÍ]`

## E-02 — Primer arranque

**Resultado:** ________________________________________________

**Servicios observados:** _____________________________________

**Evidencia mínima:** `docker compose ps` y respuestas HTTP comprobadas.

**Captura:** `[PEGAR E02-01-servicios-http.png AQUÍ]`

## E-03 — Moodle configurado

**Curso/unidades/recursos:** _________________________________

**Roles probados:** __________________________________________

**Evidencia mínima:** sitio, curso, actividad y roles; solo las pantallas necesarias.

**Captura:** `[PEGAR E03-01-moodle-curso.png AQUÍ]`

## E-04 — Persistencia

**Prueba realizada:** _________________________________________

**Resultado:** ________________________________________________

**Evidencia mínima:** estado antes y después de recrear contenedores sin borrar volúmenes.

**Captura:** `[PEGAR E04-01-persistencia.png AQUÍ]`

## E-05 — Backup y restauración

**Archivos generados:** _______________________________________

**Restauración comprobada:** _________________________________

**Evidencia mínima:** comandos, tamaños y resultado sin secretos.

**Captura:** `[PEGAR E05-01-backup-restore.png AQUÍ]`

## E-06 — Seguridad de red

**Puertos publicados:** ______________________________________

**Bases no expuestas:** ______________________________________

**Evidencia mínima:** puertos publicados y comprobación desde la red de laboratorio.

**Captura:** `[PEGAR E06-01-puertos-seguridad.png AQUÍ]`

## E-07 — Laravel y CRUD

**Rutas/operaciones comprobadas:** ____________________________

**Resultado:** ________________________________________________

**Captura:** `[PEGAR E07-01-laravel-crud.png AQUÍ]`

## E-08 — Reinicio y recuperación

**Prueba realizada:** _________________________________________

**Resultado:** ________________________________________________

**Captura:** `[PEGAR E08-01-reinicio.png AQUÍ]`

## E-09 — Acceso LAN

**URL/IP utilizada:** _________________________________________

**Dispositivo o cliente:** ____________________________________

**Resultado:** ________________________________________________

**Captura:** `[PEGAR E09-01-acceso-lan.png AQUÍ]`

## E-10 — Estado final

**Commit o versión:** _________________________________________

**Pendientes explícitos:** ____________________________________

**Captura:** `[PEGAR E10-01-estado-final.png AQUÍ]`

## Regla de completitud

Una sección solo puede marcarse como `VALIDADO` si existe un resultado observable y su captura o log correspondiente. Si una prueba no se ejecutó, escribir `PENDIENTE` o `BLOQUEADO`; nunca rellenar con un resultado esperado.

## Reproducibilidad y medición

Para que otra persona pueda repetir la práctica, cada evidencia validada debe conservar:

1. el prompt o instrucción utilizada, guardado en `artifacts/prompts/`;
2. el commit o versión del repositorio;
3. el comando exacto o la acción ejecutada;
4. la fecha y hora UTC;
5. el resultado observado y su estado;
6. la captura y el log relacionados.

El archivo `artifacts/evidence/manifest.csv` debe relacionar cada evidencia con su prompt, comando, captura, log, estado y timestamp. No se debe declarar una prueba reproducible si falta alguno de esos elementos.

