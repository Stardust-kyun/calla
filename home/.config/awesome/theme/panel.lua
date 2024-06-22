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

	-- Tasklist
	
	s.tasklist = awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		style = {
			shape = function(cr, width, height)
						gears.shape.rounded_rect(cr, width, height, dpi(10))
					end
		},
		layout = {
			spacing = dpi(5),
			spacing_widget = wibox.container.background,
			layout = wibox.layout.fixed.horizontal
		},
		widget_template = {
			{
				awful.widget.clienticon,
				margins = dpi(5),
				widget = wibox.container.margin
			},
			id = "background_role",
			widget = wibox.container.background
		},
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "focus" }
            end),
            awful.button({ }, 3, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
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
		height = dpi(40),
		bg = beautiful.bg,
		fg = beautiful.fg,
		margins = {
			left = dpi(16),
			right = dpi(16),
			bottom = dpi(16)
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
					s.tasklist,
					valign = "center",
					widget = wibox.container.place
				},
				widget = wibox.layout.stack
			},
			margins = dpi(5),
			widget = wibox.container.margin
        }
    }

	awesome.connect_signal("live::reload", function()
		s.wibar:set_bg(beautiful.bg)
		s.wibar:set_fg(beautiful.fg)
		s.taglist._do_taglist_update_now()
		s.tasklist._do_tasklist_update_now()
		client.emit_signal("property::icon")
		tag.emit_signal("property::layout", awful.screen.focused().selected_tag)
	end)
end)
