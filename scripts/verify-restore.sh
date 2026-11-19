#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
source .env

backup_dir="${1:?Uso: bash scripts/verify-restore.sh backups/UTC}"
[[ -d "$backup_dir" ]]
compose=(docker compose --env-file .env -f infra/compose.yaml)
stamp="$(date -u +%Y%m%dT%H%M%SZ)"
log="$ROOT_DIR/artifacts/runtime/restore-$stamp.log"
exec > >(tee "$log") 2>&1

restore_db() {
  local service="$1" archive="$2" name="$3"
  "${compose[@]}" exec -T "$service" sh -ec \
    'mariadb -uroot -p"$MARIADB_ROOT_PASSWORD" -e "DROP DATABASE IF EXISTS restore_check; CREATE DATABASE restore_check"'
  gzip -dc "$backup_dir/$archive" | "${compose[@]}" exec -T "$service" sh -ec \
    'mariadb -uroot -p"$MARIADB_ROOT_PASSWORD" restore_check'
  count="$("${compose[@]}" exec -T "$service" sh -ec \
    'mariadb -uroot -p"$MARIADB_ROOT_PASSWORD" -Nse "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = \"restore_check\""' | tr -d '\r\n')"
  [[ "$count" =~ ^[1-9][0-9]*$ ]]
  echo "$name restore_check tables=$count"
  "${compose[@]}" exec -T "$service" sh -ec \
    'mariadb -uroot -p"$MARIADB_ROOT_PASSWORD" -e "DROP DATABASE restore_check"'
}

restore_db portal-db portal.sql.gz portal
restore_db moodle-db moodle.sql.gz moodle
tar -tzf "$backup_dir/moodledata.tar.gz" >/dev/null
tar -tzf "$backup_dir/portal-source.tar.gz" >/dev/null
echo "PASS: restauración aislada de los dos dumps y validación de archivos."
echo "log=$log"
