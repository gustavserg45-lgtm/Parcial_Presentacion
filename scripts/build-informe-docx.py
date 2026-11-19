#!/usr/bin/env python3
"""Build an editable academic report while retaining styles from the supplied APA template."""
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED
from xml.etree import ElementTree as ET
from xml.sax.saxutils import escape

NS = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"
ET.register_namespace("w", NS)
W = "{" + NS + "}"

def paragraph(text="", style="Normal", bold=False):
    p = ET.Element(W + "p")
    if style:
        ps = ET.SubElement(p, W + "pPr")
        ET.SubElement(ps, W + "pStyle", {W + "val": style})
    r = ET.SubElement(p, W + "r")
    if bold:
        rp = ET.SubElement(r, W + "rPr")
        ET.SubElement(rp, W + "b")
    t = ET.SubElement(r, W + "t")
    t.text = text
    return p

def page_break():
    p = ET.Element(W + "p")
    r = ET.SubElement(p, W + "r")
    ET.SubElement(r, W + "br", {W + "type": "page"})
    return p

sections = [
    ("2. Introducción", "San Luquitas Digital es una infraestructura educativa reproducible implementada en una máquina virtual Fedora. El sistema integra un portal institucional Laravel y un entorno virtual de aprendizaje Moodle, ejecutados con Docker Compose y conectados a bases MariaDB separadas. El informe documenta la configuración observada, las pruebas ejecutadas, la persistencia, el respaldo y las limitaciones pendientes."),
    ("3. Objetivos", "Objetivo general: implementar y verificar una infraestructura académica funcional para publicar un portal institucional y un curso Moodle en una VM Fedora. Objetivos específicos: desplegar ambos servicios con Docker Compose; configurar un curso con recursos, actividad, foro y roles ficticios; comprobar CRUD, persistencia, seguridad, backup y restauración; y organizar evidencias reproducibles."),
    ("4. Análisis de requerimientos", "Se requirieron Fedora Linux, Docker, Docker Compose, un servidor web, Moodle, Laravel, dos bases lógicamente separadas, acceso LAN, almacenamiento persistente, controles de red, backups, restauración, evidencias visuales y documentación APA. El alcance usa exclusivamente información ficticia de laboratorio."),
    ("5. Arquitectura tecnológica propuesta", "La VM Fedora expone el portal Laravel en el puerto 8083 y Moodle en el puerto 8084. Cada aplicación usa una base MariaDB independiente. Las bases permanecen en redes internas Docker y no publican el puerto 3306. Los volúmenes nombrados conservan código, bases y moodledata."),
    ("6. Tecnologías utilizadas", "Entorno observado: Fedora Linux 44; Docker Engine 29.10.0; Docker Compose v5.8.0; Moodle 5.2.5+; Laravel Framework 13.43.0; MariaDB 11.8.9; Apache/PHP en los contenedores; firewalld activo. IP LAN observada: 192.168.56.103."),
    ("7. Justificación de decisiones técnicas", "Docker Compose permite reproducir servicios y dependencias; MariaDB separada reduce el alcance de permisos; los volúmenes protegen los datos frente a recreaciones; las redes internas evitan publicar las bases; Fedora dentro de VirtualBox facilita la demostración académica y el acceso local sin depender de un proveedor externo."),
    ("8. Instalación y configuración del servidor Linux", "El preflight registró Fedora, kernel, memoria, disco, interfaces, Docker, Compose y estado del firewall. El despliegue se realizó desde /root/Parcial_Presentacion con scripts versionados y registros UTC. No se eliminaron volúmenes ni se ejecutó docker compose down -v."),
    ("9. Implementación de Moodle", "Moodle se instaló con la imagen moodlehq/moodle-php-apache:8.3 y una base MariaDB 11.8.9. El sitio responde mediante 8084. Se corrigió el valor MOODLE_WWWROOT para que use http://192.168.56.103:8084 en vez de localhost, permitiendo redirecciones correctas desde otros equipos."),
    ("10. Configuración del EVA", "El curso Mis primeros pasos en programación quedó configurado con tres unidades, tres páginas, dos foros, una tarea, un docente y tres estudiantes ficticios. La verificación CLI registró estos elementos. Las capturas web muestran la administración Moodle; el dashboard observado no mostró cursos inscritos para la cuenta de esa captura, por lo que no se afirma una matrícula visual adicional."),
    ("11. Implementación de Laravel en Docker", "El portal institucional se construyó desde portal/Dockerfile y se publicó en el puerto 8083. La prueba CRUD insertó una novedad ficticia mediante POST y la recuperó mediante GET en /noticias. El portal incluye navegación institucional y enlace al aula Moodle."),
    ("12. Configuración de bases de datos", "portal-db y moodle-db son servicios MariaDB independientes con credenciales distintas. El puerto 3306 no se publica hacia la LAN. Las comprobaciones mostraron bases saludables y consultas realizadas desde sus aplicaciones correspondientes."),
    ("13. Seguridad, respaldo y recuperación", "La zona public de firewalld quedó configurada con 8080, 8083 y 8084/tcp; las bases no se exponen. El backup incluye dumps SQL, moodledata y código. La restauración aislada comprobó dos tablas en el portal y 490 en Moodle. Los secretos del archivo .env no se incluyen en las evidencias."),
    ("14. Pruebas de funcionamiento", "E01 preflight: VALIDADO. E02 servicios HTTP: VALIDADO. E03 Moodle y contenido: VALIDADO. E04 persistencia: VALIDADO. E05 backup/restauración: PENDIENTE de asociar el log exacto de la captura posterior. E06 seguridad: VALIDADO. E07 CRUD Laravel: VALIDADO. E08 reinicio limpio: PENDIENTE por fallo transitorio observado. E09 LAN: PENDIENTE de captura desde segundo dispositivo. E10 OVA: BLOQUEADO porque VBoxManage no está disponible en Fedora."),
    ("15. Análisis comparativo", "Docker Compose frente a procesos instalados manualmente: Compose mejora reproducibilidad y aislamiento. MariaDB frente a una base compartida sin separación: las bases independientes reducen riesgos de permisos. Backup lógico frente a copiar solo la VM: los dumps y archivos permiten restauración selectiva. Acceso LAN frente a depender de Internet: la LAN es adecuada para un laboratorio local con conectividad limitada."),
    ("16. Uso ético y adecuado de IA", "La IA se utilizó para estructurar scripts, documentación, pruebas y el guion técnico. Cada resultado operativo fue contrastado con comandos reales en Fedora y se conservaron logs UTC. No se inventaron capturas, resultados, nombres de profesores ni exportaciones OVA. Los datos del curso y usuarios Moodle son ficticios."),
    ("17. Limitaciones y recomendaciones", "Falta completar la captura de acceso Moodle desde un segundo dispositivo, repetir un reinicio limpio, asociar el log exacto del backup mostrado y exportar la OVA desde PowerShell/VirtualBox del host Windows. Se recomienda conservar el archivo .env fuera del repositorio, mantener backups y documentar la red disponible al momento de la demo."),
    ("18. Conclusiones", "La infraestructura principal quedó funcional y observable: Fedora aloja simultáneamente Laravel y Moodle, las bases están separadas, los datos persisten y el backup puede restaurarse de forma aislada. Las pruebas pendientes están delimitadas y no se presentan como completadas. La solución constituye un MVP técnico reproducible para la sustentación."),
    ("19. Referencias", "Docker Documentation. (2026). Docker Engine y Compose. https://docs.docker.com/\nLaravel. (2026). Laravel documentation. https://laravel.com/docs/\nMoodle. (2026). Moodle documentation. https://docs.moodle.org/\nMariaDB. (2026). MariaDB documentation. https://mariadb.com/docs/\nUniversidad Autónoma de Bucaramanga. (s. f.). Sitio institucional. https://www.unab.edu.co/"),
    ("20. Anexos", "Anexo A. Manifest de evidencias: artifacts/evidence/manifest.csv. Anexo B. Capturas UTC: artifacts/evidence/2026-11-19/. Anexo C. Scripts de preflight, verificación, persistencia, CRUD, backup y restauración. Anexo D. Guía de pasos manuales: docs/11-pasos-manuales-entrega.md. Anexo E. Plantilla APA suministrada por el usuario."),
]

