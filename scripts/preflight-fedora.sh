#!/usr/bin/env bash
set -u
printf '%s\n' '=== SAN LUQUITAS: DIAGNOSTICO NO DESTRUCTIVO ==='
printf '%s\n' '-- FECHA --'
date -Is
printf '%s\n' '-- FEDORA --'
cat /etc/fedora-release 2>/dev/null || cat /etc/os-release
printf '%s\n' '-- KERNEL --'
uname -r
printf '%s\n' '-- IP PRIVADAS / INTERFACES --'
hostname -I 2>/dev/null || true
printf '%s\n' '-- RAM --'
free -h
printf '%s\n' '-- DISCO RAIZ --'
df -h /
printf '%s\n' '-- CPU --'
nproc
printf '%s\n' '-- DOCKER CLI --'
if command -v docker >/dev/null 2>&1; then
  docker --version
  docker compose version 2>&1 || true
  docker info --format 'Servidor: {{.ServerVersion}}' 2>&1 || true
  printf '%s\n' '-- CONTENEDORES / PUERTOS --'
  docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' 2>&1 || true
else
  echo 'Docker no disponible en PATH'
fi
printf '%s\n' '-- SERVICIO DOCKER --'
systemctl is-active docker 2>&1 || true
printf '%s\n' '-- SELINUX --'
getenforce 2>&1 || true
printf '%s\n' '-- FIREWALLD --'
systemctl is-active firewalld 2>&1 || true
printf '%s\n' '-- GIT --'
git --version 2>&1 || true
printf '%s\n' '-- VERIFICACION COMPLETADA (NO INSTALA NADA) --'
