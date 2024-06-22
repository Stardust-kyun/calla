local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local ruled = require("ruled")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Config

naughty.config.defaults.ontop = true
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = "top_right"
naughty.config.defaults.title = "Notification"

-- Rules

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

	awesome.connect_signal("live::reload", function()
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
end)

-- Notification

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
									{
										naughty.widget.title,
										layout = wibox.layout.align.horizontal
									},
									top = dpi(5),
									bottom = dpi(5),
									left = dpi(10),
									right = dpi(10),
									widget = wibox.container.margin
								},
								shape = function(cr, width, height)
											gears.shape.rounded_rect(cr, width, height, dpi(10))
										end,
								widget = live(wibox.container.background, { bg = "bgmid" })
							},
							margins = dpi(5),
							widget = wibox.container.margin
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
							bottom = dpi(10),
							left = dpi(15),
							right = dpi(15),
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
