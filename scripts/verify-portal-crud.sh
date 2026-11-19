#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
source .env

stamp="$(date -u +%Y%m%dT%H%M%SZ)"
cookie_file="$(mktemp)"
log="$ROOT_DIR/artifacts/runtime/portal-crud-$stamp.log"
trap 'rm -f "$cookie_file"' EXIT
exec > >(tee "$log") 2>&1

portal="http://127.0.0.1:${PORTAL_HTTP_PORT:-8083}"
title="CRUD verificable $stamp"
form="$(curl -fsS --max-time 10 -c "$cookie_file" "$portal/noticias")"
csrf="$(sed -n 's/.*name="_token" value="\([^"]*\)".*/\1/p' <<< "$form")"
[[ -n "$csrf" ]]

status="$(curl -sS --max-time 10 -b "$cookie_file" -o /dev/null -w '%{http_code}' \
  -H "X-Admin-Token: $NEWS_ADMIN_TOKEN" \
  --data-urlencode "_token=$csrf" \
  --data-urlencode "title=$title" \
  --data-urlencode 'summary=Novedad ficticia registrada desde HTTP' \
  --data-urlencode 'body=Prueba de inserción y consulta del portal.' \
  "$portal/noticias")"
[[ "$status" == 302 ]]
page="$(curl -fsS --max-time 10 "$portal/noticias")"
grep -Fq "$title" <<< "$page"
echo "POST /noticias HTTP $status"
echo "GET /noticias contiene: $title"
echo "PASS: CRUD Laravel comprobado desde la interfaz HTTP."
echo "log=$log"
