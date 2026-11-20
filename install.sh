#!/usr/bin/env bash
# Instala `tesela` en ~/.local/bin y comprueba las dependencias.
#
#   ./install.sh            instala el script y revisa dependencias
#   ./install.sh --zshrc    además añade la función `g` a ~/.zshrc (si no existe)
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
DEST="${PREFIX:-$HOME/.local/bin}"

mkdir -p "$DEST"
install -m 0755 "$DIR/tesela" "$DEST/tesela"
echo "✓ Instalado en $DEST/tesela"

check() { # comando · para qué sirve · paquete de brew
  if command -v "$1" >/dev/null 2>&1; then
    printf "  ✓ %-18s %s\n" "$1" "$2"
  else
    printf "  ✗ %-18s %s  →  brew install %s\n" "$1" "$2" "$3"
  fi
}

echo
echo "Dependencias obligatorias:"
check python3 "intérprete" python
check eza "lista de ficheros, iconos y colores" eza
echo
echo "Opcionales (cada una activa un tipo de vista previa):"
check bat "código y texto con color" bat
check pdftoppm "PDF (primera página y rueda)" poppler
check ffmpegthumbnailer "miniaturas de vídeo" ffmpegthumbnailer
check ffprobe "duración y resolución de vídeo" ffmpeg
check magick "conversión de imágenes grandes" imagemagick
check resvg "SVG" resvg
check chafa "imágenes en terminales sin protocolo gráfico" chafa

case ":$PATH:" in
  *":$DEST:"*) ;;
  *) echo; echo "⚠ $DEST no está en tu PATH. Añade esta línea a tu ~/.zshrc:"
     echo "    export PATH=\"$DEST:\$PATH\"" ;;
esac

SNIPPET="$DIR/examples/zshrc-snippet.zsh"
if [[ "${1:-}" == "--zshrc" ]]; then
  if grep -q "tesela" "$HOME/.zshrc" 2>/dev/null; then
    echo; echo "✓ ~/.zshrc ya contiene la función g (no se toca)"
  else
    { echo; cat "$SNIPPET"; } >> "$HOME/.zshrc"
    echo; echo "✓ Función g añadida a ~/.zshrc. Abre otra pestaña o ejecuta: source ~/.zshrc"
  fi
else
  echo
  echo "Para poder lanzarla con \`g\` y que la shell se quede en la carpeta al salir,"
  echo "añade el contenido de examples/zshrc-snippet.zsh a tu ~/.zshrc"
  echo "(o vuelve a ejecutar:  ./install.sh --zshrc)."
fi
