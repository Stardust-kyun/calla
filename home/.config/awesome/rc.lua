--[[ 
--	TODO:
--	Features:
--	Add modkey/sessionlock to settings
--	User defined tags
--	User defined rounding (yes/no)
--	Create Gtk theme from color json
--	Import theme (Xresources?)
--	User defined widget position
--	Desktop icons
--	Media widget
--	Notification center
--	Alt+tab menu
--
--	Refactoring:
--	Rewrite preview to look more like macos
--	-- Full tag with awful.screenshot?
--	Port Xresources live reloading to lua?
--	Define cropped wallpaper in theme init?
--	Do something about the dock's fixed width
--
--	Long Term:
--	Better multihead support
--	Create deb package (other distros?)
--]]

--[[
--	Known Bugs:
--	Multihead:
--	Location of lockscreen promptbox depends on focused screen at startup,
--	doesn't appear if laptop screen focused
--	Systray opens/closes for both screens, one is redundant
--	Awful.wallpaper uses wrong dimensions when new screen is connected
--	(Untested) Lockscreen appears to not add background widgets to
--	new screen when connected
--
--	General:
--	Launcher fg when typing does not update after live reload
--
--	There appears to be some kind of issue with resource allocation,
--	as things become progressively slower over time
--	(likely culprits: launcher, preview, settings?)
--
--	Unknown Bugs:
--	Many
--]]

-- Errors

require("naughty").connect_signal("request::display_error", function(message, startup)
	require("naughty").notification {
		urgency = "critical",
		title   = "Error"..(startup and " during startup!" or "!"),
		message = message
	}
end)

-- User

local r = assert(io.open(".config/awesome/json/user.json", "r"))
local table = r:read("*all")
r:close()

user = require("json"):decode(table)

-- Config

require("awful.autofocus")
require("signal")
require("config")
require("theme")
require("color.desktop")

-- Autostart

local autostart = {
	"picom",
	"xsettingsd",
	"nm-applet",
	"/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1"
}

for _, command in ipairs(autostart) do
	require("awful").spawn.easy_async_with_shell(command)
end

-- Theme Init

awesome.emit_signal("live::reload")
