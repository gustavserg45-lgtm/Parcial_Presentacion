# Hackathon InfraTech: San Luquitas Digital

Repositorio del proyecto académico de infraestructura demostrable y reproducible.

## Estado actual

La primera iteración prepara el entorno Compose para un portal Laravel y Moodle con bases independientes. La evidencia real de ejecución debe producirse en Fedora; todavía no se afirma que los servicios estén funcionando.

## Inicio en Fedora

```bash
bash scripts/preflight-fedora.sh
bash scripts/init-env.sh
bash scripts/install-stack.sh
```

El primer comando de preparación normalmente debe ser `bash scripts/preflight-fedora.sh`; no instala ni modifica el host. Revisá `docs/09-estado.md` y `docs/10-flujo-codex-powershell.md` antes de iniciar contenedores.

## Documentación

- `docs/00-auditoria-inicial.md`: qué fuentes estaban realmente publicadas.
- `docs/02-arquitectura-inicial.md`: topología y decisiones provisionales.
- `docs/04-evidencias.md`: capturas permitidas y evidencias requeridas.
- `docs/09-estado.md`: estado honesto por fase.
- `docs/10-flujo-codex-powershell.md`: ejecución en Fedora.
