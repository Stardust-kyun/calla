--[[ 
--	TODO
--
--	Features:
--	Media widget
--	Notification center
--	Alt+tab menu
--
--	Settings:
--	Add modkey/sessionlock to settings
--	Add fingerprint enroll to settings
--	User defined tags
--	User defined rounding (yes/no)
--	Create Gtk theme from color json
--	Import theme (Xresources?)
--
--	Design:
--	Redesign preview to look more like macos
--	Redesign launcher to include more
--	Hover cursor on titlebar buttons
--	Hover background?
--	Completely redesign settings app
--
--	Refactoring:
--	Port Xresources live reloading to lua?
--	Define cropped wallpaper in theme init?
--	Add fallback methods to dock executable
--	Create json functions
--
--	Long Term:
--	Better multihead support
--	Create deb package (other distros?)
--]]

--[[
--	Known Bugs
--
--	Multihead:
--	Location of lockscreen promptbox depends on focused screen at startup,
--	doesn't appear if laptop screen focused
--	Systray opens/closes for both screens, one is redundant
--	Awful.wallpaper uses wrong dimensions when new screen is connected
--	(Untested) Lockscreen appears to not add background widgets to
--	new screen when connected
--	Icon theme is not refreshed with live reload
--
--	General:
--	Desktop get grid function does not account for spacing
--	fprintd-verify does not work after suspend (issue #173)
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

-- Startup

local autostart = {
	"picom -b",
	--"gebaard -b",
	"xsettingsd",
	"nm-applet",
	"/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1"
}

local function restarted()
	awesome.register_xproperty("restarted", "boolean")
	local detected = awesome.get_xproperty("restarted") ~= nil
	awesome.set_xproperty("restarted", true)
	return detected
end

if not restarted() then
	for _, command in ipairs(autostart) do
		require("awful").spawn.easy_async({ 'pkill', '--full', '--uid', os.getenv('USER'), '^' .. command }, function()
			require("awful").spawn.easy_async_with_shell(command, function() end) -- func needed to avoid callback error
		end)
	end
	if user.sessionlock then
		awesome.emit_signal("widget::lockscreen")
	end
end

-- Theme Init

awesome.emit_signal("live::reload")
