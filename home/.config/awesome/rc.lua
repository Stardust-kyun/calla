-- Running pactl before the volume signal is emitted should fix errors on startup.
require("awful").spawn.with_shell("pactl stat")

-- Define defaults
c = {}

c.terminal = "st"
c.browser = "librewolf"
c.files = "nemo"
c.editor = "vim"
c.editor_cmd = c.terminal .. " -e " .. c.editor
c.shutdown = "shutdown now"
c.reboot = "reboot"
c.modkey = "Mod4"

-- Config
require("awful.autofocus")
require("themes.linear")
require("config")
require("signals")
