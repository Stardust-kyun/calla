local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Menu

local menu = button {
	size = dpi(30),
	run = function()
		awesome.emit_signal('widget::launcher')
	end
}

-- Media

local function musicbutton(args)
	return hovercursor(wibox.widget {
		text = args.text,
		font = user.fonticon,
		buttons = { awful.button({}, 1, args.run) },
		widget = wibox.widget.textbox
	})
end

local media = wibox.widget {
	{
		{
			{
				musicbutton({ text = "", run = function() awful.spawn.with_shell("playerctl previous") end }),
				{
					id = "pause",
					widget = musicbutton({ text = "", run = function() awful.spawn.with_shell("playerctl play-pause") end })
				},
				musicbutton({ text = "", run = function() awful.spawn.with_shell("playerctl next") end }),
				layout = wibox.layout.fixed.horizontal
			},
			{
				id = "title",
				widget = wibox.widget.textbox()
			},
			spacing = dpi(5),
			layout = wibox.layout.fixed.horizontal
		},
		top = dpi(5),
		bottom = dpi(5),
		left = dpi(5),
		right = dpi(10),
		widget = wibox.container.margin
	},
	shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, dpi(10))
			end,
	widget = live(wibox.container.background, { bg = "bgmid" })
}

awesome.connect_signal("signal::playerctl", function(title, album, artist, status)
	media:get_children_by_id("title")[1].text = title .. " - " .. artist
	if status then
		media:get_children_by_id("pause")[1].text = ""
	else
		media:get_children_by_id("pause")[1].text = ""
	end
end)

-- Systray
-- TODO: This can probably be slimmed a lot

local tray = wibox.widget {
	wibox.widget.systray(),
	margins = 0,
	visible = false,
	widget = wibox.container.margin
}

local systraytext = wibox.widget {
	text = "",
	font = "Material Icons 14",
	align = "center",
	widget = wibox.widget.textbox
}

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
		systraytext.text = ""
		closed = false
	else
		tray.visible = false
		tray.margins = 0
		systraytext.text = ""
		closed = true
	end
end)

-- Battery

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

-- Clock

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
	widget = live(wibox.container.background, { bg = "bgmid" })
}

-- Screen

screen.connect_signal("request::desktop_decoration", function(s)

	-- Taglist

	s.taglist = awful.widget.taglist {
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
					wibox.widget.textbox("Workspace "),
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

    -- Layouts

    s.layouts = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
        }
    }

	s.layoutbox = hovercursor(wibox.widget {
		{
			s.layouts,
			margins = dpi(5),
			widget = wibox.container.margin
		},
		shape = function(cr, width, height)
					gears.shape.rounded_rect(cr, width, height, dpi(10))
				end,
		widget = live(wibox.container.background, { bg = "bgmid" })
	})

    -- Panel

    s.wibar = awful.wibar {
		position = "bottom",
		align = "left",
		height = dpi(40),
		width = ((s:get_bounding_geometry().width-dpi(20))*5)/6-dpi(10),
		bg = beautiful.bg,
		fg = beautiful.fg,
		margins = {
			left = dpi(10),
			bottom = dpi(10)
		},
        screen = s,
        widget = {
			{
				{
					{
						menu,
						s.taglist,
						spacing = dpi(5),
						layout = wibox.layout.fixed.horizontal
					},
					nil,
					{
						systray,
						battery,
						clock,
						s.layoutbox,
						spacing = dpi(5),
						layout = wibox.layout.fixed.horizontal
					},
					layout = wibox.layout.align.horizontal
				},
				{
					media,
					valign = "center",
					layout = wibox.container.place
				},
				layout = wibox.layout.stack
			},
			margins = dpi(5),
			widget = wibox.container.margin
        }
    }

	awesome.connect_signal("live::reload", function()
		s.wibar:set_bg(beautiful.bg)
		s.wibar:set_fg(beautiful.fg)
		s.taglist._do_taglist_update_now()
		client.emit_signal("property::icon")
		tag.emit_signal("property::layout", awful.screen.focused().selected_tag)
	end)
end)
