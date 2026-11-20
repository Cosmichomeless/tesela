# Política de seguridad · Security policy

## Alcance

`tesela` es de **solo lectura**: lista, previsualiza y abre ficheros; no escribe en tus carpetas. Aun así, para previsualizar ejecuta herramientas externas (`eza`, `bat`, `pdftoppm`, `pdfinfo`, `ffmpegthumbnailer`, `ffprobe`, `sips`, `magick`, `resvg`, `osascript`) sobre los ficheros de la carpeta que exploras.

Por eso:

- Los argumentos de los subprocesos se pasan **como lista**, nunca por `shell=True`, de modo que un nombre de fichero malicioso no se interpreta como comando.
- Previsualizar un fichero **no confiable** depende de la seguridad de esos decodificadores (PDF, imágenes, vídeo). Mantén esas herramientas actualizadas (`brew upgrade`).
- Los iconos se generan con un pequeño script JXA propio que solo llama a `NSWorkspace.iconForFile`.

## Cómo informar de una vulnerabilidad

Por favor **no abras una incidencia pública** para una vulnerabilidad. Usa la pestaña **Security → Report a vulnerability** del repositorio (informe privado de GitHub). Intentaré responder en unos días.

## Versiones con soporte

Solo la última versión publicada.
