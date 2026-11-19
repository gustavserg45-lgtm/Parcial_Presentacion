# Prompt para ejecución remota y evidencias

Pegá este prompt en el chat Codex conectado al host Fedora y al proyecto `/root/Parcial_Presentacion`.

```text
Trabajá directamente en Fedora sobre /root/Parcial_Presentacion.

Objetivo: dejar funcionando y comprobado el proyecto académico Hackathon InfraTech: San Luquitas Digital, sin inventar resultados.

Antes de modificar archivos:
1. Ejecutá pwd, hostname, id, git status, git branch --show-current y git log -1 --oneline.
2. Leé completamente AGENTS.md, README.md, prompts/00-PROMPT-MAESTRO-CODEX.md, todos los documentos de docs/ y referencias/README.md.
3. Revisá el estado actual y respetá los cambios existentes.

Implementación y validación:
1. Ejecutá bash scripts/run-fedora.sh.
2. Si falla, analizá el error real, corregí el mínimo necesario y repetí la prueba.
3. Validá Moodle, Laravel, las bases de datos, HTTP, persistencia, reinicio y red según docs/01-requisitos.md y docs/04-evidencias.md.
4. No uses docker compose down -v, docker system prune --volumes ni borres volúmenes existentes.
5. No muestres secretos: no captures .env, contraseñas, tokens, cookies, claves privadas ni URLs con credenciales.

Capturas y logs:
1. Tomá capturas solamente después de comprobar el resultado y únicamente cuando sean necesarias para E01-E10.
2. Guardá las capturas en artifacts/evidence/2026-11-19/ con los nombres definidos en docs/evidencias/00-paquete-evidencias.md.
3. Guardá logs técnicos en artifacts/runtime/.
4. Para cada evidencia registrá fecha/hora UTC, comando o acción, resultado observado y estado VALIDADO, PENDIENTE o BLOQUEADO.
5. No tomes capturas decorativas ni repitas capturas que no agreguen prueba.
6. Las capturas de terminal deben parecerse a una sesión real: incluir prompt, comando y salida relevante, conservar contexto del host, ser nítidas y legibles, y evitar recortes que oculten el comando o el resultado.

Documentación:
1. Actualizá docs/09-estado.md con resultados reales y pendientes.
2. Completá los textos de docs/evidencias/00-paquete-evidencias.md sin pegar imágenes dentro del documento; dejá los marcadores [PEGAR ... AQUÍ].
3. No declares el proyecto terminado si alguna validación obligatoria no fue ejecutada.
4. Al finalizar, mostrálos archivos modificados, el resumen de pruebas y las rutas de logs/evidencias.
```
