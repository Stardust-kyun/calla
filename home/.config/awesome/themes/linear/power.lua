local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local powerDisplay = wibox {
	width = dpi(315),
	height = dpi(115),
	bg = beautiful.bg_normal,
	ontop = true,
	visible = false,
	shape = function(cr, width, height)
		gears.shape.rectangle(cr, width, height)
	end
}

local header = wibox.widget {
	text = "Power",
	valign = "center",
	widget = wibox.widget.textbox
}

local textbutton = function(args)
	local text = args.text
	local size = args.size or dpi(10)
	local onclick = args.onclick or function() end
	
	local result = wibox.widget {
		{
			text = text,
			font = "Material Icons " .. size,
			forced_height = dpi(45),
			forced_width = dpi(45),
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox
		},
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	}

	result:connect_signal("button::press", function() 
			awesome.emit_signal("widget::power")
			awful.spawn.with_shell(onclick) 
	end)

	return result
end

powerDisplay:setup {
	{
		{
			{
				{
					header,
					forced_width = dpi(285),
					layout = wibox.layout.align.horizontal,
				},
				left = dpi(15),
				right = dpi(15),
				top = dpi(10),
				bottom = dpi(10),
				widget = wibox.container.margin
			},
			bg = beautiful.bg_focus,
			widget = wibox.container.background
		},
		{
			{
				{
					{
						textbutton{ text="", size="15", onclick="light-locker-command -l" },
						right = dpi(15),
						widget = wibox.container.margin
					},
					textbutton{ text="", size="15", onclick="light-locker-command -s"},
					layout = wibox.layout.align.horizontal
				},
				{
					textbutton{ text="", size="15", onclick="awesome-client command 'awesome.quit()'"},
					expand = "none",
					layout = wibox.layout.align.horizontal
				},
				{
					{
						textbutton{ text="", size="15", onclick=shutdown },
						right = dpi(15),
						widget = wibox.container.margin
					},
					textbutton{ text="", size="15", onclick=reboot },
					layout = wibox.layout.align.horizontal
				},
				expand = "none",
				layout = wibox.layout.align.horizontal
			},
			top = dpi(15),
			left = dpi(15),
			right = dpi(15),
			widget = wibox.container.margin
		},
		layout = wibox.layout.align.vertical
	},
	valign = "top",
	layout = wibox.container.place
}

awesome.connect_signal("widget::power", function()
	powerDisplay.visible = not powerDisplay.visible
	
	awful.placement.centered(
		powerDisplay, 
		{
			parent = awful.screen.focused()
		}
	)
end)
