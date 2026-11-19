# Hackathon InfraTech — San Luquitas Digital

> **Estado:** kit de arranque y especificaciones. **No** es una implementación ya desplegada ni validada. Codex debe crear y probar los servicios. Fecha de evaluación del enunciado: 19 de noviembre de 2026. El usuario indicó una meta personal de entrega antes de las 14:00 (hora Colombia); no asumir que se cumplió.

## Objetivo
Construir en una máquina virtual Fedora (VirtualBox) una infraestructura académica reproducible que aloje simultáneamente:

1. **San Luquitas Digital:** Moodle con curso *Mis primeros pasos en programación* para 4.º/5.º de primaria.
2. **Portal Institucional San Luquitas:** aplicación Laravel desplegada en Docker y conectada a base de datos, con operaciones reales de guardar/consultar novedades.

Obligatorios: Linux, servidor web, redes y acceso LAN, Docker en Laravel, bases de datos separadas (lógicamente y con credenciales distintas), almacenamiento persistente, seguridad, backups/restauración demostrados, pruebas, PDF técnico, matriz comparativa, registro de IA, archivo OVA y sustentación.

## Inicio rápido con Codex
1. Leer **`AGENTS.md`**, **`docs/01-requisitos.md`** y **`docs/02-plan-ejecucion.md`**.
2. Abrir **`prompts/00-PROMPT-MAESTRO-CODEX.md`** y pegar su contenido en Codex, desde la raíz del repositorio.
3. Codex empieza con inspección del repositorio y diagnóstico no destructivo, luego implementa por fases y muestra evidencia sólo en puntos específicos.
4. Los scripts de `scripts/` son de diagnóstico; no hacen despliegue ni demuestran éxito de apps.

## Trabajo local y sincronización
- **Fuente de verdad:** repositorio Git; Codex edita archivos versionados y crea cambios revisables.
- **Ejecución:** Fedora virtualizada en VirtualBox, administrada por el usuario desde PowerShell/SSH.
- **Despliegue:** `git pull` dentro de Fedora + `docker compose` **cuando el archivo Compose ya haya sido creado y verificado por Codex**.
- **Capturas:** se toman en Fedora/navegador/PowerShell sólo después de ejecutar cada prueba; nunca simular capturas.
- **Exportación:** la OVA se genera desde VirtualBox en el equipo anfitrión, con la VM apagada adecuadamente.

## Documentos
- `docs/01-requisitos.md`: lista verificable del enunciado y la rúbrica.
- `docs/02-plan-ejecucion.md`: pasos y prioridades.
- `docs/03-arquitectura.md`: topología y decisiones.
- `docs/04-evidencias.md`: cuándo capturar exactamente.
- `docs/05-informe-apa.md`: estructura de los 20 apartados y plantilla.
- `docs/06-seguridad-y-backups.md`: mínimos de seguridad y demostración de restauración.
- `docs/07-sustentacion.md`: demostración y preguntas.
- `docs/08-registro-ia.md`: transparencia sobre IA.
- `docs/09-estado.md`: estado inicial; actualizar sólo con verificaciones.
- `docs/10-flujo-codex-powershell.md`: cómo se conectan Codex local/cloud, GitHub, PowerShell y Fedora.
- `referencias/README.md`: explicación de las fuentes originales. Los archivos originales no se suben al repositorio público para evitar exponer datos personales o material de terceros. Pueden guardarse localmente para Codex.

## Referencias técnicas oficiales
- Docker Fedora: https://docs.docker.com/engine/install/fedora/
- Docker Compose: https://docs.docker.com/compose/
- Moodle instalación 5.2: https://docs.moodle.org/502/en/Installation_quick_guide
- Laravel deployment: https://laravel.com/docs/13.x/deployment

> No publicar credenciales, archivos `.env`, dumps con datos sensibles ni claves SSH. Trabajar con usuarios y datos **ficticios** de laboratorio.

## Seguridad de este repositorio público
No subir nombres completos de estudiantes reales, credenciales, archivos `.env`, capturas con datos privados, copias SQL, OVA ni documentos institucionales originales sin revisión de permisos. Los materiales de referencia pueden estar disponibles fuera de GitHub en el equipo local.

## Implementación disponible en este checkout

La implementación técnica ya incluye `infra/compose.yaml`, `portal/`, `config/moodle/`, `.env.example`, `scripts/init-env.sh`, `scripts/bootstrap-moodle.sh`, `scripts/install-stack.sh` y `scripts/verify-stack.sh`. Fedora debe sincronizar este checkout con `git pull` antes de ejecutar scripts.

```bash
bash scripts/init-env.sh
bash scripts/install-stack.sh
bash scripts/verify-stack.sh
```

La ejecución real aún debe comprobarse en Fedora y no se debe presentar como validada hasta obtener sus logs.
