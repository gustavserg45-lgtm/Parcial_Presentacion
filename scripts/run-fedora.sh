#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
ARTIFACT_DIR="$ROOT_DIR/artifacts/runtime"
LOG_FILE="$ARTIFACT_DIR/run-fedora-$STAMP.log"
mkdir -p "$ARTIFACT_DIR"
umask 077
exec > >(tee "$LOG_FILE") 2>&1
trap 'rc=$?; printf "FAIL exit=%s fase=%s UTC=%s\n" "$rc" "$phase" "$(date -u +%FT%TZ)"' ERR
phase=preflight

echo "San Luquitas Digital — ejecución única en Fedora"
echo "utc=$STAMP"
echo "root=$ROOT_DIR"

echo "[1/4] Ejecutando preflight del host."
bash scripts/preflight-fedora.sh

phase=entorno
echo "[2/4] Preparando variables locales."
if [[ ! -f .env ]]; then
  bash scripts/init-env.sh
else
  echo ".env ya existe; se conserva sin reemplazar secretos."
fi

phase=instalación
echo "[3/4] Instalando y levantando Moodle, Laravel y sus bases de datos."
bash scripts/install-stack.sh

phase=verificación
echo "[4/4] Ejecutando verificación HTTP y de versiones."
bash scripts/verify-stack.sh

echo "=== EJECUCIÓN COMPLETADA ==="
echo "log=$LOG_FILE"
echo "Para probar la persistencia tras recrear los servicios: bash scripts/verify-persistence.sh"
