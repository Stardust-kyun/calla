local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local brightnessbox = wibox {
	width = dpi(200),
	height = dpi(85),
	ontop = true,
	visible = false
}

local percent = colortext()

local header = wibox.widget {
	{
		{
			{
				{
					valign = "center",
					widget = colortext({ text = "Brightness" })
				},
				nil,
				percent,
				layout = wibox.layout.align.horizontal,
			},
			top = dpi(5),
			bottom = dpi(5),
			left = dpi(10),
			right = dpi(10),
			widget = wibox.container.margin
		},
		shape = function(cr, width, height)
					gears.shape.rounded_rect(cr, width, height, dpi(10))
				end,
		widget = live(wibox.container.background, { bg = "bgmid" })
	},
	margins = dpi(5),
	widget = wibox.container.margin
}

local icon = wibox.widget {
	font = user.fonticon,
	valign = "center",
	widget = colortext()
}

local bar = wibox.widget {
	shape = gears.shape.rounded_rect,
	bar_shape = gears.shape.rounded_rect,
	max_value = 100,
	value = 0,
	widget = live(wibox.widget.progressbar, { background_color = "bgalt", color = "fg" })
}

local timer = gears.timer {
	timeout = 2,
	single_shot = true,
	callback = function()
		brightnessbox.visible = false
	end
}

brightnessbox:setup {
	{
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
					top = dpi(20),
					bottom = dpi(20),
					widget = wibox.container.margin
				},
				layout = wibox.layout.align.horizontal
			},
			left = dpi(15),
			right = dpi(15),
			widget = wibox.container.margin
		},
		layout = wibox.layout.align.vertical
	},
	widget = live(wibox.container.background, { bg = "bg" })
}

awesome.connect_signal("signal::brightness", function(brightness)
	percent.markup = markup({ text = tostring(brightness) .. "%" })
	bar.value = brightness
	if brightness >= 75 then
		icon.markup = markup({ text = "" })
	elseif brightness >= 50 then
		icon.markup = markup({ text = "" })
	elseif brightness >= 25 then
		icon.markup = markup({ text = "" })
	elseif brightness > 0 then
		icon.markup = markup({ text = "" })
	elseif brightness == 0 then
		icon.markup = markup({ text = "" })
	end
end)

awesome.connect_signal("widget::brightness", function()
	awesome.emit_signal("widget::volume:hide")

	timer:again()

	if client.focus and client.focus.fullscreen == true then
		awful.placement.bottom(
			brightnessbox, 
			{
				margins = { 
					bottom = dpi(16), 
					right = dpi(16)
				}, 
				parent = awful.screen.focused()
			}
		)
	else
		awful.placement.bottom(
			brightnessbox, 
			{
				margins = { 
					bottom = dpi(72), 
					right = dpi(16)
				}, 
				parent = awful.screen.focused()
			}
		)
	end

	brightnessbox.visible = true
end)

awesome.connect_signal("widget::brightness:hide", function() 
	brightnessbox.visible = false 
end)
