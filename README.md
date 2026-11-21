# Mis skills de Claude · Sublime Gracia

Skills que se instalan solas al comenzar cada sesión de Claude Code en la nube.

## Qué hay

| Skill | Para qué sirve | Origen |
|---|---|---|
| `handdraw-skill` | Videos animados estilo pizarra (MP4), con voz y música | [ToBeWin/HandDraw-Skill](https://github.com/ToBeWin/HandDraw-Skill), con ajustes propios |
| `claude-drawing` | Ilustraciones pintadas con código en 83 estilos | [cloveric/claude-drawing-skill](https://github.com/cloveric/claude-drawing-skill) |

### Ajustes hechos a HandDraw
- Usa el navegador Chromium ya instalado (variable `HANDDRAW_BROWSER`) en vez de descargar uno.
- La voz (Edge TTS) pasa por el proxy del entorno cuando existe `HTTPS_PROXY`.
- Tema de colores y fuente propia por proyecto: `project.theme` con `text`, `muted`, `accent`, `glow`, `grid`, `font` y `fontFile`.
- Color por texto: `color` en cada objeto de texto.

## Cómo se instala
```bash
bash install.sh
```
El script de inicio del entorno de Claude lo hace solo en cada sesión nueva.

## Cómo agregar una skill nueva
- **Sin cambios:** sumar una línea a `externas.txt` con `nombre  link-del-repositorio`.
- **Con cambios propios:** copiar la carpeta de la skill dentro de `skills/`.
- Si necesita programas, agregar su instalación en el paso 3 de `install.sh`.
