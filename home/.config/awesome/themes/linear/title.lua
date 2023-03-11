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
		{
			awful.titlebar.widget.titlewidget(c), 
			left = dpi(15),
			widget = wibox.container.margin
		},
		--[[ if you want titlebar buttons!
		nil,
		{
			{
				awful.titlebar.widget.minimizebutton(c),
				awful.titlebar.widget.maximizedbutton(c),
				awful.titlebar.widget.closebutton(c),
				spacing = dpi(14),
				widget = wibox.layout.fixed.horizontal
			},
			right = dpi(14),
			top = dpi(14),
			bottom = dpi(14),
			widget = wibox.container.margin
		},
		--]]
		buttons = buttons,
        layout = wibox.layout.align.horizontal
    }
end)
