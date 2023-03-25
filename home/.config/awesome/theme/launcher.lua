local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Launcher

local launcherDisplay = wibox {
	width = dpi(300),
	height = dpi(360),
	bg = beautiful.bg_normal,
	ontop = true,
	visible = false,
	shape = function(cr, width, height)
		gears.shape.rectangle(cr, width, height)
	end
}

-- Header

local header = wibox.widget	{
	{
		{
			{
				text = "Launcher",
				valign = "center",
				widget = wibox.widget.textbox
			},
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
}

-- Volume

local volumeicon = wibox.widget {
	font = fonticon,
	valign = "center",
	widget = wibox.widget.textbox
}

local volumebar = wibox.widget {
	shape = gears.shape.rounded_rect,
	bar_shape = gears.shape.rounded_rect,
	color = beautiful.fg_normal,
	background_color = beautiful.bg_focus,
	max_value = 100,
	widget = wibox.widget.progressbar
}

local volumepercent = wibox.widget {
	widget = wibox.widget.textbox
}

local volume = wibox.widget	{
	{
		{
			volumeicon,
			right = dpi(15),
			widget = wibox.container.margin
		},
		{
			volumebar,
			top = dpi(7),
			bottom = dpi(7),
			widget = wibox.container.margin
		},
		{
			{
				nil,
				nil,
				volumepercent,
				forced_width = dpi(40),
				layout = wibox.layout.align.horizontal
			},
			left = dpi(15),
			widget = wibox.container.margin
		},
		forced_height = dpi(20),
		layout = wibox.layout.align.horizontal
	},
	bottom = dpi(20),
	widget = wibox.container.margin
}

-- Brightness

local brightnessicon = wibox.widget {
	font = fonticon,
	valign = "center",
	widget = wibox.widget.textbox
}

local brightnessbar = wibox.widget {
	shape = gears.shape.rounded_rect,
	bar_shape = gears.shape.rounded_rect,
	color = beautiful.fg_normal,
	background_color = beautiful.bg_focus,
	max_value = 100,
	widget = wibox.widget.progressbar
}

local brightnesspercent = wibox.widget {
	widget = wibox.widget.textbox
}

local brightness = wibox.widget {
	{
		{
			brightnessicon,
			right = dpi(15),
			widget = wibox.container.margin
			},
		{
			brightnessbar,
			top = dpi(7),
			bottom = dpi(7),
			widget = wibox.container.margin
		},
		{
			{
				nil,
				nil,
				brightnesspercent,
				forced_width = dpi(40),
				layout = wibox.layout.align.horizontal
			},
			left = dpi(15),
			widget = wibox.container.margin
		},
		forced_height = dpi(20),
		layout = wibox.layout.align.horizontal
	},
	bottom = dpi(20),
	widget = wibox.container.margin
}

-- Battery

local batteryicon = wibox.widget {
	text = "",
	font = fonticon,
	valign = "center",
	widget = wibox.widget.textbox
}

local batterybar = wibox.widget {
	shape = gears.shape.rounded_rect,
	bar_shape = gears.shape.rounded_rect,
	color = beautiful.fg_normal,
	background_color = beautiful.bg_focus,
	max_value = 100,
	widget = wibox.widget.progressbar
}

local batterypercent = wibox.widget {
	widget = wibox.widget.textbox
}

local battery = wibox.widget {
	{
		batteryicon,
		right = dpi(15),
		widget = wibox.container.margin
	},
	{
		batterybar,
		top = dpi(7),
		bottom = dpi(7),
		widget = wibox.container.margin
	},
	{
		{
			nil,
			nil,
			batterypercent,
			forced_width = dpi(40),
			layout = wibox.layout.align.horizontal
		},
		left = dpi(15),
		widget = wibox.container.margin
	},
	forced_height = dpi(20),
	layout = wibox.layout.align.horizontal
}

-- Info (volume, brightness, battery)

local info = wibox.widget {
	{
		volume,
		brightness,
		battery,
		layout = wibox.layout.fixed.vertical
	},
	top = dpi(20),
	left = dpi(20),
	right = dpi(20),
	bottom = dpi(20),
	widget = wibox.container.margin
}

-- Shortcuts (apps, systray, power)

local textbutton = function(args)
	local text = args.text
	local onclick = args.onclick or function() end
	
	local result = wibox.widget {
		{
			text = text,
			font = fonticon,
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

local apps = wibox.widget {
	{
		{
			textbutton{ text="", onclick=browser },
			{
				textbutton{ text="", onclick=terminal },
				left = dpi(11),
				widget = wibox.container.margin
			},
			layout = wibox.layout.align.horizontal
		},
		{
			textbutton{ text="", onclick=files },
			expand = "none",
			layout = wibox.layout.align.horizontal
		},
		{
			textbutton{ text="", onclick=editorcmd },
			{
				textbutton{ text="", onclick=config },
				left = dpi(11),
					widget = wibox.container.margin
			},
			layout = wibox.layout.align.horizontal
		},
		expand = "none",
		layout = wibox.layout.align.horizontal
	},
	bottom = dpi(15),
	widget = wibox.container.margin
}

local systray = wibox.widget {
	{
		{	
			{
				widget = wibox.widget.systray,
				base_size = dpi(25),
				horizontal = false
			},
			top = dpi(10),
			bottom = dpi(10),
			left = dpi(10),
			right = dpi(10),
			widget = wibox.container.margin
		},
		bg = beautiful.bg_focus,
		forced_height = dpi(45),
		widget = wibox.container.background
	},
	bottom = dpi(15),
	widget = wibox.container.margin
}

local power = wibox.widget {
	{
		textbutton{ text="", onclick=lock },
		{
			textbutton{ text="", onclick=suspend },
			left = dpi(11),
			widget = wibox.container.margin
		},
		layout = wibox.layout.align.horizontal
	},
	{
		textbutton{ text="", onclick=exit },
		expand = "none",
		layout = wibox.layout.align.horizontal
	},
	{
		textbutton{ text="", onclick=shutdown },
		{
			textbutton{ text="", onclick=reboot },
			left = dpi(11),
				widget = wibox.container.margin
		},
		layout = wibox.layout.align.horizontal
	},
	expand = "none",
	layout = wibox.layout.align.horizontal
}

local shortcuts = wibox.widget {
	{
		apps,
		systray,
		power,
		layout = wibox.layout.align.vertical
	},
	left = dpi(15),
	right = dpi(15),
	widget = wibox.container.margin
}

-- Launcher setup (everything!)

launcherDisplay:setup {
	{
		header,
		info,
		shortcuts,
		layout = wibox.layout.align.vertical
	},
	valign = "top",
	layout = wibox.container.place
}

-- Signals

awesome.connect_signal("signal::volume", function(volume, mute)
	if mute then
		volumepercent.text = "Mute"
		volumeicon.text = ""
	else
		volumepercent.text = tostring(volume) .. "%"
		volumebar.value = volume
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
	brightnesspercent.text = tostring(brightness) .. "%"
	brightnessbar.value = brightness
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
		batterypercent.text = tonumber(stdout) .. "%"
 		batterybar.value = tonumber(stdout)
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

	if client.focus and client.focus.fullscreen == true then
		awful.placement.bottom_left(
			launcherDisplay, 
			{
				margins = { 
					bottom = dpi(10), 
					left = dpi(10)
				}, 
				parent = awful.screen.focused()
			}
		)
	else
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
	end
end)

awesome.connect_signal("widget::hide", function()
	launcherDisplay.visible = false
end)
