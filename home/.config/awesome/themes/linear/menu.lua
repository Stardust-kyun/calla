local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local Gio = require("lgi").Gio

local module = {}

local function info_highlight(grid)
	local i = 0
	local widget
	while true do
		i = i + 1
		widget = grid:get_widgets_at(i, 1)
		if not widget then break end
		widget = widget[1]

		if i == module.index_entry then
			widget.bg = beautiful.bg_normal
			widget.widget.widget.markup = string.format(
				"<span foreground='%s' font='12'>%s</span>",
				beautiful.fg_normal,
				widget.widget.widget.markup:match("^<span[^>]*>(.*)</span>$")
			)
		else
			widget.bg = nil
			widget.widget.widget.markup = string.format(
				"<span foreground='%s' font='12'>%s</span>",
				beautiful.fg_normal .. "50",
				widget.widget.widget.markup:match("^<span[^>]*>(.*)</span>$")
			)
		end

		if module.index_start <= i and i <= module.index_start + 9 then
			widget.visible = true
		else
			widget.visible = false
		end

	end
	module.widget_page.text = string.format("%i/%i", module.index_entry, i - 1)
end

local function info_next(grid)
	if module.index_entry ~= #module.entries_filtered then
		module.index_entry = module.index_entry + 1
		if module.index_entry > module.index_start + 9 then
			module.index_start = module.index_start + 1
		end
	end
	info_highlight(grid)
end

local function info_prev(grid)
	if module.index_entry ~= 1 then
		module.index_entry = module.index_entry - 1
		if module.index_entry < module.index_start then
			module.index_start = module.index_start - 1
		end
	end
	info_highlight(grid)
end

local function info_filter(grid, cmd)
	-- Filter the desktop entries
	if cmd then
		module.entries_filtered = {}
		for _, entry in ipairs(module.entries_unfiltered) do
			if string.match(string.lower(entry.name), string.lower(cmd)) then
				table.insert(module.entries_filtered, entry)
			end
		end
	end
	-- Clear the grid
	grid:reset()
	-- Add the filtered entriet to the grid
	for i, entry in ipairs(module.entries_filtered) do
		local widget = wibox.widget {
			widget = wibox.container.background,
			id = "bg",
			{
				widget = wibox.container.margin,
				margins = 5,
				{
					widget = wibox.widget.textbox,
					id = "text",
					markup = string.format(
						"<span font='12'>%s</span>",
						entry.name
					)
				},
			}
		}
		widget:connect_signal(
			"mouse::enter",
			function()
				module.index_entry = i
				info_highlight(grid)
			end
		)
		grid:add(widget)
	end
	if module.index_entry > #module.entries_filtered then
		module.index_entry = #module.entries_filtered
	elseif module.index_entry < 1 then
		module.index_entry = 1
	end
	info_highlight(grid)
	collectgarbage()
end


function module.open()
	-- Reset the index and page
	module.index_start = 1
	module.index_entry = 1
	-- Get desktop entries
	module.entries_unfiltered = {}
	for _, entry in ipairs(Gio.AppInfo.get_all()) do
		if entry:should_show() then
			local name = entry:get_name()
			name = name:gsub("&", "&amp;")
			name = name:gsub("<", "&lt;")
			name = name:gsub("'", "&#39;")
			table.insert(
				module.entries_unfiltered,
				{name = name, appinfo = entry}
			)
		end
	end
	-- Create the popup widget
	local geometry = awful.screen.focused().geometry
	local popup = awful.popup {
		shape = gears.shape.rectangle,
		placement = awful.placement.centered,
		ontop = true,
		widget = {
			widget = wibox.container.margin,
			margins = 20,
			{
				layout = wibox.layout.grid,
				forced_num_cols = 1,
				homogeneous = false,
				{
					widget = wibox.container.place,
					halign = "right",
				},
				{ widget = wibox.widget.textbox }, -- Prompt
				{ -- Separator
					widget = wibox.container.margin,
					top = 10,
					{
						widget = wibox.widget.separator,
						orientation = "horizontal",
						color = beautiful.bg_focus,
						thickness = 2,
						forced_height = 2,
						forced_width = geometry.width / 4
					}
				},
				{ -- Entries
					widget = wibox.layout.grid,
					homogeneous = false,
					expand = true,
					forced_num_cols = 1
				},
				{ -- Page Info
						widget = wibox.widget.textbox,
						align = "right"
				}
			}
		}
	}
	local grid = popup.widget.widget:get_widgets_at(4, 1)[1]

	module.widget_page = popup.widget.widget:get_widgets_at(5, 1)[1]
	grid:connect_signal(
		"button::press",
		function(_, _, _, button)
			if button == 5 then
					if module.index_start + 14 ~= #module.entries_filtered then
						module.index_start = module.index_start + 1
						module.index_entry = module.index_entry + 1
					info_highlight(grid)
				end
			elseif button == 4 then
				if module.index_start ~= 1 then
					module.index_start = module.index_start - 1
					module.index_entry = module.index_entry - 1
					info_highlight(grid)
				end
			elseif button == 1 then
				local entry = module.entries_filtered[module.index_entry]
				awful.keygrabber.stop()
				popup.visible = false
				popup = nil
				entry.appinfo:launch()
			end
		end
	)

	info_filter(grid, "")
	awful.prompt.run {
		prompt = "<span font='12'>Run: </span>",
		textbox = popup.widget.widget:get_widgets_at(2, 1)[1],
		done_callback = function() popup.visible = false; popup = nil; end,
		changed_callback = function(cmd) info_filter(grid, cmd) end,
		exe_callback = function(cmd)
			local entry = module.entries_filtered[module.index_entry]
			if entry then
				entry.appinfo:launch()

			else
				awful.spawn.with_shell(cmd)
			end
		end,
		keypressed_callback = function(mod, key, cmd)
			if key == "Down" or (mod.Control and key == "n") then
				info_next(grid)
			elseif key == "Up" or (mod.Control and key == "p") then
				info_prev(grid)
			end
		end,
		completion_callback = function(cmd, pos, ncomp)
			local str = module.entries_filtered[module.index_entry]
			if str then
				return str.name, #str.name + 1, {}
			else
				return awful.completion.shell(cmd, pos, ncomp)
			end
		end
	}
end

return module
