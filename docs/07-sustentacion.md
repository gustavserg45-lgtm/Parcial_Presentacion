# Demostración técnica para la sustentación

## Demostración en vivo sugerida
1. Enseñar topología y justificar Fedora + Docker Compose + dos bases lógicas.
2. `cat /etc/fedora-release`, `hostname -I`, `docker compose ps`, `docker network ls`, `docker volume ls`.
3. Abrir portal Laravel y Moodle simultáneamente desde navegador; mostrar IP local y puertos.
4. En Laravel registrar nueva novedad y consultarla; ver en DB si se puede.
5. Moodle: curso completo y roles (administrador/docente/estudiante ficticios), actividad y foro.
6. Reiniciar contenedores, comprobar que las novedades y contenidos persisten.
7. Mostrar backups y restaurar un registro ficticio controlado, explicando límites del procedimiento.
8. Explicar protección DB interna, `.env`, SELinux y firewall sin revelar secretos.
9. Mostrar OVA e instrucciones para importar/arrancar.

## Pregunta central
¿Por qué esta arquitectura es apropiada para un EVA Moodle y un portal Laravel en institución rural, evaluando funcionalidad, seguridad, administración, persistencia, respaldo y conectividad limitada?

**Respuesta sustentada (adaptar a pruebas reales):** Un Fedora local en VM permite demostrar administración reproducible; Docker reduce diferencias en despliegue y permite aislar servicios; bases separadas minimizan permisos; LAN disminuye dependencia de Internet para recursos locales; volúmenes y backups permiten conservar/restaurar contenido. Las limitaciones incluyen dependencia de energía/hardware y contenidos externos no disponibles sin Internet. La afirmación de funcionamiento debe corresponder a la demostración observada.

## Preguntas frecuentes
- Imagen vs contenedor; Compose vs Dockerfile; puerto host:contenedor.
- Docker red interna vs red local; por qué DB no se publica.
- Volumen vs bind mount; qué ocurre tras `docker rm` y sin `-v`.
- Cómo ver logs y reiniciar; qué es healthcheck.
- Permisos de Moodle vs autorización en Laravel; diferencias.
- Por qué exportar VM no sustituye respaldos de aplicaciones.
- Diferencias Fedora/Ubuntu, MariaDB/PostgreSQL, Apache/Nginx.
