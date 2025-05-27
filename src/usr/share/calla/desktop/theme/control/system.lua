local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local function systembutton(widget)
	return button({ 
				image = widget.icon, 
				height = dpi(30), 
				width = dpi(32), 
				run = widget.run
			})
end

local system = wibox.widget {
	{
		{
			systembutton({ 
				icon = "settings", 
				run = function() 
					awesome.emit_signal("widget::control")
					awesome.emit_signal("widget::config") 
				end
			}),
			systembutton({ 
				icon = "shutdown", 
				run = function() 
					awful.spawn.with_shell(user.shutdown)
				end
			}),
			systembutton({ 
				icon = "restart", 
				run = function() 
					awful.spawn.with_shell(user.reboot)
				end
			}),
			systembutton({ 
				icon = "exit", 
				run = function() 
					awesome.quit()
				end
			}),
			systembutton({ 
				icon = "lock", 
				run = function() 
					awesome.emit_signal("widget::control")
					awesome.emit_signal("widget::lockscreen")
				end
			}),
			spacing = dpi(10),
			layout = wibox.layout.fixed.horizontal
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	forced_width = dpi(220),
	forced_height = dpi(50),
	widget = background({ bg = "bgmid", fg = "fg" })
}

return system
