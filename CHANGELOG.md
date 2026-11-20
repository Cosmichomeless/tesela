# Registro de cambios

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/) y versionado [SemVer](https://semver.org/lang/es/).

## [0.1.0] — 2026-11-20

Primera versión.

### Añadido
- Vista de **mosaicos** con los iconos del sistema (NSWorkspace) y nombre en una o dos líneas.
- **Vista previa** a la derecha (60 % / 40 %): código y texto (`bat`), carpetas (`eza`), imágenes, PDF, vídeo, SVG y HEIC como imagen real con el protocolo gráfico de kitty.
- **Detalles** bajo la vista previa: tipo, tamaño, dimensiones, páginas, duración, líneas y fecha.
- **Rueda del ratón**: cambia de página en PDF (con precarga de las vecinas) y desplaza texto y código.
- Navegación con flechas en dos dimensiones; `Enter`, `Retroceso`, `Espacio` (Vista Previa), `Cmd+E` (Finder), `.` (ocultos), `Esc`/`q`.
- Al salir, la shell se queda en la última carpeta (función `g` + `--cwd-file`).
- Actualización automática cuando la carpeta cambia desde fuera.
- Cálculo de vistas previas e iconos en hilos aparte: la interfaz no se congela.
- Opciones `--help`, `--version`, `--sel`, `--page` y `--dump`.
- Instalador (`install.sh`), ejemplos de configuración, `scripts/make-demo.sh`, pruebas de humo y CI.
- Documentación en español e inglés.
