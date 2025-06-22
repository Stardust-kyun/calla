local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local media = require("theme.control.media")
local sliders = require("theme.control.sliders")
local toggles = require("theme.control.toggles")
local system = require("theme.control.system")
local profile = require("theme.control.profile")
local calendar = require("theme.control.calendar")
local notifs = require("theme.control.notifs")

local controlbox = wibox {
	width = dpi(470),
	height = dpi(360),
	ontop = true,
	visible = false,
	widget = {
		{
			{
				media,
				{
					sliders,
					toggles,
					system,
					spacing = dpi(10),
					layout = wibox.layout.fixed.vertical
				},
				spacing = dpi(10),
				layout = wibox.layout.fixed.horizontal
			},
			margins = dpi(10),
			widget = wibox.container.margin
		},
		widget = background({ bg = "bg" })
	}
}

local infobox = wibox {
	width = dpi(470),
	height = dpi(360),
	ontop = true,
	visible = false,
	widget = {
		{
			{
				{
					profile,
					calendar,
					spacing = dpi(10),
					layout = wibox.layout.fixed.vertical
				},
				notifs,
				spacing = dpi(10),
				layout = wibox.layout.fixed.horizontal
			},
			margins = dpi(10),
			widget = wibox.container.margin
		},
		widget = background({ bg = "bg" })
	}
}

awesome.connect_signal("widget::control", function()
	controlbox.visible = not controlbox.visible
	infobox.visible = not infobox.visible

	if client.focus and client.focus.fullscreen == true then
		awful.placement.bottom_right(
			controlbox,
			{
				margins = {
					bottom = dpi(10),
					right = dpi(10)
				},
				parent = awful.screen.focused()
			}
		)
		awful.placement.bottom_right(
			infobox,
			{
				margins = {
					bottom = dpi(380),
					right = dpi(10)
				},
				parent = awful.screen.focused()
			}
		)
	else
		awful.placement.bottom_right(
			controlbox,
			{
				margins = {
					bottom = dpi(60),
					right = dpi(20)
				},
				parent = awful.screen.focused()
			}
		)
		awful.placement.bottom_right(
			infobox,
			{
				margins = {
					bottom = dpi(430),
					right = dpi(20)
				},
				parent = awful.screen.focused()
			}
		)
	end
end)

