#!/usr/bin/env bash
# Instala las skills de Sublime Gracia en ~/.claude/skills
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS="$HOME/.claude/skills"
mkdir -p "$SKILLS"

# 1) Skills propias o modificadas (carpeta skills/)
for dir in "$REPO"/skills/*/; do
  name="$(basename "$dir")"
  rm -rf "${SKILLS:?}/$name"
  cp -r "$dir" "$SKILLS/$name"
  echo "Skill copiada: $name"
done

# 2) Skills externas sin cambios (externas.txt)
while read -r name url; do
  case "$name" in ''|'#'*) continue ;; esac
  if [ ! -d "$SKILLS/$name" ]; then
    git clone --depth 1 "$url" "$SKILLS/$name"
    echo "Skill descargada: $name"
  fi
done < "$REPO/externas.txt"

# 3) Dependencias de cada skill
if [ -d "$SKILLS/handdraw-skill" ]; then
  (cd "$SKILLS/handdraw-skill" \
    && npm install --no-audit --no-fund \
    && npm run build \
    && python3 -m venv .venv \
    && .venv/bin/pip install -q -r packages/audio/requirements.txt)
fi
if [ -f "$SKILLS/claude-drawing/requirements.txt" ]; then
  pip install -q -r "$SKILLS/claude-drawing/requirements.txt"
fi

# 4) Ajustes de Claude Code (navegador local para HandDraw, fuente para claude-drawing)
python3 "$REPO/ajustes.py"
echo "Listo: skills instaladas en $SKILLS"
