# Requisitos verificables del enunciado (fuente: `referencias/ENUNCIADO_HACKATHON.txt`)

## Objetivo y alcance
**Hackathon InfraTech: San Luquitas Digital.** Diseñar, implementar, administrar, documentar y sustentar infraestructura Linux en VM para Moodle + portal institucional Laravel. Evaluación prioriza infraestructura, no complejidad del software. Laboratorio académico con información ficticia, **sin datos personales reales de menores**.

## Infraestructura obligatoria
- [ ] Fedora Server, Ubuntu Server o Debian instalado en una VM (aquí Fedora, versión por verificar).
- [ ] Apache o Nginx, puertos, direccionamiento IP, acceso desde navegador de **otro equipo** en red local.
- [ ] Docker obligatorio para Laravel. Moodle opcional dentro o fuera de Docker; nuestra arquitectura propuesta: ambos en Docker Compose.
- [ ] Base relacional compatible para Moodle y DB MySQL/MariaDB/PostgreSQL para Laravel; bases lógicas y credenciales diferentes aunque compartan motor.
- [ ] Persistencia de ambas bases y archivos de apps.
- [ ] Seguridad: usuarios, permisos, firewall, privilegios, configuración/credenciales, puertos.
- [ ] Copias de seguridad de Moodle DB + `moodledata` + config y Laravel DB + código/config/archivos persistentes; restauración probada.
- [ ] Administración: inicio, detención, reinicio, estados y logs; redes y volúmenes Docker; Compose y Dockerfile justificables.

## Moodle — contenido mínimo
- [ ] Nombre plataforma **San Luquitas Digital**.
- [ ] Curso **Mis primeros pasos en programación**; 4.º o 5.º de primaria, descripción, población, objetivos.
- [ ] Unidad 1: pensamiento computacional, secuencias y patrones.
- [ ] Unidad 2: algoritmos cotidianos, instrucciones y resolución de problemas.
- [ ] Unidad 3: programación visual, Scratch u otros recursos similares.
- [ ] Tres recursos educativos (páginas, imágenes, documentos, videos o enlaces).
- [ ] Cuestionario o tarea + foro.
- [ ] Administrador, docente, tres estudiantes ficticios matriculados; permisos diferenciados.
- [ ] Identidad básica de institución ficticia.

## Portal Laravel — mínimo
- [ ] Nombre: **Portal Institucional San Luquitas**.
- [ ] Inicio e información de institución ficticia.
- [ ] Novedades: registrar, consultar y/o actualizar; base persistente y demostrar inserción/consulta por interfaz.
- [ ] Recursos y enlaces educativos de programación.
- [ ] Enlace funcional a Moodle.
- [ ] Laravel ejecutándose en Docker con DB y logs.
- [ ] No se exige autenticación avanzada, múltiples perfiles ni integración API con Moodle.

## Pruebas que el profesor exige
- [ ] VM y Linux disponibles.
- [ ] Moodle y Laravel en navegador; funcionamiento simultáneo.
- [ ] Datos/usuarios/actividades Moodle guardados.
- [ ] Novedades Laravel insertadas/consultadas desde DB.
- [ ] Roles distintos probados.
- [ ] Acceso desde otro dispositivo.
- [ ] Reinicio correcto.
- [ ] Persistencia tras recreación de contenedores **sin eliminar volúmenes**.
- [ ] Backup y restauración verificados.
- [ ] Puertos, permisos y acceso administrativo revisados.
- [ ] Cada prueba: procedimiento + resultado observado + evidencia.

## Entregables
- [ ] OVA de VM y guía de importación/arranque/acceso.
- [ ] Moodle configurado, curso, roles, recursos, evaluaciones.
- [ ] Portal Laravel funcional y código fuente.
- [ ] BD, Compose, Dockerfile, diagramas.
- [ ] Documento **PDF** con 20 apartados.
- [ ] Matriz comparativa de alternativas, seguridad/restauración, pruebas, registro IA.
- [ ] Sustentación y demostración.

## Rúbrica (100 %)
| Componente | % |
|---|---:|
| Arquitectura | 10 |
| Implementación infraestructura | 20 |
| Configuración EVA Moodle | 10 |
| Laravel Docker | 10 |
| Documentación técnica | 15 |
| Seguridad, respaldo, persistencia | 10 |
| Análisis comparativo | 10 |
| Sustentación funcional | 10 |
| Uso ético IA | 5 |

**Nivel 5 / extraordinario:** de 4.6 a 5.0; exige robustez, reproducibilidad, pruebas y justificaciones, no sólo instalaciones.

## Referencias suministradas
- Enunciado hackathon: `referencias/ENUNCIADO_HACKATHON.txt` (fuente principal).
- Manual Fedora 44 y siete ejercicios: `referencias/Manual_Docker_Fedora_44_7_Ejercicios.docx` (guía auxiliar **sin Compose**, diferente de la hackathon).
- Manual Docker Fedora 37: `referencias/18_MANUAL_INICIANDO_CON_DOCKER_V1.pdf` (legado, **comandos desactualizados**).
- Plantilla académica APA: `referencias/Plantilla_Normas_APA_7a_Edicion.docx` (original UNAD; adaptar a UNAB).
