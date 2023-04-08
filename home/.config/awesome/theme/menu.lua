local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local dpi = beautiful.xresources.apply_dpi

-- Menu

local menudisplay = wibox {
	width = dpi(315),
	height = dpi(685),
	bg = beautiful.bg_normal,
	ontop = true,
	visible = false
}

-- Header

local headertext = wibox.widget {
	text = "Control Center",
	valign = "center",
	widget = wibox.widget.textbox
}

local menutoggle = wibox.widget {
	text = "",
	font = fonticon,
	widget = wibox.widget.textbox
}

local header = wibox.widget	{
	{
		{
			headertext,
			nil,
			menutoggle,
			forced_width = dpi(650),
			layout = wibox.layout.align.horizontal
		},
		left = dpi(15),
		right = dpi(10),
		top = dpi(10),
		bottom = dpi(10),
		widget = wibox.container.margin
	},
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

-- Profile

local pfp = wibox.widget {
	image = beautiful.pfp,
	widget = wibox.widget.imagebox
}

local user = wibox.widget {
	markup = "Username",
	widget = wibox.widget.textbox
}

local host = wibox.widget {
	markup = "<span foreground='" .. beautiful.fg_normal .. "75'>@host</span>",
	font = fontalt,
	widget = wibox.widget.textbox
}

local profile = wibox.widget {
	{
		{
			pfp,
			margins = dpi(10),
			widget = wibox.container.margin
		},
		bg = beautiful.bg_focus,
		forced_height = dpi(85),
		widget = wibox.container.background
	},
	{
		{
			{
				user,
				host,
				layout = wibox.layout.fixed.vertical
			},
			left = dpi(15),
			right = dpi(10),
			top = dpi(10),
			bottom = dpi(10),
			widget = wibox.container.margin
		},
		bg = beautiful.bg_focus,
		forced_height = dpi(85),
		forced_width = dpi(185),
		widget = wibox.container.background
	},
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal
}

-- Player

local title = wibox.widget {
	text = "Not Playing",
	forced_height = dpi(20),
	widget = wibox.widget.textbox
}

local album = wibox.widget {
	text = "No Album",
	font = fontalt,
	widget = wibox.widget.textbox
}

local artist = wibox.widget {
	text = "No Artist",
	font = fontalt,
	forced_height = dpi(20),
	widget = wibox.widget.textbox
}

local prev = wibox.widget {
	text = "",
	font = fonticon,
	buttons = {
		awful.button({}, 1, function()
			awful.spawn.with_shell("playerctl previous")
		end)
	},
	widget = wibox.widget.textbox
}

local next = wibox.widget {
	text = "",
	font = fonticon,
	buttons = {
		awful.button({}, 1, function()
			awful.spawn.with_shell("playerctl next")
		end)
	},
	widget = wibox.widget.textbox
}

local playbutton = wibox.widget {
	text = "",
	font = fonticon,
	widget = wibox.widget.textbox
}

local playertimer =	gears.timer {
	timeout = 1,
	callback = function()
		awful.spawn.easy_async_with_shell("playerctl metadata --format 'title_{{title}}album_{{album}}artist_{{artist}}'", function(out)
			title.text = out:match("title_(.*)album_") or "Not Playing"
			album.text = out:match("album_(.*)artist_") or "No Album"
			artist.text = out:match("artist_(.*)") or "No Artist"
		end)
	end
}

playbutton:buttons {
	awful.button({}, 1, function()
		awful.spawn.with_shell("playerctl play-pause")
	end)
}

local player = wibox.widget {
	{
		{
			{
				prev,
				playbutton,
				next,
				spacing = dpi(20),
				layout = wibox.layout.fixed.vertical
			},
			{
				title,
				{
					album,
					fg = beautiful.fg_normal.."75",
					widget = wibox.container.background
				},
				{
					artist,
					fg = beautiful.fg_normal.."75",
					widget = wibox.container.background
				},
				expand = "none",
				layout = wibox.layout.align.vertical
			},
			spacing = dpi(15),
			layout = wibox.layout.fixed.horizontal
		},
		margins = dpi(15),
		widget = wibox.container.margin
	},
	forced_height = dpi(130),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

-- Wifi

local wifibutton = wibox.widget {
	text = "",
	font = fonticon,
	align = "center",
	forced_height = dpi(45),
	forced_width = dpi(85),
	widget = wibox.widget.textbox
}

local wifi = wibox.widget {
	wifibutton,
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

local wifienable = true

wifi:buttons {
	awful.button({}, 1, function()
		wifienable = not wifienable
		if wifienable then
			wifi.fg = beautiful.fg_normal
			wifibutton.text = ""
			awful.spawn.with_shell("nmcli radio wifi on")
		else
			wifi.fg = beautiful.fg_normal .. "75"
			wifibutton.text = ""
			awful.spawn.with_shell("nmcli radio wifi off")
		end
	end)
}

-- Bluetooth

local btbutton = wibox.widget {
	text = "",
	font = fonticon,
	align = "center",
	forced_height = dpi(45),
	forced_width = dpi(85),
	widget = wibox.widget.textbox
}

local bt = wibox.widget {
	btbutton,
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

local btenable = true

bt:buttons {
	awful.button({}, 1, function()
		btenable = not btenable
		if btenable then
			bt.fg = beautiful.fg_normal
			btbutton.text = ""
			awful.spawn.with_shell("bluetoothctl power on")
		else
			bt.fg = beautiful.fg_normal .. "75"
			btbutton.text = ""
			awful.spawn.with_shell("bluetoothctl power off")
		end
	end)
}

-- Do Not Disturb

local dndbutton = wibox.widget {
	text = "",
	font = fonticon,
	align = "center",
	forced_height = dpi(45),
	forced_width = dpi(85),
	widget = wibox.widget.textbox
}

local dnd = wibox.widget {
	dndbutton,
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

local dndenable = true

dnd:buttons {
	awful.button({}, 1, function()
		dndenable = not dndenable
		if dndenable then
			dnd.fg = beautiful.fg_normal
			dndbutton.text = ""
			naughty.resume()
		else
			dnd.fg = beautiful.fg_normal .. "75"
			dndbutton.text = ""
			naughty.suspend()
		end
	end)
}

-- Toggles (wifi, bt, dnd)

local toggles = wibox.widget {
	wifi,
	bt,
	dnd,
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal
}

-- Volume

local volumeicon = wibox.widget {
	text = "",
	font = fonticon,
	valign = "center",
	widget = wibox.widget.textbox
}

local volumebar = wibox.widget {
	shape = gears.shape.rounded_rect,
	bar_shape = gears.shape.rounded_rect,
	color = beautiful.fg_normal,
	background_color = beautiful.fg_normal .. 25,
	max_value = 100,
	value = 0,
	widget = wibox.widget.progressbar
}

local volumepercent = wibox.widget {
	text = "N/A",
	widget = wibox.widget.textbox
}

local volume = wibox.widget	{
	volumeicon,
	{
		volumebar,
		top = dpi(7),
		bottom = dpi(7),
		forced_width = dpi(165),
		widget = wibox.container.margin
	},
	{
		nil,
		nil,
		volumepercent,
		forced_width = dpi(40),
		layout = wibox.layout.align.horizontal
	},
	forced_height = dpi(20),
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal
}

-- Brightness

local brightnessicon = wibox.widget {
	text = "",
	font = fonticon,
	valign = "center",
	widget = wibox.widget.textbox
}

local brightnessbar = wibox.widget {
	shape = gears.shape.rounded_rect,
	bar_shape = gears.shape.rounded_rect,
	color = beautiful.fg_normal,
	background_color = beautiful.fg_normal .. 25,
	max_value = 100,
	value = 0,
	widget = wibox.widget.progressbar
}

local brightnesspercent = wibox.widget {
	text = "N/A",
	widget = wibox.widget.textbox
}

local brightness = wibox.widget {
	brightnessicon,
	{
		brightnessbar,
		top = dpi(7),
		bottom = dpi(7),
		forced_width = dpi(165),
		widget = wibox.container.margin
	},
	{
		nil,
		nil,
		brightnesspercent,
		forced_width = dpi(40),
		layout = wibox.layout.align.horizontal
	},
	forced_height = dpi(20),
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal
}

-- Battery

local batteryicon = wibox.widget {
	text = "",
	font = fonticon,
	valign = "center",
	widget = wibox.widget.textbox
}

local batterybar = wibox.widget {
	shape = gears.shape.rounded_rect,
	bar_shape = gears.shape.rounded_rect,
	color = beautiful.fg_normal,
	background_color = beautiful.fg_normal .. 25,
	max_value = 100,
	value = 0,
	widget = wibox.widget.progressbar
}

local batterypercent = wibox.widget {
	text = "N/A",
	widget = wibox.widget.textbox
}

local battery = wibox.widget {
	batteryicon,
	{
		batterybar,
		top = dpi(7),
		bottom = dpi(7),
		forced_width = dpi(165),
		widget = wibox.container.margin
	},
	{
		nil,
		nil,
		batterypercent,
		forced_width = dpi(40),
		layout = wibox.layout.align.horizontal
	},
	forced_height = dpi(20),
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal
}

-- Info (volume, brightness, battery)

local info = wibox.widget {
	{
		{
			volume,
			brightness,
			battery,
			spacing = dpi(20),
			layout = wibox.layout.fixed.vertical
		},
		margins = dpi(15),
		widget = wibox.container.margin
	},
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

-- Buttons

local button = function(args)
	local button = wibox.widget {
		{
			text = args.icon,
			font = fonticon,
			align = "center",
			forced_height = dpi(45),
			forced_width = dpi(45),
			widget = wibox.widget.textbox
		},
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	}

	button:connect_signal("button::press", function() 
		awesome.emit_signal("widget::menu")
		awful.spawn.with_shell(args.run)
	end)

	return button
end

-- Apps

local apps = wibox.widget {
	button{ icon="", run=browser },
	button{ icon="", run=terminal },
	button{ icon="", run=files },
	button{ icon="", run=editorcmd },
	button{ icon="", run=config },
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal
}

-- Systray

local systray = wibox.widget {
	{	
		{
			widget = wibox.widget.systray,
			base_size = dpi(25),
			horizontal = false
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	bg = beautiful.bg_focus,
	forced_height = dpi(45),
	widget = wibox.container.background
}

-- Power

local power = wibox.widget {
	button{ icon="", run=lock },
	button{ icon="", run=suspend },
	button{ icon="", run=exit },
	button{ icon="", run=shutdown },
	button{ icon="", run=reboot },
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal
}

-- Shortcuts (apps, systray, power)

local shortcuts = wibox.widget {
	apps,
	systray,
	power,
	spacing = dpi(15),
	layout = wibox.layout.fixed.vertical
}

-- Control center

local controlcenter = wibox.widget {
	profile,
	player,
	toggles,
	info,
	shortcuts,
	spacing = dpi(15),
	visible = true,
	layout = wibox.layout.fixed.vertical
}

-- Notification center

local notifscontainer = wibox.widget {
	spacing = dpi(15),
	layout = wibox.layout.fixed.vertical
}

local notifsempty = wibox.widget {
	nil,
	{
		nil,
		{
			text = "No Notifications",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox
		},
		layout = wibox.layout.align.horizontal
	},
	forced_height = dpi(1000), --fix this?
	layout = wibox.layout.align.vertical
}

local notifsemptyvisible = true

removenotif = function(box)
	notifscontainer:remove_widgets(box)

	if #notifscontainer.children == 0 then
		notifscontainer:insert(1, notifsempty)
		notifsemptyvisible = true
	end
end

local createnotif = function(n)
	local time = os.date("%I:%M %p")
	local box = wibox.widget {
		{
			{
				{
					{
						{
							text = n.title,
							align = "left",
							widget = wibox.widget.textbox
						},
						strategy = "exact",
						width = dpi(180),
						height = dpi(20),
						widget = wibox.container.constraint
					},
					nil,
					{
						text = time,
						align = "right",
						widget = wibox.widget.textbox
					},
					layout = wibox.layout.align.horizontal
				},
				{
					text = n.message,
					align = "left",
					widget = wibox.widget.textbox
				},
				spacing = dpi(10),
				layout = wibox.layout.fixed.vertical
			},
			margins = dpi(10),
			widget = wibox.container.margin
		},
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	}

	box:buttons(
		gears.table.join(
			awful.button({}, 1, function()
				_G.removenotif(box)
			end)
		)
	)

	return box
end

notifscontainer:buttons(
	gears.table.join(
		awful.button({}, 4, nil, function()
			if #notifscontainer.children == 1 then
				return
			end
			notifscontainer:insert(1, notifscontainer.children[#notifscontainer.children])
			notifscontainer:remove(#notifscontainer.children)
		end),

		awful.button({}, 5, nil, function()
			if #notifscontainer.children == 1 then
				return
			end
			notifscontainer:insert(#notifscontainer.children + 1, notifscontainer.children[1])
			notifscontainer:remove(1)
		end)
	)
)

-- Notification center setup

notifscontainer:insert(1, notifsempty)

naughty.connect_signal("request::display", function(n)
	if #notifscontainer.children == 1 and notifsemptyvisible then
		notifscontainer:reset(notifscontainer)
		notifsemptyvisible = false
	end

	notifscontainer:insert(1, createnotif(n))
end)

local notifs = wibox.widget {
	notifscontainer,
	spacing = dpi(15),
	visible = false,
	layout = wibox.layout.fixed.vertical
}

-- Menu setup (everything!)

menudisplay:setup {
	{
		header,
		{
			{
				notifs,
				controlcenter,
				layout = wibox.layout.stack
			},
			margins = dpi(15),
			widget = wibox.container.margin
		},
		layout = wibox.layout.align.vertical
	},
	valign = "top",
	layout = wibox.container.place
}

menutoggle:buttons {
	awful.button({}, 1, function()
		if controlcenter.visible then
			menutoggle.text = ""
			headertext.text = "Notifications"
			notifs.visible = true
			controlcenter.visible = false
		else
			menutoggle.text = ""
			headertext.text = "Control Center"
			notifs.visible = false
			controlcenter.visible = true
		end
	end)
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

awesome.connect_signal("widget::menu", function()
	menudisplay.visible = not menudisplay.visible
	menutoggle.text = ""
	headertext.text = "Control Center"
	notifs.visible = false
	controlcenter.visible = true

	awful.spawn.easy_async_with_shell([[getent passwd | grep "$USER" | cut -d":" -f5 | cut -d"," -f1]], function(out)
		user.markup = out
	end)
	awful.spawn.easy_async_with_shell("hostname", function(out)
		host.markup = "<span foreground='" .. beautiful.fg_normal .. "75'>@" .. out .. "</span>"
	end)
	
	if menudisplay.visible then
		playertimer:start()
	else
		playertimer:stop()
	end

	awful.widget.watch("cat /sys/class/power_supply/" .. batt .. "/capacity", 15, function(widget, stdout)
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
		end
	end)

	if client.focus and client.focus.fullscreen == true then
		awful.placement.bottom_left(
			menudisplay, 
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
			menudisplay, 
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
	menudisplay.visible = false
end)
