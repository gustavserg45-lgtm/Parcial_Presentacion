#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

[[ -f .env ]] || { echo "Falta .env. Ejecutá bash scripts/init-env.sh primero." >&2; exit 1; }
command -v docker >/dev/null 2>&1 || { echo "Docker no está disponible." >&2; exit 1; }
docker compose version >/dev/null 2>&1 || { echo "Docker Compose no está disponible." >&2; exit 1; }

set -a
# shellcheck disable=SC1091
source .env
set +a

mkdir -p artifacts/runtime
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_FILE="artifacts/runtime/install-$STAMP.log"
exec > >(tee "$LOG_FILE") 2>&1

echo "[install-stack] Inicializando Moodle desde fuente oficial si falta."
bash scripts/bootstrap-moodle.sh

echo "[install-stack] Levantando bases, portal y Moodle."
docker compose --env-file .env -f infra/compose.yaml up -d --build portal-db moodle-db portal moodle

compose=(docker compose --env-file .env -f infra/compose.yaml)
echo "[install-stack] Preparando permisos del volumen moodledata."
"${compose[@]}" exec -T --user root moodle chown www-data:www-data /var/www/moodledata

if ! "${compose[@]}" exec -T --user www-data --workdir /var/www/html moodle php admin/cli/cfg.php --name=release >/dev/null 2>&1; then
  echo "[install-stack] Instalando tablas y cuenta administrativa de Moodle."
  "${compose[@]}" exec -T --user www-data --workdir /var/www/html moodle php admin/cli/install_database.php \
    --agree-license \
    --adminpass="$MOODLE_ADMIN_PASSWORD" \
    --adminemail="$MOODLE_ADMIN_EMAIL" \
    --fullname="$MOODLE_SITE_FULLNAME" \
    --shortname="$MOODLE_SITE_SHORTNAME"
else
  echo "[install-stack] Moodle ya estaba instalado; se conserva la base existente."
fi

"${compose[@]}" up -d moodle-cron

echo "[install-stack] Instalación terminada. Log: $LOG_FILE"
echo "[install-stack] No contiene contraseñas; revisar igualmente antes de capturar."

