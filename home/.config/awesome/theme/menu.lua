local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local dpi = beautiful.xresources.apply_dpi

-- Menu

local menudisplay = wibox {
	width = dpi(375),
	height = dpi(655),
	bg = beautiful.bg_normal,
	ontop = true,
	visible = false
}

-- Header

local headertext = wibox.widget {
	valign = "center",
	widget = wibox.widget.textbox
}

local menutoggle = hovercursor(wibox.widget {
	font = user.fonticon,
	widget = wibox.widget.textbox
})

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
	forced_height = dpi(40),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

-- Profile

local pfp = wibox.widget {
	image = beautiful.pfp,
	widget = wibox.widget.imagebox
}

local username = wibox.widget {
	text = "Username",
	widget = wibox.widget.textbox
}

local host = wibox.widget {
	text = "@host",
	font = user.fontalt,
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
				username,
				nil,
				{
					host,
					fg = beautiful.fg_normal .. "75",
					widget = wibox.container.background
				},
				layout = wibox.layout.align.vertical
			},
			margins = dpi(15),
			widget = wibox.container.margin
		},
		forced_height = dpi(85),
		forced_width = dpi(185),
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	},
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal
}

-- Calendar

local date = wibox.widget {
	format = "%A %B %d, %Y",
	widget = wibox.widget.textclock
}

local uptime = wibox.widget {
	font = user.fontalt,
	widget = wibox.widget.textbox
}

