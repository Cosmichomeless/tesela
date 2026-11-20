# ---------- g: navegador de carpetas en cuadrícula (tesela) ----------
# Al salir (Esc o q) la shell se queda en la última carpeta, como un `cd`.
function g() {
  local tmp="$(mktemp -t "g-cwd.XXXXXX")" cwd
  tesela "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# Opcional: tema de colores de eza (en macOS eza no busca en ~/.config/eza por defecto).
# Copia examples/eza-theme.yml a ~/.config/eza/theme.yml para tener la paleta cálida.
export EZA_CONFIG_DIR="$HOME/.config/eza"
