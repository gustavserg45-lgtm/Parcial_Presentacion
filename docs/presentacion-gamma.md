# Estructura de presentación y prompt para Gamma

## Objetivo de la presentación

Sustentar que **San Luquitas Digital** es una infraestructura reproducible para una institución educativa: una VM Fedora aloja simultáneamente un EVA Moodle y un portal institucional Laravel, con bases separadas, persistencia, seguridad, copias de respaldo y pruebas observables.

La presentación debe distinguir siempre entre:

- **Validado:** existe un resultado observado y un log o captura real.
- **Pendiente:** todavía falta ejecutar, comprobar o capturar.
- **Propuesto:** decisión de diseño que se explica, pero no se presenta como resultado.

## Orden recomendado de diapositivas

| # | Diapositiva | Qué debe demostrar | Evidencia sugerida |
|---:|---|---|---|
| 1 | Portada | Proyecto, equipo, asignatura, fecha | Imagen sobria de infraestructura educativa; no usarla como evidencia |
| 2 | Problema y objetivo | Qué necesidad resuelve la solución | Diagrama simple del contexto |
| 3 | Requerimientos | Moodle, Laravel, LAN, persistencia, seguridad, backup y OVA | Tabla breve de requisitos |
| 4 | Arquitectura general | Cómo se conectan Fedora, Docker Compose, Moodle, Laravel y las dos DB | Diagrama de `docs/03-arquitectura.md` |
| 5 | Decisiones técnicas | Por qué Fedora, Docker, Compose, MariaDB, volúmenes y red interna | Esquema de redes/volúmenes |
| 6 | Estado de la VM y servicios | Fedora, IP, Docker/Compose y servicios activos | E01 + E02; usar solo capturas reales |
| 7 | Portal Laravel | Inicio, recursos, enlace a Moodle y CRUD de novedades | E05 en el protocolo formal; captura de interfaz |
| 8 | EVA Moodle | Curso, tres unidades, recursos, actividad, foro y roles | E04; requiere configurar Moodle y capturar |
| 9 | Persistencia | Los datos sobreviven a recrear contenedores sin borrar volúmenes | E06; captura antes/después + log |
| 10 | Seguridad | DB no expuesta, usuarios separados, firewall, permisos y secretos protegidos | E07; nunca mostrar `.env`, tokens o contraseñas |
| 11 | Backup y restauración | Se respaldan DB/archivos y se verifica recuperación | E08; captura del proceso y resultado |
| 12 | Acceso LAN | Otro dispositivo accede a Moodle y Laravel por IP de la VM | E09; captura desde el segundo dispositivo |
| 13 | Pruebas y limitaciones | Qué pasó, qué falta y qué límites tiene la solución | Tabla PASS/PENDIENTE/BLOQUEADO |
| 14 | Conclusiones y entrega | Valor de la solución, OVA, PDF, código y guía | E10 cuando exista la exportación real |

## Guion oral de la demostración

1. Presentar el problema y el objetivo.
2. Mostrar la arquitectura y justificar el aislamiento de las bases.
3. Abrir Laravel y Moodle simultáneamente.
4. Registrar una novedad ficticia en Laravel y consultarla.
5. Mostrar el curso Moodle y cambiar entre roles ficticios.
6. Explicar la recreación de contenedores y comprobar que los datos permanecen.
7. Mostrar el backup y la restauración controlada.
8. Mostrar el acceso desde otro equipo de la LAN.
9. Cerrar con limitaciones reales: Moodle/roles, LAN, OVA u otros pendientes no deben presentarse como terminados.

## Prompt base para Gamma

```text
Create a 14-slide academic technical defense presentation in Spanish titled
"San Luquitas Digital: infraestructura educativa reproducible con Moodle y Laravel".

Audience: university evaluators of an infrastructure and systems project.
Tone: clear, technical, credible, concise, suitable for an oral defense.
Visual style: modern academic technology, white background, dark navy text,
teal accents, restrained use of orange for warnings, clean diagrams, large
readable labels, minimal text, no fake screenshots, no invented metrics.

Project context:
- A Fedora virtual machine hosts Moodle and an institutional Laravel portal.
- Both applications run with Docker Compose.
- Moodle is the educational environment for the course
  "Mis primeros pasos en programación".
- Laravel is the institutional portal with a real news CRUD backed by a
  separate MariaDB logical database.
- The databases use separate credentials and are not published directly to
  the LAN.
- Persistent volumes preserve application data.
- The project includes backup and restore verification, LAN access testing,
  technical logs, an APA report, and an OVA delivery plan.

Use this slide sequence:
1. Cover.
2. Problem, context and objective.
3. Verifiable requirements.
4. Architecture diagram.
5. Technical decisions and rationale.
6. VM, Docker and simultaneous services.
7. Laravel portal and news CRUD.
8. Moodle course, resources, activity, forum and roles.
9. Persistence after container recreation.
10. Security and network exposure.
11. Backup and real restoration.
12. LAN access from a second device.
13. Test matrix with VALIDATED, PENDING and BLOCKED states.
14. Conclusions, limitations and deliverables.

For every slide, provide:
- a short title;
- no more than 4 concise bullets;
- one suggested visual layout;
- a clearly marked placeholder such as [INSERT E01 SCREENSHOT HERE]
  when a real screenshot is required;
- speaker notes with the technical explanation and one likely evaluator question.

Important integrity rules:
- Do not generate or simulate evidence screenshots.
- Do not claim Moodle roles, LAN access, OVA export or any other item is
  complete unless the supplied project evidence explicitly marks it validated.
- Treat logs as supporting evidence and screenshots as visual evidence.
- Leave placeholders for the real images that will be inserted later.
- Never display passwords, tokens, .env contents, cookies, private keys or
  personal data.
```

## Regla para las imágenes

Cada imagen debe responder a una sola pregunta de evaluación. Debajo de la imagen se recomienda una leyenda corta:

`Figura X. Resultado observado de [prueba]. Fuente: elaboración propia, [fecha UTC].`

Las imágenes decorativas pueden usarse solo en portada o separadores. Las pruebas deben proceder del entorno real y conservar su relación con el log y el manifiesto.

