#!/usr/bin/env python3
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED

src = Path('/root/.codex/attachments/c223fe83-2dca-42e0-a19f-866672bca3cb/San-Luquitas-Digital-Sustentacion.pptx')
dst = Path('San-Luquitas-Digital-Sustentacion-Abraham-Caceres-Salazar.pptx')
replacements = {
    'Abraham Cáceres  ·  U00174922': 'Abraham Caceres Salazar',
    'Abraham Cáceres  ·  U00174922 Profesor: pendiente': 'Abraham Caceres Salazar · Profesor: Yamid Gabriel Gamba González',
    'Abraham Cáceres': 'Abraham Caceres Salazar',
    'Infraestructura de Datos  ·  Profesor: pendiente': 'Infraestructura de Redes y Tecnológica · Profesor: Yamid Gabriel Gamba González',
    'Infraestructura de Datos': 'Infraestructura de Redes y Tecnológica',
    'FEDORA SERVER 44': 'FEDORA 44 · Docker 29.10.0 · Compose v5.8.0',
    'E03': 'E03 VALIDADO',
    'Pegar aquí una captura real del sitio, curso o actividad validada.': 'CLI: 3 unidades, 3 páginas, 2 foros, 1 tarea, docente y 3 estudiantes ficticios. Capturas E03-01/E03-02/E03-03.',
    'E07': 'E07 VALIDADO',
    'Captura real de la operación validada': 'POST y GET de novedad comprobados. Captura E07-01.',
    'PENDIENTE': 'E10 BLOQUEADO',
    'Reemplazar por la captura E10 de estado final cuando la ejecución esté validada.': 'VBoxManage no disponible en Fedora; exportar OVA desde PowerShell/VirtualBox del host.',
    'Profesor: pendiente': 'Profesor: Yamid Gabriel Gamba González',
    'Contenido y roles se declaran solo después de validarlos': 'La captura web complementa el log CLI.',
    'Los estados deben ser VALIDADO, E10 BLOQUEADO o BLOQUEADO': 'Los estados deben ser VALIDADO, PENDIENTE o BLOQUEADO',
    '11 · SUSTENTACIÓN Resultado y cierre': '11 · SUSTENTACIÓN Resultado y cierre · 19/11/2026 · 7:00 p. m. · 20 minutos',
}

with ZipFile(src) as zin, ZipFile(dst, 'w', ZIP_DEFLATED) as zout:
    for item in zin.infolist():
        data = zin.read(item.filename)
        if item.filename.startswith('ppt/slides/slide') and item.filename.endswith('.xml'):
            text = data.decode('utf-8')
            for old, new in replacements.items():
                text = text.replace(old, new)
            data = text.encode('utf-8')
        zout.writestr(item, data)
print(dst)
