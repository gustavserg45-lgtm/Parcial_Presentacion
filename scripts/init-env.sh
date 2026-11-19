#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env"

if [[ -f "$ENV_FILE" ]]; then
  echo "[init-env] .env ya existe; no se reemplazan secretos."
  exit 0
fi

command -v openssl >/dev/null 2>&1 || {
  echo "[init-env] Falta openssl; instalalo antes de continuar." >&2
  exit 1
}

APP_KEY="base64:$(openssl rand -base64 32 | tr -d '\n')"
random_secret() { openssl rand -hex 24; }

umask 077
cat >"$ENV_FILE" <<EOF
COMPOSE_PROJECT_NAME=sanluquitas
APP_NAME="San Luquitas Digital"
APP_ENV=local
APP_DEBUG=false
APP_KEY=$APP_KEY
APP_URL=http://localhost:8083
PORTAL_HTTP_PORT=8083
NEWS_ADMIN_TOKEN=$(random_secret)
PORTAL_DB_NAME=portal
PORTAL_DB_USER=portal_app
PORTAL_DB_PASSWORD=$(random_secret)
PORTAL_DB_ROOT_PASSWORD=$(random_secret)
MOODLE_HTTP_PORT=8084
MOODLE_WWWROOT=http://localhost:8084
MOODLE_PHP_IMAGE_TAG=8.3
MOODLE_DOWNLOAD_URL=https://download.moodle.org/download.php/direct/stable502/moodle-latest-502.zip
MOODLE_DB_NAME=moodle
MOODLE_DB_USER=moodle_app
MOODLE_DB_PASSWORD=$(random_secret)
MARIADB_ROOT_PASSWORD=$(random_secret)
EOF

echo "[init-env] .env creado con permisos 600. No contiene valores para capturas ni commits."

