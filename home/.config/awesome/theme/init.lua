local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

screen.connect_signal("request::wallpaper", function(s)
	awesome.connect_signal("live::reload", function()
		awful.wallpaper {
			screen = s,
			widget = {
				image = gears.surface.crop_surface {
					surface = gears.surface.load_uncached(beautiful.wallpaper),
					ratio = s.geometry.width/s.geometry.height
				},
				widget = wibox.widget.imagebox
			}
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

function hovercursor(widget)
	local oldcursor, oldwibox
	widget:connect_signal("mouse::enter", function()
		local wb = mouse.current_wibox
		if wb == nil then return end
		oldcursor, oldwibox = wb.cursor, wb
		wb.cursor = "hand2"
	end)
	widget:connect_signal("mouse::leave", function()
		if oldwibox then
			oldwibox.cursor = oldcursor
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
	local text = table.text or "N/A"
	local textbox = wibox.widget {
		markup = markup({ text = text, fg = fg }),
		widget = wibox.widget.textbox
	}

	awesome.connect_signal("live::reload", function()
		textbox.markup = markup({ text = text, fg = fg })
	end)

	return textbox
end

function button(widget)
	local img

	if widget.type == "text" then
		img = wibox.widget {
			markup = '<span foreground="' .. beautiful.fg .. '">' .. widget.image .. '</span>',
			font = widget.font or user.fonticon,
			align = "center",
			widget = wibox.widget.textbox
		}

		awesome.connect_signal("live::reload", function()
			img.markup = '<span foreground="' .. beautiful.fg .. '">' .. widget.image .. '</span>'
		end)
	elseif widget.type == "image" then
		img = wibox.widget.imagebox(widget.image)
	else
		img = live(wibox.widget.imagebox, { image = "calla" })
	end
	

	if widget.size then
		width = widget.size
		height = widget.size
	else
		if widget.height then
			height = widget.height
		else
			height = dpi(40)
		end

		if widget.width then
			width = widget.width
		else
			width = dpi(40)
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
		buttons = { 
			awful.button({}, 1, widget.run)},
		shape = function(cr, width, height)
					gears.shape.rounded_rect(cr, width, height, dpi(10))
				end,
		widget = live(wibox.container.background, { bg = "bgmid" })
	})

	return button
end

--require("theme.desktop")
require("theme.notif")
require("theme.panel")
require("theme.title")
require("theme.volume")
require("theme.brightness")
require("theme.launcher")
require("theme.lock")
require("theme.settings")
require("theme.preview")
