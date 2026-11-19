#!/usr/bin/env python3
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED
from xml.etree import ElementTree as ET
import struct

WNS='http://schemas.openxmlformats.org/wordprocessingml/2006/main'; RNS='http://schemas.openxmlformats.org/officeDocument/2006/relationships'; ANS='http://schemas.openxmlformats.org/drawingml/2006/main'; WPNS='http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing'; PICNS='http://schemas.openxmlformats.org/drawingml/2006/picture'; PRNS='http://schemas.openxmlformats.org/package/2006/relationships'
for pfx,uri in [('w',WNS),('r',RNS),('a',ANS),('wp',WPNS),('pic',PICNS),('',PRNS)]: ET.register_namespace(pfx,uri)
W='{'+WNS+'}'

def para(text='',style='Normal',bold=False):
    p=ET.Element(W+'p'); pp=ET.SubElement(p,W+'pPr'); ET.SubElement(pp,W+'pStyle',{W+'val':style}) if style else None
    r=ET.SubElement(p,W+'r');
    if bold: ET.SubElement(ET.SubElement(r,W+'rPr'),W+'b')
    ET.SubElement(r,W+'t').text=text; return p
def br():
    p=ET.Element(W+'p'); ET.SubElement(ET.SubElement(p,W+'r'),W+'br',{W+'type':'page'}); return p
def image_para(rid,name,data):
    width,height=struct.unpack('>II',data[16:24]); cx=5700000; cy=max(900000,int(cx*height/width)); p=ET.Element(W+'p'); d=ET.SubElement(ET.SubElement(p,W+'r'),W+'drawing'); inline=ET.SubElement(d,'{'+WPNS+'}inline'); ET.SubElement(inline,'{'+WPNS+'}extent',{'cx':str(cx),'cy':str(cy)}); ET.SubElement(inline,'{'+WPNS+'}docPr',{'id':'1','name':name}); g=ET.SubElement(ET.SubElement(inline,'{'+ANS+'}graphic'),'{'+ANS+'}graphicData',{'uri':PICNS}); pic=ET.SubElement(g,'{'+PICNS+'}pic'); nv=ET.SubElement(pic,'{'+PICNS+'}nvPicPr'); ET.SubElement(nv,'{'+PICNS+'}cNvPr',{'id':'0','name':name}); ET.SubElement(nv,'{'+PICNS+'}cNvPicPr'); bf=ET.SubElement(pic,'{'+PICNS+'}blipFill'); ET.SubElement(bf,'{'+ANS+'}blip',{'{'+RNS+'}embed':rid}); st=ET.SubElement(bf,'{'+ANS+'}stretch'); ET.SubElement(st,'{'+ANS+'}fillRect'); sp=ET.SubElement(pic,'{'+PICNS+'}spPr'); xf=ET.SubElement(sp,'{'+ANS+'}xfrm'); ET.SubElement(xf,'{'+ANS+'}off',{'x':'0','y':'0'}); ET.SubElement(xf,'{'+ANS+'}ext',{'cx':str(cx),'cy':str(cy)}); pg=ET.SubElement(sp,'{'+ANS+'}prstGeom',{'prst':'rect'}); ET.SubElement(pg,'{'+ANS+'}avLst'); return p

