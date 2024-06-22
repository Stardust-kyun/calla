local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local pampath = require("gears").filesystem.get_configuration_dir() .. "liblua_pam.so"

-- Authentication

awful.spawn.easy_async_with_shell("stat "..pampath.." >/dev/null 2>&1", function (_, _, _, exitcode)
	if exitcode == 0 then
		authenticate = function(password)
			return password == user.passwd
		end
		local pam = require("liblua_pam")
		authenticate = function(password)
			return pam.auth_current_user(password)
		end
	else
		authenticate = function(password)
			return password == user.passwd
		end
	end
end)

-- Variables

local symbol = ""
local failsymbol = ""
local characters_entered = 0

-- Header

local titleicon = wibox.widget {
	{
		live(wibox.widget.imagebox, { image = "calla" }),
		forced_height = dpi(30),
		margins = dpi(5),
		widget = wibox.container.margin
	},
	shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, dpi(10))
			end,
	widget = live(wibox.container.background, { bg = "bgmid" })
}

local title = wibox.widget	{
	{
		colortext({ text = "Lockscreen" }),
		top = dpi(5),
		bottom = dpi(5),
		left = dpi(8),
		right = dpi(8),
		widget = wibox.container.margin
	},
	shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, dpi(10))
			end,
	widget = live(wibox.container.background, { bg = "bgmid" })
}

local time = wibox.widget.textclock("%I:%M %p")

awesome.connect_signal("live::reload", function()
	time.format = '<span foreground="' .. beautiful.fg .. '">%I:%M %P</span>'
end)

local clock = wibox.widget	{
	{
		time,
		top = dpi(5),
		bottom = dpi(5),
		left = dpi(8),
		right = dpi(8),
		widget = wibox.container.margin
	},
	shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, dpi(10))
			end,
	widget = live(wibox.container.background, { bg = "bgmid" })
}

-- Prompt

local icon = wibox.widget {
	font = user.fonticon,
	align = "center",
	valign = "center",
	widget = colortext({ text = symbol })
}

local prompt = wibox.widget {
	font = user.font,
	align = "center",
	widget = colortext({ text = "Enter Password", fg = "fg"..75 })
}

local promptbox = wibox {
	width = dpi(380),
	height = dpi(170),
	ontop = true,
	visible = false
}

promptbox:setup {
	{
		{
			{
				{
					{
						titleicon,
						title,
						spacing = dpi(5),
						layout = wibox.layout.fixed.horizontal
					},
					nil,
					clock,
					layout = wibox.layout.align.horizontal
				},
				margins = dpi(5),
				widget = wibox.container.margin
			},
			{
				{
					{
						{
							prompt,
							nil,
							icon,
							layout = wibox.layout.align.horizontal
						},
						top = dpi(10),
						bottom = dpi(10),
						left = dpi(15),
						right = dpi(15),
						forced_height = dpi(40),
						forced_width = dpi(300),
						widget = wibox.container.margin
					},
					shape = function(cr, width, height)
								gears.shape.rounded_rect(cr, width, height, dpi(10))
							end,
					widget = live(wibox.container.background, { bg = "bgmid" })
				},
				margins = dpi(40),
				widget = wibox.container.margin
			},
			layout = wibox.layout.align.vertical
		},
		valign = "top",
		layout = wibox.container.place
	},
	widget = live(wibox.container.background, { bg = "bg" })
}

awful.placement.centered(
	promptbox,
	{
		parent = awful.screen.focused()
	}
)

-- Background

local function createbackground(s)
	local background = wibox {
		screen = s,
		visible = false,
		ontop = true,
		type = "splash",
		widget = wibox.widget {
			{
				image = gears.surface.crop_surface {
					surface = gears.surface.load_uncached(beautiful.wallpaper),
					ratio = s.geometry.width/s.geometry.height
				},
				widget = wibox.widget.imagebox,
			},
			layout = wibox.container.place
		}
	}

	awesome.connect_signal("lockscreen::visible", function(v)
		background.visible = v
		promptbox.visible = v
	end)

	awesome.connect_signal("live::reload", function()
		background.widget = wibox.widget {
			{
				image = gears.surface.crop_surface {
					surface = gears.surface.load_uncached(beautiful.wallpaper),
					ratio = s.geometry.width/s.geometry.height
				},
				widget = wibox.widget.imagebox,
			},
			layout = wibox.container.place
		}
	end)

	return background
end

for s in screen do
	awful.placement.maximize(createbackground(s))
end

-- Reset

local function reset()
	characters_entered = 0;
	prompt.markup = markup({ text = "Enter Password", fg = "fg"..75 })
	icon.markup = markup({ text = symbol })
end

-- Fail

local function fail()
	characters_entered = 0;
	prompt.markup = markup({ text = "Try Again", fg = "red" })
	icon.markup = markup({ text = failsymbol, fg = "red" })
end

-- Input

local function grabpassword()
	awful.prompt.run {
		hooks = {
			{{ }, 'Escape', function(_)
					reset()
					grabpassword()
				end
			}
		},
		keypressed_callback  = function(mod, key, cmd)
			if #key == 1 then
				characters_entered = characters_entered + 1
				prompt.markup = markup({ text = string.rep("", characters_entered), fg = "fg" })
				icon.markup = markup({ text = symbol })
			elseif key == "BackSpace" then
				if characters_entered > 1 then
					characters_entered = characters_entered - 1
					prompt.markup = markup({ text = string.rep("", characters_entered), fg = "fg" })
				else
					characters_entered = 0
					prompt.markup = markup({ text = "Enter Password", fg = "fg"..75 })
				end
				icon.markup = markup({ text = symbol })
			end
		end,
		exe_callback = function(input)
			if authenticate(input) then
				reset()
				awesome.emit_signal("lockscreen::visible", false)
			else
				fail()
				grabpassword()
			end
		end,
		textbox = wibox.widget.textbox()
	}
end

-- Lock

awesome.connect_signal("widget::lockscreen", function()
	awesome.emit_signal("lockscreen::visible", true)
	grabpassword()
end)

local function is_restart()
	awesome.register_xproperty("is_restart", "boolean")
	local restart_detected = awesome.get_xproperty("is_restart") ~= nil
	awesome.set_xproperty("is_restart", true)
	return restart_detected
end

if user.sessionlock and not is_restart() then
	awesome.emit_signal("widget::lockscreen")
end
