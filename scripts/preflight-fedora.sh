#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
OUT_DIR="$ROOT_DIR/artifacts/preflight"
OUT_FILE="$OUT_DIR/fedora-preflight-$STAMP.log"
mkdir -p "$OUT_DIR"
umask 077

exec > >(tee "$OUT_FILE") 2>&1

echo "San Luquitas Digital — preflight Fedora"
echo "utc=$STAMP"
echo "--- sistema ---"
cat /etc/os-release
uname -a
printf 'hostname='; hostname
printf 'uid='; id -u

echo "--- recursos ---"
free -h
df -h "$ROOT_DIR"
nproc

echo "--- red ---"
ip -brief address || true
ip route || true

echo "--- seguridad ---"
if command -v getenforce >/dev/null 2>&1; then getenforce; else echo "SELinux: comando getenforce no disponible"; fi
if command -v firewall-cmd >/dev/null 2>&1; then firewall-cmd --state || true; else echo "firewalld: comando no disponible"; fi

echo "--- docker ---"
if command -v docker >/dev/null 2>&1; then
  docker version --format 'client={{.Client.Version}} server={{.Server.Version}}' || true
  docker info --format 'server={{.ServerVersion}} storage={{.Driver}} cgroup={{.CgroupVersion}}' || true
else
  echo "docker: NO INSTALADO"
fi
if docker compose version >/dev/null 2>&1; then docker compose version; else echo "docker compose: NO DISPONIBLE"; fi

echo "--- puertos preferidos ---"
for port in 8083 8084; do
  if ss -ltn "sport = :$port" | tail -n +2 | grep -q .; then
    echo "$port: OCUPADO"
  else
    echo "$port: LIBRE"
  fi
done

echo "--- resultado ---"
echo "Preflight terminado. El log contiene solamente inventario; revisar antes de publicar el host."
echo "log=$OUT_FILE"

