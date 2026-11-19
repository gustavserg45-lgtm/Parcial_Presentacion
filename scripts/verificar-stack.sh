#!/usr/bin/env bash
set -Eeuo pipefail
cd "$(dirname "$0")/.."
echo '=== Validación de artefactos del proyecto ==='
if [[ ! -f infra/compose.yaml ]]; then
  echo 'PENDIENTE: infra/compose.yaml aún no generado por Codex'
  exit 2
fi
if ! command -v docker >/dev/null; then echo 'PENDIENTE: docker no instalado'; exit 2; fi
if ! docker compose version >/dev/null 2>&1; then echo 'PENDIENTE: compose plugin'; exit 2; fi
docker compose -f infra/compose.yaml config --quiet
printf '%s\n' 'Compose sintácticamente válido; esto NO demuestra que Moodle/Laravel funcionen.'
docker compose -f infra/compose.yaml ps
printf '%s\n' 'Verificar manualmente: URLs, funcionalidades DB, persistencia y restauración.'