texts=[
('2. Introducción','San Luquitas Digital es una infraestructura educativa reproducible implementada en una máquina virtual Fedora. Integra un portal institucional Laravel y un entorno virtual Moodle, ejecutados con Docker Compose y conectados a bases MariaDB separadas. Este informe documenta configuración, pruebas, persistencia, respaldo y limitaciones.'),
('3. Objetivos','Objetivo general: implementar y verificar una infraestructura académica funcional para publicar un portal institucional y un curso Moodle en Fedora. Objetivos específicos: desplegar ambos servicios; configurar curso, recursos, actividad, foro y roles ficticios; comprobar CRUD, persistencia, seguridad, backup y restauración; organizar evidencias reproducibles.'),
('4. Análisis de requerimientos','Se requirieron Fedora Linux, Docker, Docker Compose, servidor web, Moodle, Laravel, dos bases lógicamente separadas, acceso LAN, almacenamiento persistente, controles de red, backups, restauración, evidencias visuales y documentación APA. El alcance usa información ficticia de laboratorio.'),
('5. Arquitectura tecnológica propuesta','La VM Fedora expone Laravel en 8083 y Moodle en 8084. Cada aplicación usa una base MariaDB independiente. Las bases permanecen en redes internas Docker y no publican 3306. Los volúmenes nombrados conservan código, bases y moodledata.'),
('6. Tecnologías utilizadas','Fedora Linux 44; Docker Engine 29.10.0; Docker Compose v5.8.0; Moodle 5.2.5+; Laravel Framework 13.43.0; MariaDB 11.8.9; Apache/PHP; firewalld activo. IP LAN: 192.168.56.103.'),
('7. Justificación de decisiones técnicas','Docker Compose mejora reproducibilidad y aislamiento; MariaDB separada reduce el alcance de permisos; los volúmenes protegen datos frente a recreaciones; las redes internas evitan publicar bases; Fedora en VirtualBox facilita una demostración local.'),
('8. Instalación y configuración del servidor Linux','El preflight registró Fedora, kernel, memoria, disco, interfaces, Docker, Compose y firewall. El despliegue se realizó desde /root/Parcial_Presentacion con scripts versionados y registros UTC. No se eliminaron volúmenes ni se ejecutó docker compose down -v.'),
('9. Implementación de Moodle','Moodle se instaló con moodlehq/moodle-php-apache:8.3 y MariaDB 11.8.9. El sitio responde en 8084. Se corrigió MOODLE_WWWROOT para usar http://192.168.56.103:8084 en vez de localhost, permitiendo redirecciones correctas desde otros equipos.'),
('10. Configuración del EVA','El curso Mis primeros pasos en programación quedó configurado con tres unidades, tres páginas, dos foros, una tarea, un docente y tres estudiantes ficticios. La verificación CLI registró estos elementos. El dashboard observado no mostró cursos inscritos para la cuenta de esa captura, por lo que no se afirma una matrícula visual adicional.'),
('11. Implementación de Laravel en Docker','El portal institucional se construyó desde portal/Dockerfile y se publicó en 8083. La prueba CRUD insertó una novedad ficticia mediante POST y la recuperó mediante GET en /noticias. Incluye navegación institucional y enlace al aula Moodle.'),
('12. Configuración de bases de datos','portal-db y moodle-db son servicios MariaDB independientes con credenciales distintas. El puerto 3306 no se publica hacia la LAN. Las comprobaciones mostraron bases saludables y consultas desde sus aplicaciones.'),
('13. Seguridad, respaldo y recuperación','La zona public de firewalld permite 8080, 8083 y 8084/tcp; las bases no se exponen. El backup incluye dumps SQL, moodledata y código. La restauración aislada comprobó dos tablas en portal y 490 en Moodle. Los secretos .env no se incluyen.'),
('14. Pruebas de funcionamiento','E01 preflight VALIDADO; E02 servicios HTTP VALIDADO; E03 Moodle y contenido VALIDADO; E04 persistencia VALIDADO; E05 backup/restauración PENDIENTE por log exacto ausente; E06 seguridad VALIDADO; E07 CRUD Laravel VALIDADO; E08 reinicio limpio PENDIENTE por fallo transitorio; E09 LAN PENDIENTE de captura externa; E10 OVA BLOQUEADO porque VBoxManage no está disponible en Fedora.'),
('15. Análisis comparativo','Compose frente a procesos manuales mejora reproducibilidad y aislamiento. Bases independientes reducen riesgos de permisos. Backup lógico permite restauración selectiva. Acceso LAN resulta adecuado para un laboratorio local con conectividad limitada.'),
('16. Uso ético y adecuado de IA','La IA se utilizó para estructurar scripts, documentación, pruebas y guion técnico. Cada resultado fue contrastado con comandos reales en Fedora y logs UTC. No se inventaron capturas, resultados, nombres ni exportaciones OVA. Los usuarios Moodle son ficticios.'),
('17. Limitaciones y recomendaciones','Falta completar captura Moodle desde segundo dispositivo, repetir reinicio limpio, asociar log exacto del backup mostrado y exportar OVA desde PowerShell/VirtualBox del host Windows. Se recomienda conservar .env fuera del repositorio y mantener backups.'),
('18. Conclusiones','La infraestructura principal quedó funcional y observable: Fedora aloja Laravel y Moodle, las bases están separadas, los datos persisten y el backup puede restaurarse de forma aislada. Las pruebas pendientes están delimitadas y no se presentan como completadas.'),
('19. Referencias','Docker Documentation. (2026). Docker Engine y Compose. https://docs.docker.com/\nLaravel. (2026). Laravel documentation. https://laravel.com/docs/\nMoodle. (2026). Moodle documentation. https://docs.moodle.org/\nMariaDB. (2026). MariaDB documentation. https://mariadb.com/docs/\nUniversidad Autónoma de Bucaramanga. (s. f.). Sitio institucional. https://www.unab.edu.co/'),
('20. Anexos','Anexo A. Manifest: artifacts/evidence/manifest.csv. Anexo B. Capturas UTC. Anexo C. Scripts de preflight, verificación, persistencia, CRUD, backup y restauración. Anexo D. Guía manual: docs/11-pasos-manuales-entrega.md. Anexo E. Plantilla APA suministrada.'),]

