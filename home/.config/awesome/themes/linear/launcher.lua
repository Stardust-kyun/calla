local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local launcherDisplay = wibox {
	width = dpi(200),
	height = dpi(235),
	bg = beautiful.bg_normal,
	ontop = true,
	visible = false,
	shape = function(cr, width, height)
		gears.shape.rectangle(cr, width, height)
	end
}

local header = wibox.widget {
	text = "Welcome",
	valign = "center",
	widget = wibox.widget.textbox
}

local batteryicon = wibox.widget {
	text = "",
	font = "Material Icons 16",
	valign = "center",
	widget = wibox.widget.textbox
}

local batteryslider = wibox.widget {
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

local volumeicon = wibox.widget {
	font = "Material Icons 16",
	valign = "center",
	widget = wibox.widget.textbox
}

local volumeslider = wibox.widget {
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

local brightnessicon = wibox.widget {
	font = "Material Icons 15",
	valign = "center",
	widget = wibox.widget.textbox
}

local brightnessslider = wibox.widget {
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

local textbutton = function(args)
	local text = args.text
	local size = args.size or dpi(10)
	local onclick = args.onclick or function() end
	
	local result = wibox.widget {
		{
			text = text,
			font = "Material Icons " .. size,
			forced_height = dpi(45),
			forced_width = dpi(45),
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox
		},
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	}

	result:connect_signal("button::press", function() 
			awesome.emit_signal("widget::launcher")
			awful.spawn.with_shell(onclick) 
	end)

	return result
end

launcherDisplay:setup {
	{
		{
			{
				{
					header,
					forced_width = dpi(200),
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
					{
						batteryicon,
						right = dpi(15),
						widget = wibox.container.margin
					},
					nil,
					batteryslider,
					forced_height = dpi(55),
					layout = wibox.layout.align.horizontal
				},
				left = dpi(20),
				right = dpi(20),
				widget = wibox.container.margin
			},
			{
				{
					{
						volumeicon,
						right = dpi(15),
						widget = wibox.container.margin
					},
					nil,
					volumeslider,
					forced_height = dpi(20),
					layout = wibox.layout.align.horizontal
				},
				left = dpi(20),
				right = dpi(23),
				bottom = dpi(20),
				widget = wibox.container.margin
			},
			{
				{
					{
						brightnessicon,
						right = dpi(15),
						widget = wibox.container.margin
					},
					nil,
					brightnessslider,
					forced_height = dpi(20),
					layout = wibox.layout.align.horizontal
				},
				left = dpi(20),
				right = dpi(23),
				bottom = dpi(20),
				widget = wibox.container.margin
			},
			layout = wibox.layout.fixed.vertical
		},
		{
			{
				textbutton{ text="", size="15", onclick=browser },
				textbutton{ text="", size="15", onclick=terminal },
				textbutton{ text="", size="15", onclick=files },
				expand = "none",
				layout = wibox.layout.align.horizontal
			},
			left = dpi(15),
			right = dpi(15),
			widget = wibox.container.margin
		},
		layout = wibox.layout.align.vertical
	},
	valign = "top",
	layout = wibox.container.place
}

awesome.connect_signal("signal::volume", function(volume, mute)
	if mute then
		volumeslider.value = 0
		volumeicon.text = ""
	else
		volumeslider.value = volume
		if volume > 100 then
			volumeicon.text = ""
		elseif volume >= 50 then
			volumeicon.text = ""
		elseif volume >= 25 then
			volumeicon.text = ""
		elseif volume > 0 then
			volumeicon.text = ""
		elseif volume == 0 then
			volumeicon.text = ""
		end
	end
end)

awesome.connect_signal("signal::brightness", function(brightness)
	brightnessslider.value = brightness
	if brightness >= 75 then
		brightnessicon.text = ""
	elseif brightness >= 50 then
		brightnessicon.text = ""
	elseif brightness >= 25 then
		brightnessicon.text = ""
	elseif brightness > 0 then
		brightnessicon.text = ""
	elseif brightness == 0 then
		brightnessicon.text = ""
	end
end)


awesome.connect_signal("widget::launcher", function()
	launcherDisplay.visible = not launcherDisplay.visible
	
	awful.widget.watch("cat /sys/class/power_supply/BAT0/capacity", 15, function(widget, stdout)
 		batteryslider.value = tonumber(stdout)
		if tonumber(stdout) >= 95 then
			batteryicon.text = ""
		elseif tonumber(stdout) >= 80 then
			batteryicon.text = ""
		elseif tonumber(stdout) >= 70 then
			batteryicon.text = ""
		elseif tonumber(stdout) >= 50 then
			batteryicon.text = ""
		elseif tonumber(stdout) >= 40 then
			batteryicon.text = ""
		elseif tonumber(stdout) >= 30 then
			batteryicon.text = ""
		elseif tonumber(stdout) >= 20 then
			batteryicon.text = ""
		elseif tonumber(stdout) >= 0 then
			batteryicon.text = ""
		else
			batteryicon.text = ""
		end
	end)

	awful.placement.bottom_left(
		launcherDisplay, 
		{
			margins = { 
				bottom = dpi(60), 
				left = dpi(10)
			}, 
			parent = awful.screen.focused()
		}
	)
end)
