#!/usr/bin/env bash
set -Eeuo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
source .env

umask 077
stamp="$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p artifacts/evidence
exec > >(tee "artifacts/evidence/${stamp}-persistencia.log") 2>&1
trap 'echo "FAIL: prueba de persistencia, línea $LINENO."' ERR

compose=(docker compose --env-file .env -f infra/compose.yaml)
portal="http://localhost:${PORTAL_HTTP_PORT:-8083}"
title="Prueba de persistencia $stamp"
cookies="$(mktemp)"
trap 'unlink "$cookies"' EXIT

echo "UTC=$stamp"
echo 'Portal: registrando una novedad ficticia en la base persistente.'
"${compose[@]}" exec -T portal php -r '$pdo = new PDO("mysql:host=" . getenv("DB_HOST") . ";dbname=" . getenv("DB_DATABASE"), getenv("DB_USERNAME"), getenv("DB_PASSWORD")); $q=$pdo->prepare("INSERT INTO news (title, summary, body, published_at, created_at, updated_at) VALUES (?, ?, ?, NOW(), NOW(), NOW())"); $q->execute([$argv[1], "Registro ficticio del laboratorio", "Verificación de recreación de contenedores."]);' "$title"
echo "INSERT news: $title"

moodle() {
  "${compose[@]}" exec -T --user www-data --workdir /var/www/html moodle php "$@"
}

moodle admin/cli/cfg.php --name=release
moodle -r 'if (file_put_contents("/var/www/moodledata/prueba-" . $argv[1], $argv[1], LOCK_EX) === false) exit(1);' "$stamp"

verify_data() {
  local page site
  page="$("${compose[@]}" exec -T portal curl -fsS --max-time 20 http://localhost/noticias)"
  [[ "$page" == *"$title"* ]]
  echo "Laravel lee de MariaDB: $title"
  site="$(moodle -r 'define("CLI_SCRIPT", true); require "config.php"; echo get_site()->fullname;')"
  [[ "$site" == "$MOODLE_SITE_FULLNAME" ]]
  echo "Moodle lee de MariaDB: $site"
  moodle -r 'exit(file_get_contents("/var/www/moodledata/prueba-" . $argv[1]) === $argv[1] ? 0 : 1);' "$stamp"
  echo "Archivo comprobado en moodledata: prueba-$stamp"
}

echo 'Antes de recrear:'
verify_data
old_ids="$("${compose[@]}" ps -q portal moodle portal-db moodle-db)"
"${compose[@]}" up -d --no-build --force-recreate --wait --wait-timeout 180
new_ids="$("${compose[@]}" ps -q portal moodle portal-db moodle-db)"
[[ "$(wc -l <<< "$old_ids")" == 4 && "$(wc -l <<< "$new_ids")" == 4 ]]
while read -r id; do
  [[ -n "$id" && "$old_ids" != *"$id"* ]]
done <<< "$new_ids"
echo 'Después de recrear aplicaciones y bases conservando sus volúmenes:'
"${compose[@]}" ps
verify_data
echo 'PASS: persistencia de ambas bases y moodledata.'
