local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local function decorate(widget, flag, date)
	local retbg
	if flag == "focus" then retbg = beautiful.fg .. "33" else retbg = beautiful.bgmid end
	local ret = wibox.widget {
		{
			widget,
			halign = "center",
			valign = "center",
			fill_horizontal = true,
			fill_vertical = true,
			widget = wibox.container.place
		},
		bg = retbg,
		widget = background({ fg = "fg" })
	}
	awesome.connect_signal("live::reload", function()
		if flag == "focus" then retbg = beautiful.fg .. "33" else retbg = beautiful.bgmid end
		ret.bg = retbg
	end)
	return ret
end

local calendar = wibox.widget {
	{
		{
			font = user.font,
			start_sunday = true,
			flex_height = true,
			fn_embed = decorate,
			widget = wibox.widget.calendar.month(os.date("*t"))
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	forced_width = dpi(220),
	forced_height = dpi(220),
	widget = background({ bg = "bgmid", fg = "fg" })
}

return calendar
