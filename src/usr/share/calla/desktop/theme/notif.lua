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
	local function setrules()
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
	end

	setrules()

	awesome.connect_signal("live::reload", function()
		setrules()
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
									margins = dpi(10),
									widget = wibox.container.margin
								},
								shape = function(cr, width, height)
											gears.shape.rounded_rect(cr, width, height, dpi(10))
										end,
								widget = live(wibox.container.background, { bg = "bgmid" })
							},
							strategy = "min",
							width = dpi(250),
							widget = wibox.container.constraint
						},
						{
								naughty.widget.message,
								margins = dpi(5),
								widget = wibox.container.margin
						},
						spacing = dpi(5),
						layout = wibox.layout.fixed.vertical
					},
					strategy = "max",
					width = dpi(400),
					widget = wibox.container.constraint
				},
				margins = dpi(10),
				widget = wibox.container.margin
			},	
			id = "background_role",
			widget = naughty.container.background
		}
	}
end)
