#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env"
RUNTIME_DIR="$ROOT_DIR/.runtime"
MOODLE_DIR="$RUNTIME_DIR/moodle"
DOWNLOAD_URL="https://download.moodle.org/download.php/direct/stable502/moodle-latest-502.zip"

if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
  DOWNLOAD_URL="${MOODLE_DOWNLOAD_URL:-$DOWNLOAD_URL}"
fi

if [[ -f "$MOODLE_DIR/version.php" ]]; then
  echo "[bootstrap-moodle] Moodle ya existe en $MOODLE_DIR; no se sobrescribe."
  exit 0
fi

command -v curl >/dev/null 2>&1 || { echo "Falta curl." >&2; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo "Falta unzip." >&2; exit 1; }

mkdir -p "$RUNTIME_DIR"
TMP_DIR="$(mktemp -d "$RUNTIME_DIR/moodle-download.XXXXXX")"
trap 'rm -rf "$TMP_DIR"' EXIT

echo "[bootstrap-moodle] Descargando Moodle desde fuente oficial."
curl --fail --location --retry 3 --silent --show-error "$DOWNLOAD_URL" -o "$TMP_DIR/moodle.zip"
unzip -q "$TMP_DIR/moodle.zip" -d "$TMP_DIR"
test -f "$TMP_DIR/moodle/version.php"

mkdir -p "$MOODLE_DIR"
cp -a "$TMP_DIR/moodle/." "$MOODLE_DIR/"
cp "$ROOT_DIR/config/moodle/config.docker.php" "$MOODLE_DIR/config.php"
chmod 0644 "$MOODLE_DIR/config.php"

echo "[bootstrap-moodle] Moodle descargado en $MOODLE_DIR."
echo "[bootstrap-moodle] Se requiere ejecutar la instalación CLI dentro del contenedor en la siguiente fase."

