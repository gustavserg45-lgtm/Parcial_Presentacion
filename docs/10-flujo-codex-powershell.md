# Flujo de trabajo: Codex, GitHub, PowerShell y Fedora

## Opción recomendada: Codex local en Windows (VS Code / Codex CLI)
1. Clonar el repositorio en Windows y abrir su carpeta como workspace de Codex.
2. Codex lee AGENTS.md y edita sólo ese repositorio. `git status` y ramas/commits garantizan trazabilidad.
3. El usuario conecta la sesión de PowerShell a Fedora como ya hace actualmente. **Antes de automatizar, comprobar si la conexión es SSH (y el alias) o VBoxManage, porque no está confirmado**.
4. Para validar en Fedora: `git pull` en el clon de Fedora y correr scripts/Compose, o copiar archivos con SCP/rsync si Git no está disponible. Evitar dos fuentes de verdad: los cambios se hacen y versionan en Git, no se editan a la vez en Windows y Fedora.
5. Codex puede ejecutar comandos de PowerShell si la sesión/producto le concede herramientas y permisos. No asumir acceso automático: primero probar comando de sólo lectura como `ssh <alias> cat /etc/fedora-release`; si no tiene acceso, entregar al usuario el comando para pegar.
6. Luego `docker compose -f infra/compose.yaml config`, desplegar, ejecutar pruebas y registrar resultados reales.

## Alternativa: Codex en la nube (repositorio GitHub)
Codex trabaja sobre el repositorio en un entorno remoto, pero **no tiene acceso por defecto a la VM Fedora ni al PowerShell personal**. Debe crear un commit/PR, y el usuario sincroniza los cambios a Fedora con `git pull` y ejecuta las pruebas. No configurar SSH entrante a Internet ni exponer claves privadas por facilidad.

## Secuencia de una iteración
**Codex modifica → verifica local sintaxis/tests que tenga disponibles → commit/revisión → Fedora sincroniza → pruebas reales → logs y evidencias → corrección → commit estable**. Documentar qué se probó en cada ambiente para no confundir simulación con despliegue.

## Exportación OVA
Se ejecuta con VirtualBox en Windows, no dentro de Fedora. Comprobar nombre de VM mediante `VBoxManage list vms`, apagar limpio, realizar exportación y verificar artefactos.

## Implementación actual

Una vez publicado el commit de infraestructura, en Fedora ejecutar `git pull` desde la raíz del repositorio. El Compose canónico está en `infra/compose.yaml`; no editar archivos directamente en Fedora.
