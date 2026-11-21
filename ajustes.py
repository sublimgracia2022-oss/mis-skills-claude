"""Agrega a ~/.claude/settings.json las variables que necesitan las skills."""
import glob, json, os

path = os.path.expanduser("~/.claude/settings.json")
data = json.load(open(path)) if os.path.exists(path) else {}
env = data.setdefault("env", {})

browsers = sorted(glob.glob("/opt/pw-browsers/chromium_headless_shell-*/chrome-headless-shell-linux64/chrome-headless-shell"))
if browsers:
    env["HANDDRAW_BROWSER"] = browsers[-1]

font = "/usr/share/fonts/truetype/wqy/wqy-zenhei.ttc"
if os.path.exists(font):
    env["INKPAINT_FONT"] = font

os.makedirs(os.path.dirname(path), exist_ok=True)
json.dump(data, open(path, "w"), indent=2)
print("Ajustes guardados:", ", ".join(env) or "ninguno")
