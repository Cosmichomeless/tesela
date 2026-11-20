# Contribuir a tesela · Contributing

¡Gracias por querer ayudar! / Thanks for wanting to help! Se aceptan incidencias y PR en español o en inglés · Issues and PRs are welcome in Spanish or English.

## Antes de empezar

- Abre una **incidencia** si vas a hacer un cambio grande, para ponernos de acuerdo en el enfoque.
- El proyecto es **un solo fichero** (`tesela`, Python 3 sin dependencias de pip) y quiere seguir siéndolo. Las herramientas externas (`eza`, `bat`, `pdftoppm`…) se llaman como subprocesos y siempre son opcionales salvo `eza`.
- Solo macOS por ahora; si añades soporte para otra plataforma, que no rompa macOS.

## Cómo probar tus cambios

```sh
python3 -m py_compile tesela        # compila
bash tests/smoke.sh                 # pruebas de humo (necesita eza y bat)
scripts/make-demo.sh                # crea ~/tesela-demo para probar a mano
./tesela ~/tesela-demo              # (en Ghostty, para ver las imágenes reales)
```

Trucos útiles al desarrollar:

- `--dump=ANCHOxALTO` imprime **un fotograma de texto** sin abrir la interfaz: ideal para pruebas.
- `--sel=N` y `--page=N` abren con un elemento o página ya seleccionados: ideal para capturas.
- Para probar teclas sin una terminal real se puede usar `script` con una tubería (mira `tests/smoke.sh` como punto de partida).

## Estilo

- Español en mensajes de usuario, comentarios y documentación (el README tiene versión en inglés: si cambias uno, actualiza el otro).
- Funciones pequeñas, sin dependencias nuevas, y los cálculos pesados **siempre fuera del hilo principal** (hay un hilo para vistas previas y otro para iconos) para que la interfaz no se congele.
- Las órdenes del protocolo gráfico llevan siempre `q=2`: si no, la terminal contesta y ensucia la entrada.
- Los argumentos de subprocesos van en **lista**, nunca con `shell=True`: los nombres de fichero no son de fiar.

## Pull requests

1. Rama desde `main`, un cambio por PR.
2. `bash tests/smoke.sh` en verde.
3. Si cambia lo que se ve, adjunta una captura (puedes usar `scripts/make-demo.sh`).
4. Actualiza `README.md` / `README.en.md` y `CHANGELOG.md` si procede.

## Ideas bienvenidas

Mira la **hoja de ruta** del README: crear/renombrar/borrar desde la herramienta, tamaño de mosaico con teclas, búsqueda por nombre y soporte para Linux.