local calendar = wibox.widget {
	{
		{
			date,
			{
				uptime,
				fg = beautiful.fg_normal.."75",
				widget = wibox.container.background
			},
			layout = wibox.layout.align.vertical
		},
		margins = dpi(15),
		widget = wibox.container.margin
	},
	forced_height = dpi(85),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

-- Player

local title = wibox.widget {
	text = "Not Playing",
	forced_height = dpi(20),
	widget = wibox.widget.textbox
}

local album = wibox.widget {
	text = "No Album",
	font = user.fontalt,
	widget = wibox.widget.textbox
}

local artist = wibox.widget {
	text = "No Artist",
	font = user.fontalt,
	forced_height = dpi(20),
	widget = wibox.widget.textbox
}

local prev = hovercursor(wibox.widget {
	text = "",
	font = user.fonticon,
	buttons = {
		awful.button({}, 1, function()
			awful.spawn.with_shell("playerctl previous")
		end)
	},
	widget = wibox.widget.textbox
})

local next = hovercursor(wibox.widget {
	text = "",
	font = user.fonticon,
	buttons = {
		awful.button({}, 1, function()
			awful.spawn.with_shell("playerctl next")
		end)
	},
	widget = wibox.widget.textbox
})

local play = hovercursor(wibox.widget {
	text = "",
	font = user.fonticon,
	buttons = {
		awful.button({}, 1, function()
			awful.spawn.with_shell("playerctl play-pause")
		end)
	},
	widget = wibox.widget.textbox
})

local player = wibox.widget {
	{
		{
			{
				prev,
				play,
				next,
				spacing = dpi(15),
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
	forced_height = dpi(125),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

-- Wifi

local wifibutton = hovercursor(wibox.widget {
	text = "",
	font = user.fonticon,
	align = "center",
	forced_height = dpi(45),
	forced_width = dpi(85),
	widget = wibox.widget.textbox
})

local wifi = wibox.widget {
	wifibutton,
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

local function wifistatus(change)
	awful.spawn.easy_async_with_shell("nmcli radio wifi", function(out)
		if out:match("enabled") then
			wifi.fg = beautiful.fg_normal
			wifibutton.text = ""
			if change then
				wifi.fg = beautiful.fg_normal .. "75"
				wifibutton.text = ""
				awful.spawn.with_shell("nmcli radio wifi off")
			end
		else
			wifi.fg = beautiful.fg_normal .. "75"
			wifibutton.text = ""
			if change then
				wifi.fg = beautiful.fg_normal
				wifibutton.text = ""
				awful.spawn.with_shell("nmcli radio wifi on")
			end
		end
	end)
end

wifi:buttons {
	awful.button({}, 1, function()
		wifistatus(true)
	end)
}

-- Bluetooth

local btbutton = hovercursor(wibox.widget {
	text = "",
	font = user.fonticon,
	align = "center",
	forced_height = dpi(45),
	forced_width = dpi(85),
	widget = wibox.widget.textbox
})

local bt = wibox.widget {
	btbutton,
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

local function btstatus(change)
	awful.spawn.easy_async_with_shell("bluetoothctl show", function(out)
		if out:match("Powered: yes") then
			bt.fg = beautiful.fg_normal
			btbutton.text = ""
			if change then
				bt.fg = beautiful.fg_normal .. "75"
				btbutton.text = ""
				awful.spawn.with_shell("bluetoothctl power off")
			end
		else
			bt.fg = beautiful.fg_normal .. "75"
			btbutton.text = ""
			if change then
				bt.fg = beautiful.fg_normal
				btbutton.text = ""
				awful.spawn.with_shell("bluetoothctl power on")
			end
		end
	end)
end

bt:buttons {
	awful.button({}, 1, function()
		btstatus(true)
	end)
}

-- Do Not Disturb

local dndbutton = hovercursor(wibox.widget {
	text = "",
	font = user.fonticon,
	align = "center",
	forced_height = dpi(45),
	forced_width = dpi(85),
	widget = wibox.widget.textbox
})

local dnd = wibox.widget {
	dndbutton,
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

dnd:buttons {
	awful.button({}, 1, function()
		naughty.toggle()
		if naughty.suspended then
			dnd.fg = beautiful.fg_normal .. "75"
			dndbutton.text = ""
		else
			dnd.fg = beautiful.fg_normal
			dndbutton.text = ""
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
	font = user.fonticon,
	valign = "center",
	align = "center",
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
	align = "center",
	widget = wibox.widget.textbox
}

local volume = wibox.widget	{
	{
		{
			volumeicon,
			{
				{
				volumebar,
				direction = "east",
				forced_height = dpi(105),
				widget = wibox.container.rotate
			},
			left = dpi(19),
			right = dpi(19),
			widget = wibox.container.margin
			},
			volumepercent,
			forced_width = dpi(20),
			spacing = dpi(10),
			layout = wibox.layout.fixed.vertical
		},
		top = dpi(10),
		bottom = dpi(5),
		widget = wibox.container.margin
	},
	forced_height = dpi(185),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

-- Brightness

local brightnessicon = wibox.widget {
	text = "",
	font = user.fonticon,
	valign = "center",
	align = "center",
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
	align = "center",
	widget = wibox.widget.textbox
}

local brightness = wibox.widget {
	{
		{
			brightnessicon,
			{
				{
				brightnessbar,
				direction = "east",
				forced_height = dpi(105),
				widget = wibox.container.rotate
			},
			left = dpi(19),
			right = dpi(19),
			widget = wibox.container.margin
			},
			brightnesspercent,
			forced_width = dpi(20),
			spacing = dpi(10),
			layout = wibox.layout.fixed.vertical
		},
		top = dpi(10),
		bottom = dpi(5),
		widget = wibox.container.margin
	},
	forced_height = dpi(185),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

-- Battery

local batteryicon = wibox.widget {
	text = "",
	font = user.fonticon,
	valign = "center",
	align = "center",
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
	align = "center",
	widget = wibox.widget.textbox
}

local battery = wibox.widget {
	{
		{
			batteryicon,
			{
				{
				batterybar,
				direction = "east",
				forced_height = dpi(105),
				widget = wibox.container.rotate
			},
			left = dpi(19),
			right = dpi(19),
			widget = wibox.container.margin
			},
			batterypercent,
			forced_width = dpi(20),
			spacing = dpi(10),
			layout = wibox.layout.fixed.vertical
		},
		top = dpi(10),
		bottom = dpi(5),
		widget = wibox.container.margin
	},
	forced_height = dpi(185),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

-- Info (volume, brightness, battery)

local info = wibox.widget {
	volume,
	brightness,
	battery,
	spacing = dpi(15),
	forced_width = dpi(45),
	layout = wibox.layout.fixed.vertical
}

-- Buttons

local button = function(args)
	local button = hovercursor(wibox.widget {
		{
			text = args.icon,
			font = user.fonticon,
			align = "center",
			forced_height = dpi(45),
			forced_width = dpi(45),
			widget = wibox.widget.textbox
		},
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	})

	button:connect_signal("button::press", function() 
		awesome.emit_signal("widget::menu")
		awful.spawn.with_shell(args.exec)
	end)

	return button
end

-- Power


local power = wibox.widget {
	button{ icon="", exec=user.lock },
	button{ icon="", exec=user.exit },
  button{ icon="", exec=user.suspend },
	button{ icon="", exec=user.shutdown },
	button{ icon="", exec=user.reboot },
	forced_height = dpi(48),
	spacing = dpi(15),
	layout = wibox.layout.flex.horizontal
}

-- Systray

local systray = wibox.widget {
	{
		{
			{
				{
					widget = wibox.widget.systray,
					base_size = dpi(24),
					horizontal = false
				},
				widget = wibox.layout.align.vertical
			},
			valign = "top",
			halign = "left",
			layout = wibox.container.place
		},
		top = dpi(12),
		bottom = dpi(12),
		left = dpi(12),
		right = dpi(12),
		widget = wibox.container.margin
	},
	forced_width = dpi(165),
	forced_height = dpi(55),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

-- Shortcuts (apps, systray, power)

local shortcuts = wibox.widget {
	power,
	systray,
	spacing = dpi(15),
	layout = wibox.layout.fixed.vertical
}

-- Widgets

local launcher = hovercursor(wibox.widget {
	{
		{
			{
				text = "",
				font = user.fonticon,
				valign = "center",
				align = "center",
				widget = wibox.widget.textbox
			},
			{
				text = "Search...",
				valign = "center",
				align = "center",
				widget = wibox.widget.textbox
			},
			spacing = dpi(15),
			layout = wibox.layout.fixed.horizontal
		},
		margins = dpi(15),
		widget = wibox.container.margin
	},
	buttons = {
		awful.button({}, 1, function()
			awesome.emit_signal("widget::menu")
			awesome.emit_signal("widget::launcher")
		end)
	},
	forced_height = dpi(65),
	forced_width = dpi(185),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
})

local config = hovercursor(wibox.widget {
	{
		text = "",
		font = user.fonticon,
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox
	},
	buttons = {
		awful.button({}, 1, function()
			awesome.emit_signal("widget::menu")
			awesome.emit_signal("widget::config")
		end)
	},
	forced_height = dpi(65),
	forced_width = dpi(85),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
})

local widgets = wibox.widget {
	launcher,
	config,
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal
}

-- Control center

local controlcenter = wibox.widget {
	{
		profile,
		calendar,
		player,
		toggles,
		shortcuts,
		widgets,
		spacing = dpi(15),
		forced_width = dpi(285),
		layout = wibox.layout.fixed.vertical
	},
	info,
	spacing = dpi(15),
	visible = true,
	layout = wibox.layout.fixed.horizontal
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
						width = dpi(230),
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
			margins = dpi(15),
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

awesome.connect_signal("signal::playerctl", function(titlename, albumname, artistname, status)
	title.text = titlename
	album.text = albumname
	artist.text = artistname
	if status then
		play.text = ""
	else
		play.text = ""
	end
end)

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

if user.batt ~= nil then
	awful.widget.watch("cat /sys/class/power_supply/" .. user.batt .. "/capacity", 15, function(widget, stdout)
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
end

awesome.connect_signal("widget::menu", function()
	menudisplay.visible = not menudisplay.visible

	menutoggle.text = ""
	headertext.text = "Control Center"
	notifs.visible = false
	controlcenter.visible = true

	awful.spawn.easy_async_with_shell("uptime -p", function(out)
		uptime.text = out:gsub("up ", "")
	end)

	awful.spawn.easy_async_with_shell("whoami", function(out)
		username.text = out:gsub("\n", "")
	end)
	awful.spawn.easy_async_with_shell("hostname", function(out)
		host.text = "@" .. out
	end)

	wifistatus()
	btstatus()

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
				honor_workarea = true,
				parent = awful.screen.focused()
			}
		)
	end
end)

awesome.connect_signal("widget::hide", function()
	menudisplay.visible = false
end)
