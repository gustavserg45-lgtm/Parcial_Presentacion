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

if [[ -f "$MOODLE_DIR/public/version.php" ]]; then
  if [[ ! -e "$MOODLE_DIR/config.php" ]]; then
    install -m 0644 "$ROOT_DIR/config/moodle/config.docker.php" "$MOODLE_DIR/config.php"
  fi
  echo "[bootstrap-moodle] Moodle ya existe en $MOODLE_DIR; no se sobrescribe."
  exit 0
fi

if [[ -e "$MOODLE_DIR" ]]; then
  echo "[bootstrap-moodle] Directorio Moodle incompleto en $MOODLE_DIR; revisar antes de reemplazarlo." >&2
  exit 1
fi

command -v curl >/dev/null 2>&1 || { echo "Falta curl." >&2; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo "Falta unzip." >&2; exit 1; }

mkdir -p "$RUNTIME_DIR"
TMP_DIR="$(mktemp -d "$RUNTIME_DIR/moodle-download.XXXXXX")"
trap 'rm -rf "$TMP_DIR"' EXIT

echo "[bootstrap-moodle] Descargando Moodle desde fuente oficial."
curl --fail --location --retry 3 --silent --show-error "$DOWNLOAD_URL" -o "$TMP_DIR/moodle.zip"
(umask 022; unzip -q "$TMP_DIR/moodle.zip" -d "$TMP_DIR")
if [[ ! -f "$TMP_DIR/moodle/public/version.php" || ! -f "$TMP_DIR/moodle/admin/cli/install_database.php" ]]; then
  echo "[bootstrap-moodle] El ZIP no contiene la estructura esperada de Moodle 5.2." >&2
  exit 1
fi

install -m 0644 "$ROOT_DIR/config/moodle/config.docker.php" "$TMP_DIR/moodle/config.php"
mv -T "$TMP_DIR/moodle" "$MOODLE_DIR"

echo "[bootstrap-moodle] Moodle descargado en $MOODLE_DIR."
echo "[bootstrap-moodle] Se requiere ejecutar la instalación CLI dentro del contenedor en la siguiente fase."

