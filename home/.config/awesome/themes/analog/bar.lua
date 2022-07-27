local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi

wibox.widget.systray().horizontal = false

-- Buttons
textbutton = function(args)
	local text = args.text
	local size = args.size or dpi(10)
	local onclick = args.onclick or function() end
	
	local result = wibox.widget {
		text = text,
		font = "Material Icons " .. size,
		widget = wibox.widget.textbox
	}

	result:connect_signal("button::press", function() awful.spawn.with_shell(onclick) end)

	return result
end

menu = awful.menu(
	{ items = { 
	    { "Terminal", "st" },
		{ "Browser", "librewolf" },
		{ "Files", "nautilus" }
    }
})

launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = menu })

-- Battery
battery = awful.widget.watch("cat /sys/class/power_supply/BAT0/capacity", 10, function(widget, stdout)
			widget:set_text("BAT " .. stdout:gsub("\n", "") .. "%")
		end)

-- Clock
textclock = wibox.widget.textclock('%I\n%M')

-- Tags
screen.connect_signal("request::desktop_decoration", function(s)
	-- Layouts (why does this need to be in the bar config?)
	tag.connect_signal("request::default_layouts", function()
    	awful.layout.append_default_layouts({
    	    awful.layout.suit.tile,
			awful.layout.suit.floating,
			awful.layout.suit.max,
    	})
	end)

    -- One tag table per screen
    awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])

    -- Layout Widget
    s.layoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
        }
    }

	s.taglist = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.selected,
	}

	-- Tasklist widget
    s.tasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
		widget_template = {
			{
      	    	{
        	   	    id     = "text_role",
    	       	    widget = wibox.widget.textbox,
	           	},
				valign = "center",
				halign = "center",
				widget = wibox.container.place,
			},
   		   	id     = "background_role",
   	    	widget = wibox.container.background,
    	},
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
        },
		layout = {
			spacing = dpi(5),
			spacing_widget = {
				widget = wibox.container.background
			},
			layout = wibox.layout.fixed.vertical
		}
    }

    -- Wibox
    s.wibox = awful.wibar {
		border_width = dpi(10),
		border_color = beautiful.tasklist_bg_focus,
		position = "right",
		width = dpi(40),
		bg = beautiful.tasklist_bg_focus,
		fg = beautiful.fg_focus,
        screen   = s,
        widget   = {
            { -- Left
                layout = wibox.layout.fixed.vertical,
				spacing = dpi(30),
				{
					launcher,
					top = dpi(10),
					bottom = dpi(10),
					left = dpi(10),
					right = dpi(10),
					widget = wibox.container.margin
				},
				{ textbutton{ text = "", size = "15", onclick = "librewolf" }, valign = "center", widget = wibox.container.place },
				{ textbutton{ text = "", size = "15", onclick = "st" }, valign = "center", widget = wibox.container.place },
				{ textbutton{ text = "", size = "15", onclick = "nautilus" }, valign = "center", widget = wibox.container.place },
				{ s.taglist, valign = "center", widget = wibox.container.place },
            },
			{ -- Middle
          		layout = wibox.layout.fixed.vertical,
				-- s.tasklist
			},
            { -- Right
                layout = wibox.layout.fixed.vertical,
				spacing = dpi(15),
				{
                	wibox.widget.systray(),
					left = dpi(5),
					right = dpi(5),
					top = dpi(10),
					widget = wibox.container.margin
				},
				{ battery, valign = "center", widget = wibox.container.place },
				{ textclock, valign = "center", widget = wibox.container.place },
				{
					s.layoutbox,
					left = dpi(10),
					right = dpi(10),
					top = dpi(5),
					bottom = dpi(10),
					widget = wibox.container.margin
				},
            },
			layout = wibox.layout.align.vertical
        }
    }
end)
