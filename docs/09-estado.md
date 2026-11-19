# Estado real del proyecto (actualizar con evidencias)

Última actualización: 2026-11-19. El usuario proporcionó diagnóstico real de Fedora y Docker.

| Entregable | Estado | Evidencia / siguiente acción |
|---|---|---|
| VM Fedora y acceso | VALIDADO | Fedora 44; hostname servidor-rural-acaceres163; IPs 10.0.2.15 y 192.168.56.103 |
| Recursos VM | VALIDADO | 2 CPU, 1.9 GiB RAM, 5.9 GiB swap, 17 GiB libres en / |
| Docker + Compose | VALIDADO | Docker 29.10.0, Compose v5.8.0, daemon active, hello-world correcto |
| SELinux / firewalld | ATENCIÓN | SELinux aparece Disabled; firewalld active. No deshabilitar firewalld; revisar SELinux antes del despliegue final |
| Repositorio Fedora | EN PROGRESO | El clon original no tenía los commits de infraestructura; sincronizar después de publicar el merge |
| Compose y redes privadas | EN PROGRESO | infra/compose.yaml preparado localmente; falta ejecutar en Fedora |
| Laravel portal y CRUD | EN PROGRESO | Código y Dockerfile preparados; falta build y validación real |
| Moodle y curso | PENDIENTE | Falta descarga, instalación, curso, roles y actividades |
| Persistencia | PENDIENTE | Prueba real de recreación sin borrar volúmenes |
| Seguridad | EN PROGRESO | Bases sin puertos publicados en Compose; revisar SELinux/firewall/permisos en Fedora |
| Backup y restauración | PENDIENTE | Falta ejecutar respaldo y restauración verificable |
| Acceso LAN | PENDIENTE | Probar desde otro dispositivo usando la IP de la interfaz adecuada |
| Documento APA / PDF | PENDIENTE | Redactar con resultados verificables y capturas E01-E10 |
| OVA e importación | PENDIENTE | Exportar desde VirtualBox host, no desde Fedora |

## Resultado Fedora recibido

El usuario ejecutó el preflight el 2026-11-19 a las 14:20 (-05:00). Fedora 44, kernel 6.19.10-300.fc44.x86_64, Docker 29.10.0, Compose v5.8.0, daemon activo y `hello-world` correcto. La VM tiene 2 CPU, aproximadamente 1.9 GiB RAM, 5.9 GiB swap y 17 GiB libres. El kernel informó un soft lockup de `dockerd` durante la descarga, pero Docker terminó correctamente; se debe vigilar el rendimiento durante el build.

El script y la infraestructura no estaban disponibles en el clon Fedora porque la rama remota todavía no contenía los commits locales de Codex. El próximo paso es publicar/integrar los commits y ejecutar `git pull` en Fedora.

No cambiar a **VALIDADO** sin resultado observado y evidencia asociada.
