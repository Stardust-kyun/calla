-- Errors
require("naughty").connect_signal("request::display_error", function(message, startup)
    require("naughty").notification {
        urgency = "critical",
        title   = "Error "..(startup and " during startup!" or "!"),
        message = message
    }
end)

---- User Config
---- General -----------------------------------------------------------------
modkey = "Mod4"
passwd = "awesomewm"
---- Apps --------------------------------------------------------------------
terminal = "tym"
browser = "librewolf"
files = "nemo"
editor = "vim"
editorcmd = terminal .. " -e  \"" .. editor .. "\""
config = terminal .. " -e \"" .. editor .. " " .. require("gears").filesystem.get_configuration_dir() .. "\""
---- Commands ----------------------------------------------------------------
lock = "awesome-client command 'lock()'"
suspend = "awesome-client command 'lock()' && systemctl suspend"
exit = "awesome-client command 'awesome.quit()'"
shutdown = "systemctl poweroff"
reboot = "systemctl reboot"
---- Themes ------------------------------------------------------------------
font = "RobotoMono Bold 11"
fontalt = "RobotoMono Italic Bold 11"
fonticon = "Material Icons 16"
color = require("color.sakura")
-- wallpaper = os.getenv("HOME") .. "/Pictures/Wallpaper/Fog.png"
---- Screenshots -------------------------------------------------------------
shotdir = "~/Pictures/Screenshots/"

-- Config
require("awful.autofocus")
require("signal")
require("theme")
require("config")

-- Autostart
require("awful").spawn.with_shell("~/.config/awesome/autostart")
