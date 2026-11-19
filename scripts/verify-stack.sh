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
compose=(docker compose --env-file .env -f infra/compose.yaml)
"${compose[@]}" config --quiet
echo "--- compose ps ---"
"${compose[@]}" ps

check_http() {
  local endpoint="$1"
  if curl --fail --silent --show-error --location --max-time 20 \
    --retry 1 --retry-connrefused --output /dev/null --write-out 'HTTP %{http_code} %{url_effective}\n' "$endpoint"; then
    return 0
  fi
  echo "HOST_HTTP_BLOCKED endpoint=$endpoint"
}

echo "--- HTTP portal ---"
check_http "http://localhost:${PORTAL_HTTP_PORT:-8083}/up"
check_http "http://localhost:${PORTAL_HTTP_PORT:-8083}/noticias"

docker compose --env-file .env -f infra/compose.yaml exec -T portal \
  curl --fail --silent --show-error --location --max-time 10 http://localhost/up >/dev/null
echo "portal: HTTP OK inside container"

echo "--- HTTP Moodle ---"
check_http "${MOODLE_WWWROOT:-http://localhost:${MOODLE_HTTP_PORT:-8084}}/"
internal_moodle_status="$(docker compose --env-file .env -f infra/compose.yaml exec -T moodle \
  curl --silent --show-error --max-time 10 --output /dev/null --write-out '%{http_code}' http://localhost/ | tr -d '\r\n')"
[[ "$internal_moodle_status" =~ ^[23][0-9][0-9]$ ]]
echo "moodle: HTTP $internal_moodle_status inside container"
echo "moodle: HTTP OK inside container"

echo "--- Laravel ---"
"${compose[@]}" exec -T portal php artisan --version

echo "--- Moodle ---"
"${compose[@]}" exec -T --user www-data --workdir /var/www/html moodle php admin/cli/cfg.php --name=release

echo "--- MariaDB ---"
for service in portal-db moodle-db; do
  container="$("${compose[@]}" ps -q "$service")"
  [[ -n "$container" ]]
  [[ "$(docker inspect --format '{{len .HostConfig.PortBindings}}' "$container")" == 0 ]]
  printf '%s: ' "$service"
  "${compose[@]}" exec -T "$service" sh -ec \
    'MYSQL_PWD="$MARIADB_PASSWORD" mariadb -h 127.0.0.1 -u "$MARIADB_USER" "$MARIADB_DATABASE" -Nse "SELECT VERSION(), DATABASE()"'
done
echo 'MariaDB no tiene puertos publicados en ninguno de los dos contenedores.'

echo "Verificación técnica completada. Log: $LOG_FILE"
