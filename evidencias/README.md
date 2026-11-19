# Almacén de imágenes y capturas

Este directorio está reservado para capturas reales del proyecto. No guardar aquí imágenes generadas, mockups ni capturas simuladas como si fueran pruebas.

## Convención

Usar el código de la prueba y un consecutivo:

```text
E01-01-preflight.png
E02-01-servicios-http.png
E03-01-moodle-curso.png
E03-02-moodle-roles.png
E04-01-laravel-crud.png
E05-01-persistencia.png
E06-01-seguridad.png
E07-01-backup-restore.png
E08-01-reinicio.png
E09-01-acceso-lan.png
E10-01-estado-final.png
```

## Qué debe verse

- terminal: prompt, comando y salida relevante;
- navegador: URL o IP, pantalla funcional y resultado;
- VirtualBox: VM, exportación OVA y archivos finales;
- texto nítido y contexto suficiente para identificar la prueba.

## Qué debe ocultarse

Contraseñas, tokens, archivos `.env`, cookies, claves privadas, datos reales de estudiantes y direcciones públicas innecesarias.

## Relación con los documentos

Antes de guardar una captura, comprobar `docs/04-evidencias.md` y registrar en `artifacts/evidence/manifest.csv` la captura, el log, el comando/acción, el commit, la fecha UTC y el estado.

Si una prueba aún no se ha ejecutado, no crear un archivo de imagen vacío ni usar una imagen de ejemplo. Mantenerla como `PENDIENTE`.
