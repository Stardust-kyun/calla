local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local ruled = require("ruled")
local naughty = require("naughty")
local gears = require("gears")

-- Put new windows in stack
client.connect_signal('manage', function(c)
	if not awesome.startup then awful.client.setslave(c) end
	if awesome.startup and not c.size_hints.user_position
	and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
		end
	end)

-- Wallpaper
screen.connect_signal("request::wallpaper", function(s)
	-- gears.wallpaper is DEPRECATED, but maximized wallpapers
	-- are not functional in awful.wallpaper yet.
	gears.wallpaper.maximized(beautiful.wallpaper, s)

	--[[ old, stretched wallpaper
    awful.wallpaper {
        screen = s,
        widget = {
			horizontal_fit_policy = "fit",
			vertical_fit_policy = "fit",
    	    image     = beautiful.wallpaper,
  	    	widget    = wibox.widget.imagebox,
        }
    }
	--]]
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
			awful.layout.suit.max,
    	})
	end)

    awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])
end)

-- Autostart
awful.spawn.with_shell("~/.config/awesome/autostart")
