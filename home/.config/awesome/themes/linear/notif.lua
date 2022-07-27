local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local naughty = require("naughty")
local wibox = require("wibox")
local ruled = require("ruled")
local time = wibox.widget.textclock("%I:%M %p")

naughty.config.defaults.ontop = true
naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = "top_right"
naughty.config.defaults.title = "Notification"

ruled.notification.connect_signal('request::rules', function()
	-- Critical
    ruled.notification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = beautiful.bg_normal, fg = beautiful.fg_urgent, timeout = 0 }
    }

	-- Normal
    ruled.notification.append_rule {
        rule       = { urgency = 'normal' },
        properties = { bg = beautiful.bg_normal, fg = beautiful.fg_normal, timeout = 5 }
    }

	-- Low
    ruled.notification.append_rule {
        rule       = { urgency = 'low' },
        properties = { bg = beautiful.bg_normal, fg = beautiful.fg_normal, timeout = 5 }
    }
end)

naughty.connect_signal("request::display", function(n)
	naughty.layout.box {
		notification = n,
		type = "notification",
		bg = beautiful.bg_normal,
		widget_template = {
			{
				{
					{
						{
							{
								{
									naughty.widget.title,
									forced_height = dpi(38),
									layout = wibox.layout.align.horizontal
								},
								left = dpi(15),
								right = dpi(15),
								widget = wibox.container.margin
							},
							bg = beautiful.bg_focus,
							widget = wibox.container.background
						},
						strategy = "min",
						width = dpi(300),
						widget = wibox.container.constraint
					},
					strategy = "max",
					width = dpi(400),
					widget = wibox.container.constraint
				},
				{
					{
						{
							naughty.widget.message,
							left = dpi(15),
							right = dpi(15),
							top = dpi(15),
							bottom = dpi(15),
							widget = wibox.container.margin
						},
						strategy = "min",
						height = dpi(60),
						widget = wibox.container.constraint
					},
					strategy = "max",
					width = dpi(400),
					widget = wibox.container.constraint
				},
				layout = wibox.layout.align.vertical
			},	
			id = "background_role",
			widget = naughty.container.background
		}
	}
end)
