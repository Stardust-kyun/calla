awesome.connect_signal("widget::config", function()

local dpi = require("beautiful").xresources.apply_dpi
local lgi = require("lgi")
local Gio = lgi.Gio
local Gtk = lgi.require("Gtk", "3.0")
local Gdk = lgi.require("Gdk", "3.0")
local GdkPixbuf = lgi.require("GdkPixbuf", "2.0")
local GObject = lgi.require("GObject", "2.0")

local appID = "io.github.stardust-kyun.calla.settings"
local appTitle = "Settings"
local app = Gtk.Application({ application_id = appID })

local function copytable(table)
	local copy = {}
	for key, value in pairs(table) do
		copy[key] = value
	end
	return copy
end

local settings = copytable(user)

local color

local function genColor()
	local r = assert(io.open(".config/awesome/color/" .. settings.color .. "/" .. settings.color .. ".json", "r"))
	local t = r:read("*all")
	r:close()
	color = require("json"):decode(t)
end

genColor()

local function settingsEntry(name, setting, default)

	local label = Gtk.Label({ label = name, halign = Gtk.Align.START })
	local settingsEntry = Gtk.Entry({ placeholder_text = settings[setting], width = dpi(175) })
	function settingsEntry:on_key_release_event()
		settings[setting] = settingsEntry.text
	end
	local button = Gtk.Button.new_with_label("Default")
	function button:on_clicked()
		settings[setting] = default
		settingsEntry.placeholder_text = settings[setting]
		settingsEntry.text = ""
	end
	local grid = Gtk.Grid({
		column_spacing = dpi(10),
		row_spacing = dpi(10),
		halign = Gtk.Align.CENTER,

		{ label, top_attach = 0, left_attach = 0, width = 2 },
		{ settingsEntry, top_attach = 1, left_attach = 0 },
		{ button, top_attach = 1, left_attach = 1 },
	})

	return grid

end

local function colorEntry(name, setting, default)

	local label = Gtk.Label({ label = name, halign = Gtk.Align.START })
	local colorEntry = Gtk.Entry({ placeholder_text = color[setting], width = dpi(175) })
	function colorEntry:on_key_release_event()
		color[setting] = colorEntry.text
	end
	local button = Gtk.Button.new_with_label("Default")
	function button:on_clicked()
		color[setting] = default
		colorEntry.placeholder_text = color[setting]
		colorEntry.text = ""
	end
	local grid = Gtk.Grid({
		column_spacing = dpi(10),
		row_spacing = dpi(10),
		halign = Gtk.Align.CENTER,

		{ label, top_attach = 0, left_attach = 0, width = 2 },
		{ colorEntry, top_attach = 1, left_attach = 0 },
		{ button, top_attach = 1, left_attach = 1 },
	})

	return grid

end

local function createColor(name, col, colname)

	local rgbcol = Gdk.RGBA.parse(col)

	local label = Gtk.Label({ label = name, halign = Gtk.Align.START })
	local button = Gtk.ColorButton({ rgba = rgbcol, show_editor = true })
	function button:on_color_set()
		local out = button:get_rgba():to_string()

		local red = out:match("%d+,"):gsub(",", "")
		local green = out:match(",%d+,"):gsub(",", "")
		local blue = out:match(",%d+%)"):gsub(",", ""):gsub("%)", "")

		local hex = string.format("#%02X%02X%02X", red, green, blue)
		
		color[colname] = hex
	end
	local grid = Gtk.Grid({
		column_spacing = dpi(10),
		row_spacing = dpi(10),
		halign = Gtk.Align.CENTER,

		{ label, top_attach = 0, left_attach = 0 },
		{ button, top_attach = 1, left_attach = 0 },
	})

	return grid

end

local function doGeneral()

	local function wallpaper()

		local label = Gtk.Label({ label = "Wallpaper", halign = Gtk.Align.START })

		local filter = Gtk.FileFilter()
		filter:add_pattern("*.png")
		filter:add_pattern("*.jpg")

		if settings.wallpaper ~= nil then
			local pixbuf = GdkPixbuf.Pixbuf.new_from_file_at_scale(settings.wallpaper:gsub("~", os.getenv("HOME")), 500, 500, true)
		else
			local pixbuf
		end
		local preview = Gtk.Image()

		local wallpaper = Gtk.FileChooserButton({ filter = filter, title = "Choose Wallpaper", width = dpi(175), preview_widget = preview })
		if settings.wallpaper ~= nil then
			wallpaper:set_file(Gio.File.new_for_path(settings.wallpaper:gsub("~", os.getenv("HOME"))))
			wallpaper:set_current_folder_file(Gio.File.new_for_path(settings.wallpaper:gsub("~", os.getenv("HOME"))))
		else
			wallpaper:set_file(Gio.File.new_for_path(""))
			wallpaper:set_current_folder_file(Gio.File.new_for_path(os.getenv("HOME")))
		end
		function wallpaper:on_file_set()
			settings.wallpaper = self:get_filename():gsub(os.getenv("HOME"), "~")
		end
		function wallpaper:on_update_preview()
			pixbuf = GdkPixbuf.Pixbuf.new_from_file_at_scale(self:get_preview_filename(), 500, 500, true)
			preview:set_from_pixbuf(pixbuf)
			wallpaper:set_preview_widget_active(true)
		end

		local button = Gtk.Button.new_with_label("Default")
		function button:on_clicked()
			settings.wallpaper = nil
			wallpaper:set_file(Gio.File.new_for_path(""))
		end

		local grid = Gtk.Grid({
			column_spacing = dpi(10),
			row_spacing = dpi(10),
			halign = Gtk.Align.CENTER,

			{ label, top_attach = 0, left_attach = 0, width = 2 },
			{ wallpaper, top_attach = 1, left_attach = 0 },
			{ button, top_attach = 1, left_attach = 1 },
		})

		return grid

	end

	local function screenshot()

		local label = Gtk.Label({ label = "Screenshot Directory", halign = Gtk.Align.START })
		local button = Gtk.FileChooserButton({ title = "Choose Screenshot Directory", width = dpi(245), action = Gtk.FileChooserAction.SELECT_FOLDER })
		button:set_current_folder_file(Gio.File.new_for_path(settings.shotdir:gsub("~", os.getenv("HOME"))))
		function button:on_file_set()
			settings.shotdir = self:get_filename():gsub(os.getenv("HOME"), "~")
		end

		local grid = Gtk.Grid({
			column_spacing = dpi(10),
			row_spacing = dpi(10),
			halign = Gtk.Align.CENTER,

			{ label, top_attach = 0, left_attach = 0 },
			{ button, top_attach = 1, left_attach = 0 },
		})

		return grid

	end

	local grid = Gtk.Grid({
		column_spacing = dpi(20),
		row_spacing = dpi(10),
		margin = dpi(20),
		halign = Gtk.Align.CENTER,

		{ settingsEntry("Terminal", "terminal", "st"), top_attach = 0, left_attach = 0 },
		{ settingsEntry("Shutdown", "shutdown", "systemctl poweroff"), top_attach = 1, left_attach = 0 },
		{ settingsEntry("Reboot", "reboot", "systemctl reboot"), top_attach = 2, left_attach = 0 },
		{ settingsEntry("Font", "font", "Roboto Bold 11"), top_attach = 0, left_attach = 1 },
		{ settingsEntry("Alt Font", "fontalt", "Roboto Italic Bold 11"), top_attach = 1, left_attach = 1 },
		{ settingsEntry("Icon Font", "fonticon", "Material Icons 16"), top_attach = 2, left_attach = 1 },
		{ settingsEntry("Fallback Password", "passwd", "awesomewm"), top_attach = 3, left_attach = 0 },
		{ settingsEntry("Battery", "batt", "BAT0"), top_attach = 3, left_attach = 1 },
		{ wallpaper(), top_attach = 4, left_attach = 0 },
		{ screenshot(), top_attach = 4, left_attach = 1 },
	})

	return grid

end

local function doColor()

	genColor()

	local left = Gtk.Grid({
		column_spacing = dpi(10),
		row_spacing = dpi(10),
		halign = Gtk.Align.CENTER,

		{ createColor("Bg", color.bg, "bg"), top_attach = 0, left_attach = 0 },
		{ createColor("Mid Bg", color.bgmid, "bgmid"), top_attach = 1, left_attach = 0 },
		{ createColor("Alt Bg", color.bgalt, "bgalt"), top_attach = 2, left_attach = 0 },
		{ createColor("Fg", color.fg, "fg"), top_attach = 0, left_attach = 1 },
		{ createColor("Black", color.black, "black"), top_attach = 1, left_attach = 1 },
		{ createColor("White", color.white, "white"), top_attach = 2, left_attach = 1 },
		{ createColor("Red", color.red, "red"), top_attach = 0, left_attach = 2 },
		{ createColor("Green", color.green, "green"), top_attach = 1, left_attach = 2 },
		{ createColor("Yellow", color.yellow, "yellow"), top_attach = 2, left_attach = 2 },
		{ createColor("Blue", color.blue, "blue"), top_attach = 0, left_attach = 3 },
		{ createColor("Magenta", color.magenta, "magenta"), top_attach = 1, left_attach = 3 },
		{ createColor("Cyan", color.cyan, "cyan"), top_attach = 2, left_attach = 3 },

		{ colorEntry("Gui Theme", "gtk", color.gtk), top_attach = 3, left_attach = 0, width = 4 },
	})

	local right = Gtk.Grid({
		column_spacing = dpi(10),
		row_spacing = dpi(10),
		halign = Gtk.Align.CENTER,

		{ colorEntry("Compositor Radius", "compradius", color.compradius), top_attach = 0, left_attach = 0 },
		{ colorEntry("Compositor Offset", "compoffset", color.compoffset), top_attach = 1, left_attach = 0 },
		{ colorEntry("Compositor Opacity", "compopacity", color.compopacity), top_attach = 2, left_attach = 0 },
		{ colorEntry("Icon Theme", "icons", color.icons), top_attach = 3, left_attach = 0 },
	})

	local grid = Gtk.Grid({
		column_spacing = dpi(20),
		halign = Gtk.Align.CENTER,

		{ left, top_attach = 0, left_attach = 0 },
		{ right, top_attach = 0, left_attach = 1 },

	})

	return grid
end

local function doTheme()

	local function colorgen()
		local colors = {}

		for dir in io.popen([[ls -d .config/awesome/color/*/ | cut -f4 -d'/']]):lines() do
			table.insert(colors, dir)
		end

		return colors
	end

	local model = Gtk.ListStore.new({ GObject.Type.STRING })
	local items = colorgen()
	local currentcolor = 0

	for i, name in ipairs(items) do
		model:append({ name })

		if name == settings.color then
			currentcolor = i-1
		end
	end

	local combo = Gtk.ComboBox({
		model = model,
		active = currentcolor,
		cells = {
			{
				Gtk.CellRendererText(),
				{ text = 1 },
				align = Gtk.Align.START
			}
		},
		expand = true
	})

	local savebutton = Gtk.Button.new_with_label("Save Theme As...")
	local confirmbutton = Gtk.Button.new_with_label("Confirm")
	local cancelbutton = Gtk.Button.new_with_label("Cancel")
	local nameset = false

	local themeprompt = Gtk.Label({ label = "What should this theme be called?", halign = Gtk.Align.START })
	local themename = Gtk.Entry({ placeholder_text = "Theme Name", hexpand = true })
	local name
	function themename:on_key_release_event()
		name = themename.text
	end

	local wallprompt = Gtk.Label({ label = "What wallpaper should this theme use?", halign = Gtk.Align.START })
	local filter = Gtk.FileFilter()
	filter:add_pattern("*.png")
	filter:add_pattern("*.jpg")

	local preview = Gtk.Image()

	local wallpaper = nil
	local wallpaperbutton = Gtk.FileChooserButton({ filter = filter, title = "Choose Wallpaper", hexpand = true, preview_widget = preview })
	wallpaperbutton:set_file(Gio.File.new_for_path(""))
	wallpaperbutton:set_current_folder_file(Gio.File.new_for_path(os.getenv("HOME")))
	function wallpaperbutton:on_file_set()
		wallpaper = self:get_filename()
	end
	function wallpaperbutton:on_update_preview()
		pixbuf = GdkPixbuf.Pixbuf.new_from_file_at_scale(self:get_preview_filename(), 500, 500, true)
		preview:set_from_pixbuf(pixbuf)
		wallpaperbutton:set_preview_widget_active(true)
	end

	local colorscheme = Gtk.Grid({
		column_spacing = dpi(10),
		row_spacing = dpi(10),

		{ Gtk.Label({ label = "Color Scheme", halign = Gtk.Align.START }), top_attach = 0, left_attach = 0 },
		{ combo, top_attach = 1, left_attach = 0 },
		{ savebutton, top_attach = 1, left_attach = 1 }
	})

	function savebutton:on_clicked()
		colorscheme:remove(combo)
		colorscheme:remove(savebutton)
		colorscheme:attach(themeprompt, 0, 1, 1, 1)
		colorscheme:attach(themename, 1, 1, 1, 1)
		colorscheme:attach(confirmbutton, 2, 1, 1, 1)
		colorscheme:attach(cancelbutton, 3, 1, 1, 1)
		colorscheme:show_all()
	end
	function confirmbutton:on_clicked()
		if nameset == false and name ~= "" then
			nameset = true
			colorscheme:remove(themeprompt)
			colorscheme:remove(themename)
			colorscheme:attach(wallprompt, 0, 1, 1, 1)
			colorscheme:attach(wallpaperbutton, 1, 1, 1, 1)
			colorscheme:show_all()	
		elseif nameset == true and wallpaper then
			local themedir = require("gears").filesystem.get_configuration_dir() .. "color/" .. name .. "/"
			local path = Gio.File.new_for_path(themedir)
			local sourcepath = Gio.File.new_for_path(wallpaper)
			local targetpath = Gio.File.new_for_path(themedir .. name .. ".png")
			path:make_directory()
			sourcepath:copy(targetpath, Gio.FileCopyFlags.NONE, nil, nil, nil, nil)
			color.wall = targetpath:get_path():gsub(require("gears").filesystem.get_configuration_dir(), "")
			local w = assert(io.open(".config/awesome/color/" .. name .. "/" .. name .. ".json", "w"))
		w:write(require("json"):encode_pretty(color, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true }))
		w:close()
		
			table.insert(items, name)
			model:append({name})
			colorscheme:remove(wallprompt)
			colorscheme:remove(wallpaperbutton)
			colorscheme:remove(confirmbutton)
			colorscheme:remove(cancelbutton)
			colorscheme:attach(combo, 0, 1, 1, 1)
			colorscheme:attach(savebutton, 1, 1, 1, 1)
			nameset = false
			themename.text = ""
			colorscheme:show_all()
		end
	end
	function cancelbutton:on_clicked()
		colorscheme:remove(themeprompt)
		colorscheme:remove(themename)
		colorscheme:remove(wallprompt)
		colorscheme:remove(wallpaperbutton)
		colorscheme:remove(confirmbutton)
		colorscheme:remove(cancelbutton)
		colorscheme:attach(combo, 0, 1, 1, 1)
		colorscheme:attach(savebutton, 1, 1, 1, 1)
		nameset = false
		themename.text = ""
		colorscheme:show_all()
	end

	local grid = Gtk.Grid({
		column_spacing = dpi(10),
		row_spacing = dpi(10),
		margin = dpi(20),
		halign = Gtk.Align.CENTER,

		{ colorscheme, top_attach = 0, left_attach = 0 },
		{ doColor(), top_attach = 1, left_attach = 0 },

	})

	function combo:on_changed()
		local n = self:get_active()
		settings.color = items[n+1]
		grid:remove(grid:get_child_at(0, 1))
		local colorwidget = doColor()
		grid:attach(colorwidget, 0, 1, 1, 1)
		colorwidget:show_all()
	end

	return grid

end

local function restartdialog()
	
	local label = Gtk.Label({ label = "Some changes require a restart. Restart now?" })
	local cancelButton = Gtk.Button.new_with_label("No Thanks")
	local restartButton = Gtk.Button.new_with_label("Restart")
	function cancelButton:on_clicked()
		awesome.emit_signal("settings::cancel")
	end
	function restartButton:on_clicked()
		awesome.restart()
	end

	local grid = Gtk.Grid({
		column_spacing = dpi(10),
		halign = Gtk.Align.END,
		margin_end = dpi(20),

		{ label, top_attach = 0, left_attach = 0 },
		{ cancelButton, top_attach = 0, left_attach = 1 },
		{ restartButton, top_attach = 0, left_attach = 2 },
	})

	return grid

end

function app:on_startup()
	local window = Gtk.ApplicationWindow({
		title = appTitle,
		application = self,
		default_width = dpi(500),
		default_height = dpi(350)
	})

	window:set_wmclass("settings", "Settings")

	local stack = Gtk.Stack({
		transition_type = Gtk.StackTransitionType.NONE
	})

	stack:add_titled(doGeneral(), "general", "General")
	stack:add_titled(doTheme(), "theme", "Theme")

	local saveButton = Gtk.Button({ label = "Save", halign = Gtk.Align.END, margin_end = dpi(20) })

	local box = Gtk.Box({
		orientation = Gtk.Orientation.VERTICAL,
		margin = dpi(10),
		Gtk.StackSwitcher({ stack = stack, halign = Gtk.Align.CENTER }),
		{ stack, expand = true },
		saveButton
	})

	function saveButton:on_clicked()

		local shouldrestart = false

		local userrestart = {
			"font",
			"fontalt",
			"fonticon",
			"batt",
		}

		for _, property in ipairs(userrestart) do
			if user[property] ~= settings[property] then
				shouldrestart = true
				break
			end
		end

		local w = assert(io.open(".config/awesome/json/user.json", "w"))
		w:write(require("json"):encode_pretty(settings, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true }))
		w:close()
		user = copytable(settings)

		local w = assert(io.open(".config/awesome/color/" .. settings.color .. "/" .. settings.color .. ".json", "w"))
		w:write(require("json"):encode_pretty(color, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true }))
		w:close()

		awesome.emit_signal("color::change", color)

		if shouldrestart then
			box:remove(saveButton)
			local dialog = restartdialog()
			box:add(dialog)
			dialog:show_all()
			awesome.connect_signal("settings::cancel", function()
				box:remove(dialog)
				box:add(saveButton)
				saveButton:show_all()
			end)
		end

		require("beautiful").init(require("gears").filesystem.get_configuration_dir() .. "theme/theme.lua")	
		awesome.emit_signal("live::reload")
	end

	box:show_all()
	window:add(box)
end

function app:on_activate()
	self.active_window:present()
end

return app:run()

end)
