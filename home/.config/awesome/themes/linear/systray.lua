local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local systrayDisplay = wibox {
	width = dpi(150),
	height = dpi(150),
	bg = beautiful.bg_normal,
	ontop = true,
	visible = false,
	shape = function(cr, width, height)
		gears.shape.rectangle(cr, width, height)
	end
}

local header = wibox.widget {
	text = "Systray",
	valign = "center",
	widget = wibox.widget.textbox
}

systrayDisplay:setup {
	{
		{
			{
				{
					header,
					forced_width = dpi(150),
					layout = wibox.layout.align.horizontal
				},
				left = dpi(15),
				right = dpi(15),
				top = dpi(10),
				bottom = dpi(10),
				widget = wibox.container.margin
			},
			bg = beautiful.bg_focus,
			widget = wibox.container.background
		},
		nil,
		{
			{
				widget = wibox.widget.systray,
				base_size = dpi(25),
				horizontal = false
			},
			top = dpi(20),
			bottom = dpi(20),
			left = dpi(20),
			right = dpi(20),
			widget = wibox.container.margin
		},
		layout = wibox.layout.align.vertical
	},
	valign = "top",
	layout = wibox.container.place
}

awesome.connect_signal("widget::systray", function()
	systrayDisplay.visible = not systrayDisplay.visible

	awful.placement.bottom_right(
		systrayDisplay,
		{
			margins = {
				bottom = dpi(65),
				right = dpi(150)
			},
			parent = awful.screen.focused()
		}
	)
end)
