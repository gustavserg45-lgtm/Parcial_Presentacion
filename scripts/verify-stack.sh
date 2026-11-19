#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

[[ -f .env ]] || { echo "Falta .env." >&2; exit 1; }
set -a
# shellcheck disable=SC1091
source .env
set +a
mkdir -p artifacts/runtime
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_FILE="artifacts/runtime/verify-$STAMP.log"
exec > >(tee "$LOG_FILE") 2>&1

echo "San Luquitas Digital — verificación de servicios"
echo "utc=$STAMP"
echo "--- compose ps ---"
docker compose --env-file .env -f infra/compose.yaml ps

echo "--- HTTP portal ---"
curl --fail --silent --show-error --location "http://localhost:${PORTAL_HTTP_PORT:-8083}/up" >/dev/null
echo "portal: HTTP OK"

echo "--- HTTP Moodle ---"
curl --fail --silent --show-error --location "http://localhost:${MOODLE_HTTP_PORT:-8084}/" >/dev/null
echo "moodle: HTTP OK"

echo "--- Laravel ---"
docker compose --env-file .env -f infra/compose.yaml exec -T portal php artisan about-project

echo "--- Moodle ---"
docker compose --env-file .env -f infra/compose.yaml exec -T moodle php admin/cli/cfg.php --name=release

echo "--- resultado ---"
echo "Verificación técnica completada. Log: $LOG_FILE"

