#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
source .env

stamp="$(date -u +%Y%m%dT%H%M%SZ)"
backup_dir="$ROOT_DIR/backups/$stamp"
mkdir -p "$backup_dir"
umask 077
log="$ROOT_DIR/artifacts/runtime/backup-$stamp.log"
exec > >(tee "$log") 2>&1

compose=(docker compose --env-file .env -f infra/compose.yaml)
echo "utc=$stamp"
echo "backup_dir=$backup_dir"

dump_db() {
  local service="$1" output="$2"
  "${compose[@]}" exec -T "$service" sh -ec \
    'mariadb-dump --single-transaction --routines --events --triggers -u"$MARIADB_USER" -p"$MARIADB_PASSWORD" "$MARIADB_DATABASE"' \
    > "$backup_dir/$output"
  gzip -9 "$backup_dir/$output"
}

dump_db portal-db portal.sql
dump_db moodle-db moodle.sql
"${compose[@]}" exec -T moodle tar -czf - -C /var/www moodledata > "$backup_dir/moodledata.tar.gz"
tar -czf "$backup_dir/portal-source.tar.gz" --exclude='portal/vendor' --exclude='portal/.env' portal

for file in "$backup_dir"/*.gz; do
  gzip -t "$file" 2>/dev/null || tar -tzf "$file" >/dev/null
  stat -c '%s %n' "$file"
done
echo "PASS: respaldos SQL, moodledata y código del portal creados."
echo "log=$log"