def build(template, output):
    with ZipFile(template) as zin:
        xml = zin.read("word/document.xml")
        root = ET.fromstring(xml)
        body = root.find(W + "body")
        sect = body.find(W + "sectPr")
        for child in list(body):
            if child is not sect:
                body.remove(child)
        body.append(paragraph("San Luquitas Digital: infraestructura educativa reproducible con Moodle y Laravel", "Title", True))
        body.append(paragraph("Informe técnico académico", "Subtitle"))
        body.append(paragraph("Autor: Abraham Caceres Salazar"))
        body.append(paragraph("Profesor: Yamid Gabriel Gamba González"))
        body.append(paragraph("Universidad Autónoma de Bucaramanga (UNAB)"))
        body.append(paragraph("Asignatura: Infraestructura de Redes y Tecnológica"))
        body.append(paragraph("Fecha: 19 de noviembre de 2026"))
        body.append(paragraph("Sustentación: 19 de noviembre de 2026, 7:00 p. m.; duración estimada: 20 minutos"))
        body.append(page_break())
        body.append(paragraph("1. Portada", "Heading 1", True))
        body.append(paragraph("Este informe se elaboró a partir de la plantilla APA 7.ª edición suministrada para la asignatura Infraestructura de Redes y Tecnológica."))
        for title, text in sections:
            body.append(page_break())
            body.append(paragraph(title, "Heading 1", True))
            for chunk in text.split("\n"):
                body.append(paragraph(chunk))
        outxml = ET.tostring(root, encoding="utf-8", xml_declaration=True)
        with ZipFile(output, "w", ZIP_DEFLATED) as zout:
            for item in zin.infolist():
                data = outxml if item.filename == "word/document.xml" else zin.read(item.filename)
                zout.writestr(item, data)

if __name__ == "__main__":
    build(Path("referencias/Plantilla_Normas_APA_7a_Edicion.docx"), Path("San-Luquitas-Digital-Informe-Tecnico-Abraham.docx"))
    print("created San-Luquitas-Digital-Informe-Tecnico-Abraham.docx")
