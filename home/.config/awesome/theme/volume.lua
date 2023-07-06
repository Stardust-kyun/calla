local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local volumedisplay = wibox {
	width = dpi(200),
	height = dpi(100),
	bg = beautiful.bg_normal,
	ontop = true,
	visible = false
}

local percent = wibox.widget {
	widget = wibox.widget.textbox
}

local header = wibox.widget {
		{
			{
				{
					text = "Volume",
					valign = "center",
					widget = wibox.widget.textbox
				},
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
}

local icon = wibox.widget {
	font = user.fonticon,
	valign = "center",
	widget = wibox.widget.textbox
}

local bar = wibox.widget {
	shape = gears.shape.rounded_rect,
	bar_shape = gears.shape.rounded_rect,
	color = beautiful.fg_normal,
	background_color = beautiful.bg_focus,
	max_value = 100,
	value = 0,
	widget = wibox.widget.progressbar
}

local timer = gears.timer {
	timeout = 2,
	single_shot = true,
	callback = function()
		volumedisplay.visible = false
	end
}

volumedisplay:setup {
	header,
	{
		{
			{
				icon,
				right = dpi(15),
				widget = wibox.container.margin
			},
			nil,
			{
				bar,
				top = dpi(27),
				bottom = dpi(27),
				widget = wibox.container.margin
			},
			layout = wibox.layout.align.horizontal
		},
		left = dpi(15),
		right = dpi(15),
		widget = wibox.container.margin
	},
	layout = wibox.layout.align.vertical
}

awesome.connect_signal("signal::volume", function(volume, mute)
	if mute then
		percent.text = "Mute"
		icon.text = ""
	else
		percent.text = tostring(volume) .. "%"
		bar.value = volume
		if volume > 100 then
			icon.text = ""
		elseif volume >= 50 then
			icon.text = ""
		elseif volume >= 25 then
			icon.text = ""
		elseif volume > 0 then
			icon.text = ""
		elseif volume == 0 then
			icon.text = ""
		end
	end
end)

awesome.connect_signal("widget::volume", function()
	awesome.emit_signal("widget::brightness:hide")

	timer:again()

	if client.focus and client.focus.fullscreen == true then
		awful.placement.bottom_right(
			volumedisplay, 
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
			volumedisplay, 
			{
				margins = { 
					bottom = dpi(60), 
					right = dpi(10)
				}, 
				parent = awful.screen.focused()
			}
		)
	end

	volumedisplay.visible = true
end)

awesome.connect_signal("widget::volume:hide", function() 
	volumedisplay.visible = false 
end)
