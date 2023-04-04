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
batt = "BAT0"
passwd = "awesomewm"
-- sessionlock = true
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
color = require("color.sakura")
font = "RobotoMono Bold 11"
fontalt = "RobotoMono Italic Bold 11"
fonticon = "Material Icons 16"
titlecontrols = false
panelcontrols = true
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

-- Lock
function is_restart()
	awesome.register_xproperty("is_restart", "boolean")
	local restart_detected = awesome.get_xproperty("is_restart") ~= nil
	awesome.set_xproperty("is_restart", true)
	return restart_detected
end

if sessionlock and not is_restart() then
	lock()
end
