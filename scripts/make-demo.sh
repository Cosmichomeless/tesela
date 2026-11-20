#!/usr/bin/env bash
# Crea una carpeta de demostración con ficheros de ejemplo (para probar y para hacer capturas).
#   scripts/make-demo.sh [carpeta]     (por defecto ~/tesela-demo)
# Necesita: imagemagick, ffmpeg y cupsfilter (viene con macOS).
set -euo pipefail
D="${1:-$HOME/tesela-demo}"
rm -rf "$D"; mkdir -p "$D"/{Documentos,Fotos,Proyectos,Música,Descargas,Escritorio}
cd "$D"

magick -size 1600x1000 plasma:'#ff9e64-#2a1a3a' -blur 0x6 paisaje.jpg
magick -size 1200x800 gradient:'#7aa2f7-#1d1612' -swirl 120 aurora.png
magick -size 900x900 radial-gradient:'#ffd7a8-#ff7a3d' logo.png

python3 - "$D" <<'EOF'
import sys
t = "INFORME ANUAL 2026\n\n" + "".join(
    f"{i:03d}. La cuadrícula permite navegar por carpetas con iconos grandes y vista previa.\n"
    for i in range(1, 150))
open(sys.argv[1] + "/informe.txt", "w").write(t)
EOF
cupsfilter -m application/pdf informe.txt > informe-anual.pdf 2>/dev/null
rm informe.txt

cat > servidor.py <<'EOF'
"""Servidor mínimo de ejemplo."""
from http.server import HTTPServer, SimpleHTTPRequestHandler


class Manejador(SimpleHTTPRequestHandler):
    def do_GET(self):
        print(f"GET {self.path}")
        super().do_GET()


if __name__ == "__main__":
    HTTPServer(("127.0.0.1", 8000), Manejador).serve_forever()
EOF
printf '# Notas\n\n- Revisar el diseño\n- Enviar el informe\n- Preparar la demo\n' > notas.md
printf 'nombre: demo\nversion: 1.0\nopciones:\n  tema: warm-ember\n  iconos: true\n' > config.yml
ffmpeg -loglevel quiet -f lavfi -i testsrc2=duration=12:size=1280x720:rate=15 -pix_fmt yuv420p presentacion.mp4
echo x > a.txt; zip -q copia-seguridad.zip a.txt; rm a.txt
echo hola > Documentos/contrato.txt; echo x > Fotos/vacaciones.jpg; echo x > Proyectos/web.html

echo "✓ Demo creada en $D"
echo "  Pruébala con:  tesela \"$D\"      (o  g \"$D\")"
