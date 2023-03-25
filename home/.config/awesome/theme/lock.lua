local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local pampath = os.getenv("HOME").."/.config/awesome/liblua_pam.so"

local lockscreen = {}

lockscreen.init = function()

	-- Authentication
	awful.spawn.easy_async_with_shell("stat "..pampath.." >/dev/null 2>&1", function (_, __, ___, exitcode)
		if exitcode == 0 then
			lockscreen.authenticate = function(password)
				return password == passwd
			end
			local pam = require("liblua_pam")
			lockscreen.authenticate = function(password)
				return pam.auth_current_user(password)
			end
		else
			lockscreen.authenticate = function(password)
				return password == passwd
			end
		end
	end)

	-- Variables

	local symbol = ""
	local failsymbol = ""
	local characters_entered = 0

	-- Header

	local header = wibox.widget	{
		{
			{
				{
					text = "Lockscreen",
					valign = "center",
					widget = wibox.widget.textbox
				},
				forced_width = dpi(450),
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
	}

	-- Prompt

	local icon = wibox.widget {
		markup = symbol,
		font = fonticon,
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox
	}

	local prompt = wibox.widget {
		markup = "",
		font = fonticon,
		align = "center",
		widget = wibox.widget.textbox
	}

	local promptbox = wibox {
		width = dpi(450),
		height = dpi(185),
		bg = beautiful.bg_normal,
		ontop = true,
		visible = false,
		shape = function(cr, width, height)
			gears.shape.rectangle(cr, width, height)
		end
	}

	-- Background

	local background = wibox {
		fg = beautiful.fg_normal,
		bgimage = beautiful.wallpaper,
		visible = false,
		ontop = true,
		screen = screen.primary,
		type = "splash"
	}

	awful.placement.maximize(background)

	-- Visibile

	local function visible(v)
			background.visible = v
			promptbox.visible = v
	end

	-- Reset

	local function reset()
		characters_entered = 0;
		prompt.markup = ""
		icon.markup = symbol
	end

	-- Fail

	local function fail()
		characters_entered = 0;
		prompt.markup = ""
		icon.markup = "<span foreground='" .. beautiful.fg_urgent .. "'>" .. failsymbol .. "</span>"
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
					prompt.markup = string.rep("", characters_entered)
				elseif key == "BackSpace" then
					if characters_entered > 0 then
						characters_entered = characters_entered - 1
					end
					prompt.markup = string.rep("", characters_entered)
				end
			end,
			exe_callback = function(input)
				if lockscreen.authenticate(input) then
					reset()
					visible(false)
				else
					fail()
					grabpassword()
				end
			end,
			textbox = wibox.widget.textbox(),
		}
	end

	-- Lock

	function lock()
		visible(true)
		grabpassword()
	end

	-- Setup

	background:setup {
		layout = wibox.container.place
	}

	promptbox:setup {
		{
			header,
			{
				{
					{
						{
							{
								prompt,
								left = dpi(5),
								widget = wibox.container.margin
							},
							nil,
							{
								icon,
								right = dpi(5),
								widget = wibox.container.margin
							},
							layout = wibox.layout.align.horizontal,
							expand = "none"
						},
						margins = dpi(10),
						forced_height = dpi(45),
						widget = wibox.container.margin
					},
					bg = beautiful.bg_focus,
					widget = wibox.container.background
				},
				margins = dpi(50),
				widget = wibox.container.margin
			},
			layout = wibox.layout.align.vertical
		},
		valign = "top",
		layout = wibox.container.place
	}

	awful.placement.centered(
		promptbox,
		{
			parent = awful.screen.focused()
		}
	)

end

return lockscreen
