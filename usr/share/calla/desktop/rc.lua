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
--	Port Xresources live reloading to lua
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
--
--	General:
--	Desktop get grid function does not account for spacing
--	Icon theme is not refreshed with live reload
--	fprintd-verify does not work after suspend (issue #173)
--	There appears to be some kind of issue with resource allocation,
--	as things become progressively slower over time
--	(likely culprits: launcher, preview, settings?)
--
--	Unknown Bugs:
--	Many
--]]

local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

-- Errors

naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification {
		urgency = "critical",
		title   = "Error"..(startup and " during startup!" or "!"),
		message = message
	}
end)

-- Json

function readjson(path)
	local r = assert(io.open(path, "r"))
	local table = r:read("*all")
	r:close()
	table = require("json"):decode(table)
	return table
end

function writejson(path, table)
	local w = assert(io.open(path, "w"))
	w:write(require("json"):encode_pretty(table, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true}))
	w:close()
end

local name = gears.filesystem.get_cache_dir() .. "user.json"

local defaults = {
	batt = "BAT0",
	color = "light",
	font = "Roboto Medium 11",
	fontalt = "Roboto Bold 11",
	fonticon = "Material Icons 13",
	mod = "Mod4",
	passwd = "awesomewm",
	reboot = "systemctl reboot",
	sessionlock = true,
	shotdir = "~/Pictures/Screenshots",
	shutdown = "systemctl poweroff",
	terminal = "st"
}

if not gears.filesystem.file_readable(name) then
	writejson(name, defaults)
end

user = readjson(name)

-- Config

require("awful.autofocus")
require("signal")
require("config")
require("theme")
require("color.desktop")

-- Startup

local autostart = {
	"picom -b --config '/usr/share/calla/compositor.conf'",
	--"gebaard -b",
	"xsettingsd --config '/usr/share/calla/xsettingsd'",
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
		awful.spawn.easy_async({ 'pkill', '--full', '--uid', os.getenv('USER'), '^' .. command }, function()
			awful.spawn.easy_async_with_shell(command, function() end) -- func needed to avoid callback error
		end)
	end
	if user.sessionlock then
		awesome.emit_signal("widget::lockscreen")
	end
end

-- Theme Init

awesome.emit_signal("live::reload")
