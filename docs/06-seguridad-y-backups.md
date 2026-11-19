# Seguridad, persistencia y recuperación

## Checklist técnico
- [ ] Firewall y servicios de Fedora activos; abrir sólo puertos LAN web necesarios, restringir SSH.
- [ ] No exponer los puertos MariaDB al LAN ni Internet; Docker puede modificar reglas de red del host, verificar puertos publicados con `docker ps` y `ss -lntp`.
- [ ] Usuarios DB Moodle/Laravel separados con permisos sólo a su base.
- [ ] `.env` no versionado, `.env.example` sin secretos, `APP_DEBUG=false` cuando se presente la demo; permisos de archivos y volúmenes.
- [ ] SELinux activo; montajes localizados con opciones apropiadas.
- [ ] Datos almacenados persistentemente; redes y volúmenes nombrados.
- [ ] Respaldo consistente de **DB Moodle**, `moodledata`, `config.php` y componentes necesarios; **DB Laravel**, código/config sin exponer secretos y archivos que la app escriba.
- [ ] Restaurar backup en entorno controlado o con prueba que no destruya la única copia. Comprobar un registro que existía antes del borrado deliberado de prueba.
- [ ] Evidencia con fecha, comando resumido, logs de resultado y estado PASS/FAIL.

## Guía para Codex
1. Generar scripts de backup y restore con `set -Eeuo pipefail`, validaciones y rutas configurables, nunca asumir nombres ni secretos.
2. Usar dump adecuado al motor (`mariadb-dump` para MariaDB) y hacer copia coherente de datos/archivos.
3. Probar restauración sin sobrescribir datos reales por sorpresa. Primero datos ficticios y destino de recuperación aislado si es viable.
4. Documentar dónde se almacenan respaldos fuera de volúmenes si se entrega OVA por separado.
5. **Jamás** `docker compose down -v` ni `docker system prune --volumes` durante pruebas de persistencia.
