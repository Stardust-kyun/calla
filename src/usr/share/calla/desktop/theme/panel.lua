local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local dock = require("theme.dock")

local function create(s)

local menu = button {
	image = "calla",
	run = function()
		awesome.emit_signal('widget::launcher')
	end
}

local tray = wibox.widget {
	wibox.widget.systray(),
	margins = 0,
	visible = false,
	widget = wibox.container.margin
}

local systraybutton = hovercursor(wibox.widget {
	buttons = { 
		awful.button({}, 1, function()
			awesome.emit_signal("widget::systray")
		end)
	},
	align = "center",
	widget = iconbox({ image = "left" })
})

local systray = wibox.widget {
	{
		{
			systraybutton,
			forced_width = dpi(30),
			widget = wibox.container.background
		},
		tray,
		layout = wibox.layout.fixed.horizontal
	},
	widget = background({ bg = "bgmid" })
}

local closed = true

local systraystore
awesome.connect_signal("widget::systray", function()
	if closed == true then
		tray.visible = true
		tray.margins = dpi(5)
		systraystore = "right"
		closed = false
	else
		tray.visible = false
		tray.margins = 0
		systraystore = "left"
		closed = true
	end
	systraybutton.image = createicon(systraystore)
end)

local media = wibox.widget {
	{
		{
			{
				id = "icon",
				widget = iconbox({ image = "musicon" })
			},
			{
				id = "title",
				widget = wibox.widget.textbox("Not Playing - No Artist")
			},
			spacing = dpi(4),
			layout = wibox.layout.fixed.horizontal
		},
		left = dpi(8),
		right = dpi(8),
		widget = wibox.container.margin
	},
	widget = background({ bg = "bgmid", fg = "fg" })
}

local playerstore
awesome.connect_signal("signal::playerctl", function(title, album, artist, cover, status)
	if string.len(title .. " - " .. artist) > 50 then
		media:get_children_by_id("title")[1].text = title
	else
		media:get_children_by_id("title")[1].text = title .. " - " .. artist
	end
	if title == "Not Playing" then
		state = false
		playerstore = "musicoff"
	else
		state = true
		playerstore = "musicon"
	end
	media:get_children_by_id("icon")[1].image = createicon(playerstore)
end)

local volumepercent = wibox.widget {
	text = "N/A",
	widget = wibox.widget.textbox
}

local volumeicon = iconbox({ image = "volumemute" })

local volume = wibox.widget {
	{
		{
			volumeicon,
			volumepercent,
			spacing = dpi(4),
			layout = wibox.layout.fixed.horizontal
		},
		left = dpi(8),
		right = dpi(8),
		widget = wibox.container.margin
	},
	widget = background({ bg = "bgmid", fg = "fg" })
}

local volumestore
awesome.connect_signal("signal::volume", function(volume, mute)
	if mute then
		volumepercent.text = "Muted"
		volumestore = "volumemute"
	else
		volumepercent.text = tostring(volume) .. "%"
		if volume > 100 then
			volumestore = "volumewarn"
		elseif volume >= 50 then
			volumestore = "volume100"
		elseif volume >= 25 then
			volumestore = "volume50"
		elseif volume > 0 then
			volumestore = "volume25"
		elseif volume == 0 then
			volumestore = "volume0"
		end
	end
	volumeicon.image = createicon(volumestore)
end)

local batterypercent = wibox.widget {
	text = "N/A",
	widget = wibox.widget.textbox
}

local batteryicon = iconbox({ image = "batterynone" })

local battery = wibox.widget {
	{
		{
			batteryicon,
			batterypercent,
			spacing = dpi(4),
			layout = wibox.layout.fixed.horizontal
		},
		left = dpi(8),
		right = dpi(8),
		widget = wibox.container.margin
	},
	widget = background({ bg = "bgmid", fg = "fg" })
}

local batterystore
if user.batt ~= nil then
	awful.widget.watch("cat /sys/class/power_supply/" .. user.batt .. "/capacity", 15, function(widget, stdout)
		percent = tonumber(stdout)
		batterypercent.text = percent .. "%"
		if percent > 80 then
			batterystore = "battery100"
		elseif percent > 50 then
			batterystore = "battery80"
		elseif percent > 25 then
			batterystore = "battery50"
		elseif percent > 10 then
			batterystore = "battery25"
		elseif percent > 5 then
			batterystore = "battery10"
		else
			batterystore = "battery0"
		end
		batteryicon.image = createicon(batterystore)
	end)
end

local clock = wibox.widget {
	{
		{
			iconbox({ image = "clock" }),
			wibox.widget.textclock('%I:%M %p'),
			spacing = dpi(4),
			layout = wibox.layout.fixed.horizontal
		},
		left = dpi(8),
		right = dpi(8),
		widget = wibox.container.margin
	},
	widget = background({ bg = "bgmid", fg = "fg" })
}

local taglist = awful.widget.taglist {
	screen = s,
	filter = awful.widget.taglist.filter.selected,
	style = {
		shape = function(cr, width, height)
					gears.shape.rounded_rect(cr, width, height, dpi(10))
				end
	},
	widget_template = {
		{
			{
				{
					wibox.widget.textbox("Workspace "),
					widget = background({ fg = "fg" })
				},
				{
					id = "text_role",
					widget = wibox.widget.textbox
				},
				layout = wibox.layout.fixed.horizontal
			},
			left = dpi(8),
			right = dpi(8),
			widget = wibox.container.margin
		},
		id = "background_role",
		widget = wibox.container.background,
		create_callback = function(self)
			hovercursor(self)
		end
	},
	buttons = {
		awful.button({ }, 1, function()
			awesome.emit_signal("widget::preview")
		end),
		awful.button({ }, 4, function(t)
			awful.tag.viewnext(t.screen)
		end),
		awful.button({ }, 5, function(t)
			awful.tag.viewprev(t.screen)
		end)
	}
}

local layouts = awful.widget.layoutbox {
	screen  = s,
	buttons = {
		awful.button({ }, 1, function () awful.layout.inc( 1) end),
		awful.button({ }, 3, function () awful.layout.inc(-1) end),
	}
}

local layoutbox = hovercursor(wibox.widget {
	{
		layouts,
		margins = dpi(5),
		widget = wibox.container.margin
	},
	widget = background({ bg = "bgmid" })
})

awesome.connect_signal("live::reload", function()
	if systraystore then systraybutton.image = createicon(systraystore) end
	if playerstore then media:get_children_by_id("icon")[1].image = createicon(playerstore) end
	if volumestore then volumeicon.image = createicon(volumestore) end
	if batterystore then batteryicon.image = createicon(batterystore) end
	taglist._do_taglist_update_now()
	tag.emit_signal("property::layout", awful.screen.focused().selected_tag)
end)

return wibox.widget {
	{
		{
			{
				menu,
				taglist,
				layoutbox,
				spacing = dpi(5),
				layout = wibox.layout.fixed.horizontal
			},
			nil,
			{
				systray,
				hovercursor(wibox.widget {
					media,
					volume,
					battery,
					clock,
					buttons = {
						awful.button({ }, 1, function()
							awesome.emit_signal("widget::control")
						end)
					},
					spacing = dpi(5),
					layout = wibox.layout.fixed.horizontal
				}),
				spacing = dpi(5),
				layout = wibox.layout.fixed.horizontal
			},
			layout = wibox.layout.align.horizontal
		},
		{
			dock,
			halign = "center",
			widget = wibox.container.place
		},
		layout = wibox.layout.stack
	},
	forced_height = dpi(50),
	margins = dpi(10),
	widget = wibox.container.margin
}

end

return create
