local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

-- Add titlebar
client.connect_signal("request::titlebars", function(c)
    -- Mouse
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    awful.titlebar(c, { size = dpi(40) } ).widget = {
        { -- Left
			{
				awful.titlebar.widget.titlewidget(c), 
				left = dpi(15),
				widget = wibox.container.margin
			},
            layout  = wibox.layout.fixed.horizontal
        },
		buttons = buttons,
        layout = wibox.layout.align.horizontal
    }
end)
