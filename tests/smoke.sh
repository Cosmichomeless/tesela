#!/usr/bin/env bash
# Pruebas de humo: no necesitan terminal gráfica (usan --dump). Requiere eza (y bat para la vista previa de código).
set -euo pipefail
cd "$(dirname "$0")/.."
T=./tesela
strip() { perl -pe 's/\e\[[0-9;?]*[a-zA-Z]//g'; }
fail() { echo "✗ $1"; exit 1; }
ok()   { echo "✓ $1"; }

[[ "$($T --version)" == tesela\ * ]] || fail "--version"; ok "--version"
$T --help | grep -q "Uso:" || fail "--help"; ok "--help"

D="$(mktemp -d)"; trap 'rm -rf "$D"' EXIT
mkdir -p "$D/carpeta"; echo hola > "$D/a.txt"; printf 'print("hola")\n' > "$D/b.py"

OUT="$($T --dump=100x24 "$D" | strip)"
grep -q "carpeta" <<<"$OUT" || fail "lista la carpeta"; ok "lista las carpetas"
grep -q "a.txt"  <<<"$OUT" || fail "lista ficheros";  ok "lista los ficheros"

# elemento 2 = b.py: la vista previa muestra su contenido y los detalles
OUT="$($T --dump=100x24 --sel=2 "$D" | strip)"
grep -q 'print' <<<"$OUT" || fail "vista previa de código"; ok "vista previa de código"
grep -q 'Líneas' <<<"$OUT" || fail "detalles del fichero"; ok "detalles del fichero"

# ventana estrecha: sin vista previa, pero sin romper
$T --dump=50x20 "$D" >/dev/null || fail "ventana estrecha"; ok "ventana estrecha"

# errores claros
if $T /ruta/que/no/existe 2>/dev/null; then fail "carpeta inexistente debe fallar"; fi; ok "carpeta inexistente falla"
if $T "$D" </dev/null 2>/dev/null; then fail "sin terminal debe fallar"; fi; ok "sin terminal falla con mensaje"

echo "Todo correcto"
