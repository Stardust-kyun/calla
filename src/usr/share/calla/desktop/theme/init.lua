local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

screen.connect_signal("request::desktop_decoration", function(s)
	awesome.connect_signal("live::reload", function()
		awful.wallpaper {
			screen = s,
			bg = beautiful.bg
		}
	end)
end)

function live(w, properties)
    local widget = w()

	for property, arg in pairs(properties) do
		widget[property] = beautiful[arg]
	end

    awesome.connect_signal("live::reload", function()
		for property, arg in pairs(properties) do
			widget[property] = beautiful[arg]
		end
        widget:emit_signal("widget::redraw_needed")
    end)

    return widget
end

function background(properties)
	return wibox.widget {
		shape = function(cr, width, height)
					gears.shape.rounded_rect(cr, width, height, dpi(10))
				end,
		widget = live(wibox.container.background, properties)
	}
end

function hovercursor(widget)
	--local oldcursor, oldwibox, oldbg
	local oldcursor, oldwibox
	widget:connect_signal("mouse::enter", function()
		local wb = mouse.current_wibox
		if wb == nil then return end
		--oldcursor, oldwibox, oldbg = wb.cursor, wb, wb.bg
		oldcursor, oldwibox = wb.cursor, wb
		wb.cursor = "hand2"
		--widget.bg = beautiful.fg .. "20"
	end)
	widget:connect_signal("mouse::leave", function()
		if oldwibox then
			oldwibox.cursor = oldcursor
			--widget.bg = oldbg
			oldwibox = nil
		end
	end)
	return widget
end

function markup(args)
	local fg = beautiful[args.fg] or beautiful.fg
	local text = '<span foreground="' .. fg .. '">' .. args.text .. '</span>'
	return text
end

function colortext(args)
	local table = args or {}
	local fg = beautiful[table.fg] or beautiful.fg
	local font = table.font or user.font
	local text = table.text or "N/A"
	local textbox = wibox.widget {
		markup = markup({ text = text, fg = fg }),
		font = font,
		widget = wibox.widget.textbox
	}

	awesome.connect_signal("live::reload", function()
		textbox.markup = markup({ text = text, fg = fg })
	end)

	return textbox
end

function createicon(image)
	local icon = gears.color.recolor_image(gears.filesystem.get_configuration_dir() .. "theme/icons/" .. image .. ".svg", beautiful.fg)

	awesome.connect_signal("live::reload", function()
		icon = gears.color.recolor_image(gears.filesystem.get_configuration_dir() .. "theme/icons/" .. image .. ".svg", beautiful.fg)
	end)

	return icon
end

function iconbox(widget)
	local size = dpi(18)
	if widget.size then size = widget.size end
	local icon = wibox.widget {
		image = gears.color.recolor_image(gears.filesystem.get_configuration_dir() .. "theme/icons/" .. widget.image .. ".svg", beautiful.fg),
		forced_width = size,
		forced_height = size,
		upscale = false,
		downscale = true,
		valign = "center",
		halign = "center",
		widget = wibox.widget.imagebox
	}

	awesome.connect_signal("live::reload", function()
		icon.image = gears.color.recolor_image(gears.filesystem.get_configuration_dir() .. "theme/icons/" .. widget.image .. ".svg", beautiful.fg)
	end)

	return icon
end

function button(widget)
	local img = iconbox({ image = widget.image })

	if widget.size then
		width = widget.size
		height = widget.size
	else
		if widget.height then
			height = widget.height
		else
			height = dpi(30)
		end

		if widget.width then
			width = widget.width
		else
			width = dpi(30)
		end
	end

	local button = hovercursor(wibox.widget {
		{
			img,
			margins = dpi(5),
			widget = wibox.container.margin
		},
		forced_width = width,
		forced_height = height,
		buttons = { awful.button({}, 1, widget.run) },
		widget = background({ bg = "bgmid" })
	})

	return button
end

require("theme.desktop")
require("theme.notif")
require("theme.title")
require("theme.volume")
require("theme.brightness")
require("theme.launcher")
require("theme.lock")
require("theme.settings")
require("theme.preview")
require("theme.control")
