-- Unmuting audio before the volume signal is emitted will fix errors on startup.
require("awful").spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ 0")

-- Define defaults
c = {}

c.terminal = "st"
c.browser = "librewolf"
c.files = "nautilus"
c.editor = os.getenv("EDITOR") or "vim"
c.editor_cmd = c.terminal .. " -e " .. c.editor
c.modkey = "Mod1"


require("awful.autofocus")
require("themes.linear")
require("config")
require("signals")
