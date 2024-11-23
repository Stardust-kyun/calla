local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local icons = "/usr/share/icons/" .. beautiful.icons .. "/64x64/"
local desktopjson = gears.filesystem.get_cache_dir() .. "desktop.json"
local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")
local Gio = lgi.Gio
local UPower = lgi.require("UPowerGlib")

screen.connect_signal("request::desktop_decoration", function(s)

	--[[ logic for grabbing batteries, for use in future desktop widgets
	local function listdevices()
		local ret = {}
		local devices = UPower.Client():get_devices()

		for _, device in ipairs(devices) do
			table.insert(ret, device:get_object_path())
		end

		return ret
	end

	local function getdevice(path)
		local devices = UPower.Client():get_devices()

		for _, device in ipairs(devices) do
			if device:get_object_path() == path then
				return device
			end
		end

		return nil
	end

	local devicepaths = listdevices()

	for _, path in ipairs(devicepaths) do
		local device = getdevice(path)

		device.on_notify = function()
		end
	end
	--]]

	local cell = dpi(120)
	local geometry = s:get_bounding_geometry()
	local rows = math.floor((geometry.height-dpi(60))/cell)
	local cols = math.floor((geometry.width-dpi(20))/cell)
	local vspacing = math.floor((((geometry.height-dpi(60))-(rows*cell))/(rows-1))+0.5)
	local hspacing = math.floor((((geometry.width-dpi(20))-(cols*cell))/(cols-1))+0.5)

	s.grid = wibox.widget {
		forced_num_rows = rows,
		forced_num_cols = cols,
		vertical_spacing = vspacing,
		horizontal_spacing = hspacing,
		orientation = "horizontal",
		layout = wibox.layout.grid
	}

	s.manual = wibox.layout {
		layout = wibox.layout.manual
	}

	s.padding = {
		top = dpi(10),
		bottom = dpi(50),
		left = dpi(10),
		right = dpi(10)
	}

	s.base = wibox {
		screen = s,
		ontop = false,
		visible = true,
		type = "splash",
	}

	s.desktop = wibox {
		screen = s,
		width = s.geometry.width-dpi(20),
		height = s.geometry.height-dpi(60),
		ontop = false,
		visible = true,
		type = "normal"
	}

	awful.placement.maximize(s.base)

	awful.placement.top(
		s.desktop,
		{
			margins = {
				top = dpi(10)
			}
		}
	)

	s.panel = require("theme.panel")(s)

	s.base:setup {
		{
			s.panel,
			valign = "bottom",
			content_fill_horizontal = true,
			widget = wibox.container.place
		},
		widget = live(wibox.container.background, { bg = "bg" })
	}

	s.desktop:setup {
		{
			id = "wallpaper",
			image = gears.surface.crop_surface {
				surface = gears.surface.load_uncached(beautiful.wallpaper),
				ratio = (s.geometry.width-dpi(20))/(s.geometry.height-dpi(60))
			},
			widget = wibox.widget.imagebox
		},
		s.grid,
		s.manual,
		layout = wibox.layout.stack
	}

	local function generate()
		local entries = {}

		for entry in io.popen([[ls ~/Desktop | sed '']]):lines() do
			local label = nil
			local exec = nil
			local icon = nil

			if entry:match("^.+(%..+)$") == ".desktop" then
				for line in io.popen("cat ~/Desktop/'" .. entry .. "'"):lines() do
					if line:match("Name=") and not label then
						label = line:gsub("Name=", "")
					end
					if line:match("Exec=") and not exec then
						exec = line:gsub("Exec=", ""):gsub("%%U", ""):gsub("%%u", "")
					end
					if line:match("CustomIcon=") and not icon then
						icon = line:gsub("CustomIcon=", "")
					elseif line:match("Icon=") and not icon then
						icon = line:gsub("Icon=", "")
					end
				end
				table.insert(entries, { label = label, exec = exec, icon = icon })
			elseif os.execute("cd ~/Desktop'" .. entry .. "'") then
				label = entry
				icon = "folder"
				exec = "gio open ~/Desktop/'" .. entry .. "'"
				table.insert(entries, { label = label, exec = exec, icon = icon })
			else
				label = entry
				icon = Gio.File.new_for_path(os.getenv("HOME") .. "/Desktop/" .. entry):query_info("standard::*", Gio.FileQueryInfoFlags.NONE):get_icon()
				for _, name in ipairs(icon:get_names()) do
					if Gtk.IconTheme.get_default():has_icon(name) then
						icon = name
						break
					end
					icon = "application-x-generic"
				end
				exec = "gio open ~/Desktop/'" .. entry .. "'"
				table.insert(entries, { label = label, exec = exec, icon = icon })
			end
		end

		return entries
	end

	local function save()
		layout = {}

		for i, widget in ipairs(s.grid.children) do
			local pos = s.grid:get_widget_position(widget)

			layout[i] = {
				row = pos.row,
				col = pos.col,
				widget = {
					label = widget.label,
					exec = widget.exec,
					icon = widget.icon
				}
			}
		end

		writejson(desktopjson, layout)
	end

	local function gridindexat(y, x) -- gotta fix this to account for spacing
		local margin = dpi(10)

		local row = math.ceil((y - margin) / cell)
		row = math.min(row, rows)
		row = math.max(row, 1)

		local col = math.ceil((x - margin) / cell)
		col = math.min(col, cols)
		col = math.max(col, 1)

		return row, col
	end

	local function exists(path)
		local f = io.open(path, "r")
		if f~=nil then io.close(f) return true else return false end
	end

	local function createicon(label, exec, icon)
		local image
		if exists(icons .. "places/" .. icon .. ".svg") then
			image = icons .. "places/" .. icon .. ".svg"
		elseif exists(icons .. "mimetypes/" .. icon .. ".svg") then
			image = icons .. "mimetypes/" .. icon .. ".svg"
		elseif exists(icons .. "apps/" .. icon .. ".svg") then
			image = icons .. "apps/" .. icon .. ".svg"
		else
			image = icons .. "mimetypes/application-x-generic.svg"
		end

		local widget = hovercursor(wibox.widget {
			{
				{
					{
						image = image,
						halign = "center",
						widget = wibox.widget.imagebox
					},
					strategy = "exact",
					width = dpi(50),
					height = dpi(50),
					widget = wibox.container.constraint
				},
				{
					{
						{
							{
								valign = "top",
								align = "center",
								widget = colortext({ text = label })
							},
							margins = dpi(5),
							widget = wibox.container.margin
						},
						shape = function(cr, width, height)
									gears.shape.rounded_rect(cr, width, height, dpi(10))
								end,
						widget = live(wibox.container.background, { bg = "bgmid" })
					},
					strategy = "max",
					width = dpi(100),
					height = dpi(50),
					widget = wibox.container.constraint
				},
				spacing = dpi(5),
				layout = wibox.layout.fixed.vertical
			},
			label = label,
			exec = exec,
			icon = icon,
			forced_width = cell,
			forced_height = cell,
			top = dpi(10),
			left = dpi(10),
			right = dpi(10),
			widget = wibox.container.margin
		})

		widget:connect_signal("button::press", function(_, _, _, button)
			if not mousegrabber.isrunning() then
				local heldwidget = wibox.widget {
					{
						{
							{
								image = image,
								opacity = 0.5,
								halign = "center",
								widget = wibox.widget.imagebox
							},
							strategy = "exact",
							width = dpi(50),
							height = dpi(50),
							widget = wibox.container.constraint
						},
						{
							{
								{
									{
										opacity = 0.5,
										valign = "top",
										align = "center",
										widget = colortext({ text = label })
									},
									margins = dpi(5),
									widget = wibox.container.margin
								},
								shape = function(cr, width, height)
											gears.shape.rounded_rect(cr, width, height, dpi(10))
										end,
								widget = live(wibox.container.background, { bg = "bgmid" })
							},
							strategy = "max",
							width = dpi(100),
							height = dpi(50),
							widget = wibox.container.constraint
						},
						spacing = dpi(5),
						layout = wibox.layout.fixed.vertical
					},
					forced_width = cell,
					forced_height = cell,
					top = dpi(10),
					left = dpi(10),
					right = dpi(10),
					visible = false,
					widget = wibox.container.margin
				}

				local startpos = mouse.coords()
				heldwidget.point = { x = startpos.x, y = startpos.y }
				local oldpos = s.grid:get_widget_position(widget)
				s.manual:add(heldwidget)

				mousegrabber.run(function(mouse)
					if (math.abs(mouse.x - startpos.x) > 10 or
						math.abs(mouse.y - startpos.y) > 10) and
						mouse.buttons[1] then

						s.grid:remove(widget)
						heldwidget.visible = true

						s.manual:move_widget(heldwidget, {
							x = mouse.x - dpi(50),
							y = mouse.y - dpi(50)
						})
					end

					if not mouse.buttons[1] then
						if button == 1 then
							if heldwidget.visible then
								heldwidget.visible = false

								local newrow, newcol = gridindexat(
									mouse.y,
									mouse.x
								)
								if not s.grid:get_widgets_at(newrow, newcol) then
									s.grid:add_widget_at(widget, newrow, newcol)
									save()
								else
									s.grid:add_widget_at(widget, oldpos.row, oldpos.col)
								end
							else
								awful.spawn.with_shell(exec)
								s.manual:reset()
							end
							mousegrabber.stop()
						end
					end
					return mouse.buttons[1]
				end, "hand2")
			end
		end)

		return widget
	end

	local function load()
		s.grid:reset()

		if not gears.filesystem.file_readable(desktopjson) then
			local entries = generate()
			for _, entry in ipairs(entries) do
				s.grid:add(createicon(entry.label, entry.exec, entry.icon))
			end
			save()
			return
		end

		local layout = readjson(desktopjson)

		for _, entry in ipairs(layout) do
			s.grid:add_widget_at(createicon(entry.widget.label, entry.widget.exec, entry.widget.icon), entry.row, entry.col)
		end
	end

	load()

	awesome.connect_signal("signal::desktop", function(type)
		local entries = generate()
		local check = false

		if type == "add" then
			for _, entry in ipairs(entries) do
				for _, widget in ipairs(s.grid.children) do
					if entry.label == widget.label then
						check = true
						break
					end
				end
				if check == false then
					s.grid:add(createicon(entry.label, entry.exec, entry.icon))
				end
				check = false
			end
		end

		if type == "remove" then
			for _, widget in ipairs(s.grid.children) do
				for _, entry in ipairs(entries) do
					if entry.label == widget.label then
						check = true
						break
					end
				end
				if check == false then
					s.grid:remove(widget)
				end
				check = false
			end
		end

		save()
	end)

	awesome.connect_signal("live::reload", function()
		s.desktop:get_children_by_id("wallpaper")[1].image = gears.surface.crop_surface {
			surface = gears.surface.load_uncached(beautiful.wallpaper),
			ratio = (s.geometry.width-dpi(20))/(s.geometry.height-dpi(60))
		}
	end)

end)
