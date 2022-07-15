c = {}

c.terminal = "st"
c.browser = "librewolf"
c.files = "nautilus"
c.editor = os.getenv("EDITOR") or "vim"
c.editor_cmd = c.terminal .. " -e " .. c.editor
c.modkey = "Mod1"

require("config.main")
require("config.bind")
require("config.rule")
require("config.menu")
