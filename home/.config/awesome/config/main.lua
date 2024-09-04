local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

-- Manage new windows

client.connect_signal('manage', function(c)

	-- Put new windows in stack

	if not awesome.startup then awful.client.setslave(c) end
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end

	-- Default icon

	local cairo = require("lgi").cairo
	local defaulticon = "/usr/share/icons/" .. beautiful.icons .. "/64x64/apps/application-default-icon.svg"
	if c and c.valid and not c.icon then
		local s = gears.surface(defaulticon)
		local img = cairo.ImageSurface.create(cairo.Format.ARGB32, s:get_width(), s:get_height())
		local cr = cairo.Context(img)
		cr:set_source_surface(s, 0, 0)
		cr:paint()
		c.icon = img._native
	end

end)

-- Sloppy focus

client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)

-- Layouts and tag table

screen.connect_signal("request::desktop_decoration", function(s)
	tag.connect_signal("request::default_layouts", function()
    	awful.layout.append_default_layouts({
			awful.layout.suit.tile,
			awful.layout.suit.floating,
    	})
	end)

    awful.tag({ "1", "2", "3" }, s, awful.layout.layouts[1])
end)

-- Touchpad gestures

awesome.connect_signal("touchpad::gesture", function(direction)
	require("naughty").notification{text="test"}
	if direction == "left" then
		awful.tag.viewprev()
	elseif direction == "right" then
		awful.tag.viewnext()
	elseif direction == "up" then
		awesome.emit_signal("widget::preview")
	elseif direction == "down" then
		awesome.emit_signal("widget::preview:hide")
	end
end)
