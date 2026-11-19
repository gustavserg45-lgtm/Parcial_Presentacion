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
docker compose up -d --build portal-db moodle-db portal moodle

echo "[install-stack] Esperando que Moodle responda dentro del contenedor."
for attempt in $(seq 1 30); do
  if docker compose exec -T moodle php -r 'exit(is_dir("/var/www/html/admin/cli") ? 0 : 1);' >/dev/null 2>&1; then
    break
  fi
  if [[ "$attempt" == "30" ]]; then
    echo "Moodle no quedó disponible; revisar docker compose logs moodle." >&2
    exit 1
  fi
  sleep 2
done

if ! docker compose exec -T moodle php admin/cli/cfg.php --name=release >/dev/null 2>&1; then
  echo "[install-stack] Instalando tablas y cuenta administrativa de Moodle."
  docker compose exec -T moodle php admin/cli/install_database.php \
    --agree-license \
    --adminpass="$MOODLE_ADMIN_PASSWORD" \
    --adminemail="$MOODLE_ADMIN_EMAIL" \
    --fullname="$MOODLE_SITE_FULLNAME" \
    --shortname="$MOODLE_SITE_SHORTNAME"
else
  echo "[install-stack] Moodle ya estaba instalado; se conserva la base existente."
fi

echo "[install-stack] Instalación terminada. Log: $LOG_FILE"
echo "[install-stack] No contiene contraseñas; revisar igualmente antes de capturar."

