require("beautiful").init(require("gears").filesystem.get_configuration_dir() .. "theme/theme.lua")

function hovercursor(widget)
	local oldcursor, oldwibox
	widget:connect_signal("mouse::enter", function()
		local wb = mouse.current_wibox
		if wb == nil then return end
		oldcursor, oldwibox = wb.cursor, wb
		wb.cursor = "hand2"
	end)
	widget:connect_signal("mouse::leave", function()
		if oldwibox then
			oldwibox.cursor = oldcursor
			oldwibox = nil
		end
	end)
	return widget
end

require("theme.desktop")
require("theme.panel")
require("theme.title")
require("theme.notif")
require("theme.volume")
require("theme.brightness")
require("theme.menu")
require("theme.launcher")
require("theme.lock")
require("theme.config")
