local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local dock = require("theme.dock")

local function create(s)

local menu = button {
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

local systraytext = colortext({ text = "", font = user.fonticon })

local systraybutton = hovercursor(wibox.widget {
	systraytext,
	buttons = { 
		awful.button({}, 1, function()
			awesome.emit_signal("widget::systray")
		end)
	},
	margins = dpi(5),
	widget = wibox.container.margin
})

local systray = wibox.widget {
	{
		systraybutton,
		tray,
		layout = wibox.layout.fixed.horizontal
	},
	shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, dpi(10))
			end,
	widget = live(wibox.container.background, { bg = "bgmid" })
}

local closed = true

awesome.connect_signal("widget::systray", function()
	if closed == true then
		tray.visible = true
		tray.margins = dpi(5)
		systraytext.markup = markup({ text = "", fg = beautiful.fg })
		closed = false
	else
		tray.visible = false
		tray.margins = 0
		systraytext.markup = markup({ text = "", fg = beautiful.fg })
		closed = true
	end
end)

local batterypercent = wibox.widget {
	text = "N/A",
	widget = wibox.widget.textbox
}

local battery = wibox.widget {
	{
		batterypercent,
		top = dpi(5),
		bottom = dpi(5),
		left = dpi(8),
		right = dpi(8),
		widget = wibox.container.margin
	},
	shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, dpi(10))
			end,
	widget = live(wibox.container.background, { bg = "bgmid", fg = "fg" })
}

if user.batt ~= nil then
	awful.widget.watch("cat /sys/class/power_supply/" .. user.batt .. "/capacity", 15, function(widget, stdout)
		batterypercent.text = tonumber(stdout) .. "%"
	end)
end

local clock = wibox.widget {
	{
		wibox.widget.textclock('%I:%M %p'),
		top = dpi(5),
		bottom = dpi(5),
		left = dpi(8),
		right = dpi(8),
		widget = wibox.container.margin
	},
	shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, dpi(10))
			end,
	widget = live(wibox.container.background, { bg = "bgmid", fg = "fg" })
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
				colortext({ text = "Workspace " }),
				{
					id = "text_role",
					widget = wibox.widget.textbox
				},
				layout = wibox.layout.fixed.horizontal
			},
			top = dpi(5),
			bottom = dpi(5),
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
	shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, dpi(10))
			end,
	widget = live(wibox.container.background, { bg = "bgmid" })
})

awesome.connect_signal("live::reload", function()
	taglist._do_taglist_update_now()
	tag.emit_signal("property::layout", awful.screen.focused().selected_tag)
end)

return wibox.widget {
	{
		{
			{
				menu,
				taglist,
				spacing = dpi(5),
				layout = wibox.layout.fixed.horizontal
			},
			nil,
			{
				systray,
				battery,
				clock,
				layoutbox,
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
