#!/usr/bin/env bash
set -euo pipefail

cd /var/www/html

echo "[portal] Esperando la base de datos."
for attempt in $(seq 1 30); do
  if php -r '$pdo = new PDO("mysql:host=" . getenv("DB_HOST") . ";port=" . getenv("DB_PORT"), getenv("DB_USERNAME"), getenv("DB_PASSWORD"));' >/dev/null 2>&1; then
    break
  fi
  if [[ "$attempt" == "30" ]]; then
    echo "[portal] No fue posible conectar a la base de datos." >&2
    exit 1
  fi
  sleep 2
done

php artisan migrate --force
exec apache2-foreground

