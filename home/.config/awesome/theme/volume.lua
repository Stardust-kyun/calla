local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local volumebox = wibox {
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
					widget = colortext({ text = "Volume" })
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
	widget = live(wibox.widget.progressbar, { background_color = "bgmid", color = "fg" })
}

local timer = gears.timer {
	timeout = 2,
	single_shot = true,
	callback = function()
		volumebox.visible = false
	end
}

volumebox:setup {
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

awesome.connect_signal("signal::volume", function(volume, mute)
	if mute then
		percent.markup = markup({ text = "Mute" })
		icon.markup = markup({ text = "" })
	else
		percent.markup = markup({ text = tostring(volume) .. "%" })
		bar.value = volume
		if volume > 100 then
			icon.markup = markup({ text = "" })
		elseif volume >= 50 then
			icon.markup = markup({ text = "" })
		elseif volume >= 25 then
			icon.markup = markup({ text = "" })
		elseif volume > 0 then
			icon.markup = markup({ text = "" })
		elseif volume == 0 then
			icon.markup = markup({ text = "" })
		end
	end
end)

awesome.connect_signal("widget::volume", function()
	awesome.emit_signal("widget::brightness:hide")

	timer:again()

	if client.focus and client.focus.fullscreen == true then
		awful.placement.bottom(
			volumebox, 
			{
				margins = { 
					bottom = dpi(10), 
					right = dpi(10)
				}, 
				parent = awful.screen.focused()
			}
		)
	else
		awful.placement.bottom(
			volumebox, 
			{
				margins = { 
					bottom = dpi(60), 
					right = dpi(10)
				}, 
				parent = awful.screen.focused()
			}
		)
	end

	volumebox.visible = true
end)

awesome.connect_signal("widget::volume:hide", function() 
	volumebox.visible = false 
end)
