-- Errors
require("naughty").connect_signal("request::display_error", function(message, startup)
    require("naughty").notification {
        urgency = "critical",
        title   = "Error "..(startup and " during startup!" or "!"),
        message = message
    }
end)

-- User Config
-- Modkey --------------------------------------------------------------------------
modkey = "Mod4"
-- Apps ----------------------------------------------------------------------------
terminal = "tym"
browser = "librewolf"
files = "nemo"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor
-- Commands ------------------------------------------------------------------------
shutdown = "systemctl poweroff"
reboot = "systemctl reboot"
-- Themes --------------------------------------------------------------------------
color = require("themes.colors.sakura")
-- wallpaper = os.getenv("HOME") .. "/Pictures/Wallpaper/Plane.jpg"
-- Screenshots ---------------------------------------------------------------------
shotdir = "~/Pictures/Screenshots/"

-- Config
require("awful.autofocus")
require("signals")
require("themes.linear")
require("config")
