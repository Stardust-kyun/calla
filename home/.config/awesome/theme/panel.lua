local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Menu

local menu = wibox.widget {
	buttons = {
		awful.button({}, 1, function()
			awesome.emit_signal('widget::menu')
		end) 
	},
	image = beautiful.awesome_icon,
	widget = wibox.widget.imagebox
}

-- Clock

local clock = wibox.widget.textclock('%I:%M %p')

-- Window controls

local minimize = wibox.widget {
	image = beautiful.minimize,
	buttons = {
		awful.button({ }, 1, function()
			client.focus.minimized = true
		end)
	},
	widget = wibox.widget.imagebox
}

local maximize = wibox.widget {
	image = beautiful.maximize,
	buttons = {
		awful.button({ }, 1, function()
			client.focus.maximized = not client.focus.maximized
		end)
	},
	widget = wibox.widget.imagebox
}

local close = wibox.widget {
	image = beautiful.close,
	buttons = {
		awful.button({ }, 1, function()
			client.focus:kill()
		end)
	},
	widget = wibox.widget.imagebox
}

if panelcontrols then
	panelcontrols = wibox.widget {
		{
			minimize,
			maximize,
			close,
			spacing = dpi(15),
			layout = wibox.layout.fixed.horizontal
		},
		top = dpi(4),
		bottom = dpi(4),
		widget = wibox.container.margin
	}
end

-- Screen

screen.connect_signal("request::desktop_decoration", function(s)

	-- Taglist

	s.taglist = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = {
			awful.button({ }, 1, function(t) 
				t:view_only() 
			end)
		}
	}

	-- Tasklist

    s.tasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
		widget_template = {
			{
      	    	{
        	   	    id     = "text_role",
					forced_height = dpi(20),
    	       	    widget = wibox.widget.textbox
	           	},
				valign = "center",
				halign = "center",
				widget = wibox.container.place
			},
			id     = "background_role",
			widget = wibox.container.background
    	},
        buttons = {
            awful.button({ }, 1, function (c)
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

    -- Panel

    s.wibar = awful.wibar {
		border_width = dpi(5),
		border_color = beautiful.bg_normal,
		position = "bottom",
		height = dpi(40),
		bg = beautiful.bg_normal,
		fg = beautiful.fg_normal,
        screen = s,
        widget = {
			{
				{
					menu,
					s.taglist,
					spacing = dpi(20),
					layout = wibox.layout.fixed.horizontal
				},
				s.tasklist,
				{
					clock,
					panelcontrols,
					s.layouts,
					spacing = dpi(15),
					layout = wibox.layout.fixed.horizontal
				},
				layout = wibox.layout.align.horizontal
			},
			margins = dpi(10),
			widget = wibox.container.margin
        }
    }
end)
