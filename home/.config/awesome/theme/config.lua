local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local configdisplay = wibox {
	width = dpi(830),
	height = dpi(670),
	bg = beautiful.bg_normal,
	ontop = true,
	visible = false
}

local header = wibox.widget	{
	{
		{
			text = "Config",
			valign = "center",
			widget = wibox.widget.textbox
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

local cancel = hovercursor(wibox.widget {
	{
		text = "Cancel",
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox
	},	
	buttons = {
		awful.button({}, 1, function()
			awesome.emit_signal("widget::config")	
		end)
	},
	forced_width = dpi(90),
	forced_height = dpi(50),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
})

local done = hovercursor(wibox.widget {
	{
		text = "Done",
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox
	},	
	buttons = {
		awful.button({}, 1, function()
			local w = assert(io.open(".config/awesome/json/user.json", "w"))
			w:write(require("json"):encode_pretty(user, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true }))
			w:close()

			awesome.restart()
		end)
	},
	forced_width = dpi(90),
	forced_height = dpi(50),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
})

-- Functions

local function toggle(name, varname, var)

	local state = var

	local text = wibox.widget {
		text = tostring(var),
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox
	}

	local button = hovercursor(wibox.widget {
		text,
		forced_width = dpi(90),
		forced_height = dpi(50),
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	})

	button:buttons {
		awful.button({}, 1, function()
			state = not state				
			text.text = tostring(state)
			user[varname] = state
		end)
	}

	local toggle = wibox.widget {
		{
			text = name,
			valign = "center",
			align = "right",
			forced_width = dpi(160),
			widget = wibox.widget.textbox
		},
		button,
		spacing = dpi(15),
		layout = wibox.layout.fixed.horizontal
	}

	return toggle

end

local function inputbox(name, varname, var, default)

	local text = wibox.widget {
		text = var,
		widget = wibox.widget.textbox
	}

	local function input()
		awful.prompt.run {
			textbox = text,
			exe_callback = function(input)
				if not input or #input == 0 then 
					text.text = var
					return
				end
				text.text = input
				user[varname] = input
			end
		}
	end

	local box = hovercursor(wibox.widget {
		{
			text,
			margins = dpi(15),
			widget = wibox.container.margin
		},
		buttons = {
			awful.button({}, 1, function()
				input()
			end)
		},
		forced_height = dpi(50),
		forced_width = dpi(415),
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	})

	local default = hovercursor(wibox.widget {
		{
			text = "Default",
			valign = "center",
			align = "center",
			widget = wibox.widget.textbox
		},
		buttons = {
			awful.button({}, 1, function()
				text.text = default
				user[varname] = default
			end)
		},
		forced_width = dpi(90),
		forced_height = dpi(50),
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	})


	local inputbox = wibox.widget {
		{
			text = name,
			valign = "center",
			align = "right",
			forced_width = dpi(160),
			widget = wibox.widget.textbox
		},
		box,
		default,
		spacing = dpi(15),
		layout = wibox.layout.fixed.horizontal
	}

	return inputbox

end

local function guiselect(name, varname, var, default, class)

	local pathtext, pathcommand

	if class == "file" then
		pathtext = "choose file..."
		pathcommand = "yad --file --add-preview --large-preview --title='select a file' --file-filter='image | *.png *.jpg *.jpeg' --width=850 --height=700"
		--pathcommand = "zenity --file-selection --title='Select a File' --file-filter='Image | *.png *.jpg *.jpeg'"
	elseif class == "dir" then
		pathtext = "choose directory..."
		pathcommand = "yad --file --title='Select a Directory' --directory --width=850 --height=700"
		--pathcommand = "zenity --file-selection --title='Select a Directory' --directory"
	end

	local path = wibox.widget {
		text = var or pathtext,
		valign = "center",
		widget = wibox.widget.textbox
	}

	local box = wibox.widget {
		{
			path,
			margins = dpi(15),
			widget = wibox.container.margin
		},
		forced_width = dpi(415),
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	}

	local default = hovercursor(wibox.widget {
		{
			text = "Default",
			valign = "center",
			align = "center",
			widget = wibox.widget.textbox
		},
		buttons = {
			awful.button({}, 1, function()
				if default == nil then
					path.text = pathtext
				else
					path.text = default
				end
				user[varname] = default
			end)
		},
		forced_width = dpi(90),
		forced_height = dpi(50),
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	})

	local browse = hovercursor(wibox.widget {
		{
			text = "Browse",
			valign = "center",
			align = "center",
			widget = wibox.widget.textbox
		},
		buttons = {
			awful.button({}, 1, function()
				awful.spawn.easy_async_with_shell(pathcommand, function(out)
					if out == "" then
						return
					else
						local outtext = out:gsub("\n", "")
						path.text = outtext
						user[varname] = outtext
					end
				end)
			end)
		},
		forced_width = dpi(90),
		forced_height = dpi(50),
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	})

	local guiselect = wibox.widget {
		{
			text = name,
			valign = "center",
			align = "right",
			forced_width = dpi(160),
			widget = wibox.widget.textbox
		},
		box,
		default,
		browse,
		spacing = dpi(15),
		layout = wibox.layout.fixed.horizontal
	}

	return guiselect

end

-- Modkey

local alt = hovercursor(wibox.widget {
	{
		text = "Alt",
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox
	},
	forced_width = dpi(90),
	forced_height = dpi(50),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
})

local super = hovercursor(wibox.widget {
	{
		text = "Super",
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox
	},
	forced_width = dpi(90),
	forced_height = dpi(50),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
})

alt:buttons {
	awful.button({}, 1, function()
		alt.fg = beautiful.fg_normal
		super.fg = beautiful.fg_normal .. "75"
		user["mod"] = "Mod1"
	end)
}

super:buttons {
	awful.button({}, 1, function()
		alt.fg = beautiful.fg_normal .. "75"
		super.fg = beautiful.fg_normal
		user["mod"] = "Mod4"
	end)
}

if user.mod == "Mod1" then
	alt.fg = beautiful.fg_normal
	super.fg = beautiful.fg_normal .. "75"
else
	alt.fg = beautiful.fg_normal .. "75"
	super.fg = beautiful.fg_normal
end

local modkey = wibox.widget {
	{
		text = "Modkey",
		valign = "center",
		align = "right",
		forced_width = dpi(160),
		widget = wibox.widget.textbox
	},
	alt,
	super,
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal
}

-- Colors

local function colorgen()
	local colors = {}

	for dir in io.popen([[ls -d .config/awesome/color/*/ | cut -f4 -d'/']]):lines() do
		table.insert(colors, dir)
	end

	return colors
end

local colorentries = colorgen()

local colorpos = 1

local colorname = wibox.widget {
	text = colorentries[colorpos],
	widget = wibox.widget.textbox
}

local colorprev = hovercursor(wibox.widget {
	text = "",
	font = user.fonticon,
	buttons = {
		awful.button({}, 1, function()
			if colorpos ~= 1 then
				colorpos = colorpos - 1
				colorname.text = colorentries[colorpos]
			end
		end)
	},
	widget = wibox.widget.textbox
})

local colornext = hovercursor(wibox.widget {
	text = "",
	font = user.fonticon,
	buttons = {
		awful.button({}, 1, function()
			if colorpos ~= #colorentries then
				colorpos = colorpos + 1
				colorname.text = colorentries[colorpos]
			end
		end)
	},
	widget = wibox.widget.textbox
})

local colorapply = hovercursor(wibox.widget {
	{
		text = "Apply",
		valign = "center",
		align = "center",
		widget = wibox.widget.textbox
	},
	buttons = {
		awful.button({}, 1, function()
			awful.spawn.easy_async_with_shell("~/.config/awesome/color/" .. colorentries[colorpos] .. "/" .. colorentries[colorpos] .. ".sh")
			user.color = colorentries[colorpos]
			local w = assert(io.open(".config/awesome/json/user.json", "w"))
			w:write(require("json"):encode_pretty(user, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true }))
			w:close()
			awesome.restart()
		end)
	},
	forced_height = dpi(50),
	forced_width = dpi(90),
	bg = beautiful.bg_focus,
	widget = wibox.container.background
})

local color = wibox.widget {
	{
		text = "Color Scheme",
		valign = "center",
		align = "right",
		forced_width = dpi(160),
		widget = wibox.widget.textbox
	},
	{
		{
			{
				colorprev,
				{
					colorname,
					halign = "center",
					widget = wibox.container.place
				},
				colornext,
				layout = wibox.layout.align.horizontal
			},
			margins = dpi(15),
			widget = wibox.container.margin
		},
		forced_height = dpi(50),
		forced_width = dpi(415),
		bg = beautiful.bg_focus,
		widget = wibox.container.background
	},
	colorapply,
	spacing = dpi(15),
	layout = wibox.layout.fixed.horizontal
}

-- General

local general = wibox.widget {
	guiselect("Screenshots", "shotdir", user.shotdir, "~/Pictures/Screenshots/", "dir"),
	inputbox("Battery", "batt", user.batt, "BAT0"),
	inputbox("Fallback Password", "passwd", user.passwd, "awesomewm"),
	modkey,
	toggle("Lock at Login", "sessionlock", user.sessionlock),
	visible = true,
	spacing = dpi(15),
	layout = wibox.layout.fixed.vertical
}

-- Apps

local app = wibox.widget {
	inputbox("Terminal", "terminal", user.terminal, "st"),
	inputbox("Web Browser", "browser", user.browser, "librewolf"),
	inputbox("File Manager", "files", user.files, "nemo"),
	inputbox("Text Editor", "editor", user.editor, "vim"),
	visible = false,
	spacing = dpi(15),
	layout = wibox.layout.fixed.vertical
}

-- Commands

local command = wibox.widget {
	inputbox("Shutdown", "shutdown", user.shutdown, "systemctl poweroff"),
	inputbox("Reboot", "reboot", user.reboot, "systemctl reboot"),
	inputbox("Edit", "editorcmd", user.editorcmd, "st -e vim"),
	visible = false,
	spacing = dpi(15),
	layout = wibox.layout.fixed.vertical
}

-- Theme

local theme = wibox.widget {
	guiselect("Wallpaper", "wallpaper", user.wallpaper, nil, "file"),
	guiselect("Profile Picture", "pfp", user.pfp, nil, "file"),
	inputbox("Font", "font", user.font, "RobotoMono Bold 11"),
	inputbox("Alt Font", "fontalt", user.fontalt, "RobotoMono Italic Bold 11"),
	inputbox("Icon Font", "fonticon", user.fonticon, "Material Icons 16"),
	toggle("Titlebar Controls", "titlecontrols", user.titlecontrols),
	toggle("Panel Controls", "panelcontrols", user.panelcontrols),
	visible = false,
	spacing = dpi(15),
	layout = wibox.layout.fixed.vertical
}

local colors = wibox.widget {
	color,
	visible = false,
	spacing = dpi(15),
	layout = wibox.layout.fixed.vertical
}

local pages = { general, app, command, theme, colors }

-- Tabs

local tabs, tabbg = {}, beautiful.bg_focus

local function addtab(name)

	if #tabs ~= 0 then
		tabbg = beautiful.bg_normal
	end

    local tab = hovercursor(wibox.widget {
        {
            text = name,
            valign = "center",
            align = "center",
            widget = wibox.widget.textbox
        },
        forced_height = dpi(50),
        forced_width = dpi(150),
        bg = tabbg,
        widget = wibox.container.background
    })

	tabs[#tabs + 1] = tab

	local index = #tabs

    tab:buttons {
        awful.button({}, 1, function()
            for i, t in ipairs(tabs) do
                t.bg = beautiful.bg_normal
				pages[i].visible = false
            end
            tab.bg = beautiful.bg_focus
			pages[index].visible = true
        end)
    }

	return tab

end

-- Config

local config = wibox.widget {
	{
		nil,
		{
			addtab("General"),
			addtab("Apps"),
			addtab("Commands"),
			addtab("Theme"),
			addtab("Colors"),
			spacing = dpi(15),
			layout = wibox.layout.fixed.horizontal
		},
		nil,
		expand = "outside",
		layout = wibox.layout.align.horizontal
	},
	{
		thickness = dpi(5),
		color = beautiful.bg_focus,
		forced_height = dpi(15),
		widget = wibox.widget.separator
	},
	{
		general,
		app,
		command,
		theme,
		colors,
		layout = wibox.layout.stack
	},
	spacing = dpi(15),
	layout = wibox.layout.fixed.vertical
}

configdisplay:setup {
	header,
	{
		{
			config,
			{
				{
					cancel,
					done,
					spacing = dpi(15),
					layout = wibox.layout.fixed.horizontal
				},
				valign = "bottom",
				halign = "right",
				layout = wibox.container.place
			},
			layout = wibox.layout.align.vertical
		},
		margins = dpi(15),
		widget = wibox.container.margin
	},
	layout = wibox.layout.align.vertical
}

awesome.connect_signal("widget::config", function()
	configdisplay.visible = not configdisplay.visible

	awful.placement.centered(
		configdisplay,
		{
			parent = awful.screen.focused()
		}
	)
end)
