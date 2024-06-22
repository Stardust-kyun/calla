--[[ 
--	TODO:
--	User defined tags
--	Define cropped wallpaper in theme init?
--  Better multihead support
--  Import theme (Xresources?)
--  Add Xresources live reloading
--  Create Gtk theme from color json
--  Create deb package (others?)
--]]

--[[
--	Known Bugs:
--1	Location of lockscreen promptbox depends on focused screen at startup,
--	doesn't appear if laptop screen focused
--2	Systray opens/closes for both screens, one is redundant
--3	Awful.wallpaper uses wrong dimensions when new screen is connected
--4 (Untested) Lockscreen appears to not add background widgets to
--	new screen when connected
--5	Launcher fg when typing does not update after live reload
--6	Sometimes live reloading will prevent interaction with floating
--	windows as they can only be moved
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
