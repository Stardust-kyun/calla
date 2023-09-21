local awful = require("awful")
local wibox = require("wibox")
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
	font = user.fonticon,
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox
}

local prompt = wibox.widget {
	markup = "<span foreground='" .. beautiful.fg_normal .. "75'>enter password</span>",
	font = user.font,
	align = "center",
	widget = wibox.widget.textbox
}

local promptbox = wibox {
	width = dpi(450),
	height = dpi(185),
	bg = beautiful.bg_normal,
	ontop = true,
	visible = false,
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

-- Background

for s in screen do
background = wibox {
	visible = false,
	ontop = true,
	bgimage = beautiful.wallpaper,
	type = "splash",
	screen = s
}

awful.placement.maximize(background)

background:setup {
	layout = wibox.container.place
}
end

-- Visibile

local function visible(v)
	background.visible = v
	promptbox.visible = v
end

-- Reset

local function reset()
	characters_entered = 0;
	prompt.markup = "<span foreground='" .. beautiful.fg_normal .. "75'>enter password</span>"
	icon.markup = symbol
end

-- Fail

local function fail()
	characters_entered = 0;
	prompt.markup = "<span foreground='" .. beautiful.fg_urgent .. "'>try again</span>"
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
				prompt.markup = "<span foreground='" .. beautiful.fg_normal .. "'>" .. string.rep("", characters_entered) .. "</span>"
				icon.markup = symbol
			elseif key == "BackSpace" then
				if characters_entered > 1 then
					characters_entered = characters_entered - 1
					prompt.markup = "<span foreground='" .. beautiful.fg_normal .. "'>" .. string.rep("", characters_entered) .. "</span>"
				else
					characters_entered = 0
					prompt.markup = "<span foreground='" .. beautiful.fg_normal .. "75'>enter password</span>"
				end
				icon.markup = symbol
			end
		end,
		exe_callback = function(input)
			if authenticate(input) then
				reset()
				visible(false)
			else
				fail()
				grabpassword()
			end
		end,
		textbox = wibox.widget.textbox()
	}
end

-- Lock

function lockscreen()
	visible(true)
	grabpassword()
end

local function is_restart()
	awesome.register_xproperty("is_restart", "boolean")
	local restart_detected = awesome.get_xproperty("is_restart") ~= nil
	awesome.set_xproperty("is_restart", true)
	return restart_detected
end

if user.sessionlock and not is_restart() then
	lockscreen()
end
