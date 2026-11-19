# Flujo Codex + PowerShell + Fedora

## Convención

Codex trabaja sobre este checkout en Windows. Los comandos de validación de plataforma se ejecutan en la VM Fedora mediante el canal que el usuario tenga configurado (SSH, carpeta compartida u otro). No se asume cuál canal está activo.

## Primer comando requerido en Fedora

Desde la raíz del proyecto en Fedora:

```bash
bash scripts/preflight-fedora.sh
```

El script es de solo inventario: no instala paquetes, no inicia contenedores y no cambia SELinux/firewalld. El usuario debe devolver el contenido del log generado y, si se solicita evidencia E-01, una captura del resultado sin secretos.

## Restricciones

- No usar `docker compose down -v`, `docker volume rm` ni `docker system prune --volumes` sin consentimiento explícito.
- No compartir `.env` ni las contraseñas generadas.
- No marcar servicios como operativos hasta probarlos desde localhost y desde la IP LAN de Fedora.

