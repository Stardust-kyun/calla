local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local brightnessDisplay = wibox {
	width = dpi(200),
	height = dpi(100),
	bg = beautiful.bg_normal,
	ontop = true,
	visible = false,
	shape = function(cr, width, height)
		gears.shape.rectangle(cr, width, height)
	end
}

local header = wibox.widget {
	text = "Brightness",
	valign = "center",
	widget = wibox.widget.textbox
}

local percent = wibox.widget {
	widget = wibox.widget.textbox
}

local icon = wibox.widget {
	font = "Material Icons 16",
	valign = "center",
	widget = wibox.widget.textbox
}

local slider = wibox.widget 
{
	bar_shape = gears.shape.rounded_rect,
	bar_height = dpi(5),
	bar_color = beautiful.bg_focus,
	bar_active_color = beautiful.fg_normal,
	handle_color = beautiful.fg_normal,
	handle_shape = gears.shape.circle,
	handle_width = dpi(10),
	handle_border_width = dpi(0),
	handle_border_color = beautiful.bg_normal,
	maximum = 100,
	widget = wibox.widget.slider
}

local displayTimer = gears.timer {
	timeout = 2,
	single_shot = true,
	callback = function()
		brightnessDisplay.visible = false
	end
}

brightnessDisplay:setup {
	{
		{
			{
				{
					header,
					nil,
					percent,
					layout = wibox.layout.align.horizontal,
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
		{
			{
				{
					icon,
					right = dpi(15),
					widget = wibox.container.margin
				},
				nil,
				slider,
				layout = wibox.layout.align.horizontal
			},
			left = dpi(15),
			right = dpi(15),
			widget = wibox.container.margin
		},
		layout = wibox.layout.align.vertical
	},
	layout = wibox.container.place
}

awesome.connect_signal("signal::brightness", function(brightness)
	percent.text = tostring(brightness) .. "%"
	slider.value = brightness
	if brightness >= 75 then
		icon.text = ""
	elseif brightness >= 50 then
		icon.text = ""
	elseif brightness >= 25 then
		icon.text = ""
	elseif brightness > 0 then
		icon.text = ""
	elseif brightness == 0 then
		icon.text = ""
	end
end)

awesome.connect_signal("widget::brightness", function()
	awesome.emit_signal("widget::volume:hide")

	displayTimer:again()

	if client.focus and client.focus.fullscreen == true then
		awful.placement.bottom_right(
			brightnessDisplay, 
			{
				margins = { 
					bottom = dpi(10), 
					right = dpi(10)
				}, 
				parent = awful.screen.focused()
			}
		)
	else
		awful.placement.bottom_right(
			brightnessDisplay, 
			{
				margins = { 
					bottom = dpi(60), 
					right = dpi(10)
				}, 
				parent = awful.screen.focused()
			}
		)
	end

	brightnessDisplay.visible = true
end)

awesome.connect_signal("widget::brightness:hide", function() brightnessDisplay.visible = false end)
