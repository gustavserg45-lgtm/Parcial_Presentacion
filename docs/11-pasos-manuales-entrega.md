# Pasos manuales de entrega

## Lo que Codex ejecuta directamente

Codex dejó implementados y comprobados Compose, Laravel, Moodle, dos MariaDB, redes, volúmenes, cron, curso Moodle, CRUD Laravel, persistencia, backup, restauración, logs UTC y el manifiesto reproducible.

## Lo que debe hacer el equipo manualmente

### Captura E01 de preflight

En Fedora, abrir una terminal amplia y ejecutar:

```bash
cd /root/Parcial_Presentacion
date -u
pwd
hostname
bash scripts/preflight-fedora.sh
```

Tomar una captura completa con prompt, comando y salida legible. Guardar como `artifacts/evidence/2026-11-19/E01-01-preflight.png`.

### Captura E02 de servicios

```bash
cd /root/Parcial_Presentacion
bash scripts/verify-stack.sh
```

Guardar como `E02-01-servicios-http.png`.

### Captura E03 de Moodle

```bash
cd /root/Parcial_Presentacion
docker cp scripts/verify-moodle-content.php sanluquitas-moodle-1:/tmp/verify-moodle-content.php
docker compose --env-file .env -f infra/compose.yaml exec -T --user www-data moodle php /tmp/verify-moodle-content.php
```

Guardar como `E03-01-moodle-curso.png`. Para la evidencia académica adicional, abrir Moodle en el navegador y mostrar curso, unidades, foro, tarea y usuarios.

### Captura E04 de persistencia

```bash
cd /root/Parcial_Presentacion
bash scripts/verify-persistence.sh
```

Guardar como `E04-01-persistencia.png`.

### Captura E05 de backup y restauración

```bash
cd /root/Parcial_Presentacion
bash scripts/backup-stack.sh
bash scripts/verify-restore.sh backups/20261119T213117Z
```

Si el primer comando crea otra carpeta con timestamp, usar esa carpeta en el segundo comando. Guardar como `E05-01-backup-restore.png`.

### Captura E06 de seguridad

```bash
cd /root/Parcial_Presentacion
docker compose --env-file .env -f infra/compose.yaml ps
ss -ltn
firewall-cmd --state
firewall-cmd --list-ports
getenforce
```

Guardar como `E06-01-puertos-seguridad.png`. No mostrar `.env`, contraseñas ni tokens.

### Captura E07 de CRUD Laravel

```bash
cd /root/Parcial_Presentacion
bash scripts/verify-portal-crud.sh
```

Guardar como `E07-01-laravel-crud.png`. También puede mostrarse `/noticias` en el navegador.

### Captura E09 desde otro dispositivo

Desde otro equipo conectado a la red correcta, abrir `http://192.168.56.103:8083` y `http://192.168.56.103:8084`. Si esa red no es accesible, usar la IP Fedora de la interfaz puente. Guardar como `E09-01-acceso-lan.png`.

### Captura E10 y exportación OVA

En PowerShell del host Windows, con la VM apagada limpiamente:

```powershell
VBoxManage list vms
VBoxManage list runningvms
VBoxManage export "NOMBRE_EXACTO_DE_LA_VM" --output "$PWD\SanLuquitas-Digital.ova"
Get-Item .\SanLuquitas-Digital.ova | Select-Object Name,Length,LastWriteTime
```

Guardar la captura como `E10-01-estado-final.png`. No exportar mientras la VM esté encendida.

## Después de las capturas

Copiar los PNG a `artifacts/evidence/2026-11-19/` y actualizar las columnas `captura` y `estado` de `artifacts/evidence/manifest.csv`. Una evidencia sólo puede pasar a `VALIDADO` cuando tiene log y captura reales.