def build():
    template=Path('referencias/Plantilla_Normas_APA_7a_Edicion.docx'); output=Path('San-Luquitas-Digital-Informe-Tecnico-Final.docx'); imgs=sorted(Path('artifacts/evidence/2026-11-19').glob('E*.png'))
    with ZipFile(template) as zin:
        root=ET.fromstring(zin.read('word/document.xml')); body=root.find(W+'body'); sect=body.find(W+'sectPr')
        for child in list(body):
            if child is not sect: body.remove(child)
        for node in [para('UNIVERSIDAD AUTÓNOMA DE BUCARAMANGA','Title',True),para('UNAB','Subtitle',True),para('San Luquitas Digital: infraestructura educativa reproducible con Moodle y Laravel','Title',True),para('INFORME TÉCNICO ACADÉMICO'),para('Autor: Abraham Caceres Salazar'),para('Profesor: Yamid Gabriel Gamba González'),para('Asignatura: Infraestructura de Redes y Tecnológica'),para('19 de noviembre de 2026 · sustentación 7:00 p. m. · duración 20 minutos'),br(),para('Contenido','Heading 1',True),para('Informe técnico con 20 apartados, pruebas observadas, figuras y anexos.'),br(),para('1. Portada','Heading 1',True),para('Proyecto académico de infraestructura educativa local para integrar Moodle y Laravel en Fedora mediante Docker Compose.')]: body.append(node)
        for title,text in texts: body.append(br()); body.append(para(title,'Heading 1',True)); body.append(para(text))
        body.append(br()); body.append(para('Anexo F. Evidencias visuales','Heading 1',True))
        for i,img in enumerate(imgs): body.append(para(f'Figura {i+1}. Evidencia real: {img.name}.')); body.append(image_para('rId'+str(20+i),img.name,img.read_bytes())); body.append(para('Nota. Captura suministrada desde Fedora o navegador; se conserva el estado observado.')); body.append(br())
        relroot=ET.fromstring(zin.read('word/_rels/document.xml.rels'))
        for i,img in enumerate(imgs): ET.SubElement(relroot,'{'+PRNS+'}Relationship',{'Id':'rId'+str(20+i),'Type':RNS+'/image','Target':'media/'+img.name})
        files={x.filename:zin.read(x.filename) for x in zin.infolist() if x.filename not in ('word/document.xml','word/_rels/document.xml.rels') and not x.filename.startswith('word/media/')}
        with ZipFile(output,'w',ZIP_DEFLATED) as zout:
            for name,data in files.items(): zout.writestr(name,data)
            zout.writestr('word/document.xml',ET.tostring(root,encoding='utf-8',xml_declaration=True)); zout.writestr('word/_rels/document.xml.rels',ET.tostring(relroot,encoding='utf-8',xml_declaration=True))
            for img in imgs: zout.writestr('word/media/'+img.name,img.read_bytes())
    print(output)
if __name__=='__main__': build()
