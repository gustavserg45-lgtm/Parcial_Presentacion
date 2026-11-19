# Protocolo de evidencias mínimas — sólo capturas imprescindibles

**Regla:** cada checkpoint aprobado debe tener una captura de pantalla real (`.png` o `.jpg`) además del log de texto. Codex debe avisar con `📷 TOMAR EVIDENCIA E##` **después de validar un resultado real**, especificando comando/ventana y archivo final, no después de cada comando. Si la prueba falla: registrar error en logs/estado, pero no inventar la captura de éxito. Ocultar contraseñas, `.env`, tokens, datos privados y direcciones públicas.

| Código | Cuándo hacer captura | Qué debe verse (una captura si cabe) | Guardar como |
|---|---|---|---|
| E01 | Tras preflight | Fedora versión + IP privada + recursos | `evidencias/E01-fedora.png` |
| E02 | Tras instalar Docker | `docker --version`, `docker compose version` y daemon activo / hello-world | `evidencias/E02-docker.png` |
| E03 | Cuando ambos sirven | `docker compose ps` con servicios Up + 2 pestañas o URLs que responden | `evidencias/E03-servicios.png` |
| E04 | Después de configurar Moodle | Curso con 3 unidades, recursos, actividad/foro y roles (2 capturas si necesario) | `evidencias/E04-moodle-curso.png`, `E04-moodle-roles.png` |
| E05 | Tras CRUD Laravel | Novedad registrada y vista de consulta, idealmente DB corroborada | `evidencias/E05-laravel-crud.png` |
| E06 | Después de recrear contenedores | Registro visible antes/después; guardar salidas de pruebas con fecha | `evidencias/E06-persistencia.png` |
| E07 | Después de controles seguridad | Puertos expuestos limitados, usuarios/permisos sin secretos, firewall | `evidencias/E07-seguridad.png` |
| E08 | Tras restauración REAL | Dato recuperado de backup en Moodle y/o Laravel; log con prueba | `evidencias/E08-restauracion.png` |
| E09 | Al verificar acceso LAN | Otro dispositivo accede a Moodle y Laravel por IP de la VM | `evidencias/E09-red-local.png` |
| E10 | Exportar VM y preparar entrega | OVA exportada en host, tamaño y archivos finales presentes | `evidencias/E10-entrega.png` |

Las capturas son entregables obligatorios de cada checkpoint. Deben mostrar la ventana real de PowerShell, terminal Fedora, navegador o VirtualBox donde se vea el comando o pantalla y el resultado. Los logs/textos de comando complementan la imagen y permiten revisar la fecha UTC. La imagen de ejemplo de configuración de `ssh-agent` sólo ilustra el formato de una captura. No cuenta como evidencia de San Luquitas Digital porque no demuestra una prueba de este proyecto. Algunas evidencias de ambos sistemas pueden requerir más de una captura. Sólo el usuario puede obtener pruebas visuales reales de su entorno.

### Bitácora de prueba
Para cada caso: fecha/hora, objetivo, comando/acción, resultado esperado, resultado observado, `PASS/FAIL/BLOCKED`, nombre del archivo evidencia. Guardar como `evidencias/registro-pruebas.md` o CSV. Nunca adjuntar credenciales.

La plantilla consolidada para pegar capturas está en `docs/evidencias/00-paquete-evidencias.md`.
