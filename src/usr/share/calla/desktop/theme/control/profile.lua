local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local margins = dpi(0)
if beautiful.pfp == beautiful.calla then
	margins = dpi(10)
end

local profile = wibox.widget {
	{
		{
			{
				{
					{
						image = beautiful.pfp,
						upscale = false,
						downscale = true,
						valign = "center",
						halign = "center",
						clip_shape = function(cr, width, height)
							gears.shape.rounded_rect(cr, width, height, dpi(5))
						end,
						widget = live(wibox.widget.imagebox, { image = "pfp" })
					},
					margins = margins,
					widget = wibox.container.margin
				},
				forced_width = dpi(90),
				widget = background({ bg = "bgalt" })
			},
			{
				{
					{
						id = "name",
						text = "User Name",
						font = user.font:gsub("%d+", "14"),
						widget = wibox.widget.textbox
					},
					{
						id = "host",
						text = "@calla",
						widget = wibox.widget.textbox
					},
					spacing = dpi(5),
					layout = wibox.layout.fixed.vertical
				},
				valign = "center",
				widget = wibox.container.place
			},
			spacing = dpi(10),
			layout = wibox.layout.fixed.horizontal
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	forced_width = dpi(220),
	forced_height = dpi(110),
	widget = background({ bg = "bgmid", fg = "fg" })
}

awful.spawn.easy_async_with_shell("getent passwd $(whoami) | cut -d ':' -f 5", function(out)
	profile:get_children_by_id("name")[1].text = out:gsub(",", ""):gsub("\n", "")
end)
awful.spawn.easy_async_with_shell("hostname", function(out)
	profile:get_children_by_id("host")[1].text = "@" .. out:gsub("\n", "")
end)

return profile
