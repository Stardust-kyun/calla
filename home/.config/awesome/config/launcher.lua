local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local Gio = require("lgi").Gio
-- TODO --
-- - Add mouse support
-- - Add support for holding down keys (up and down)


local menu = {}

-- Functions --
-- Generate desktop entries
local function entries_gen()
	local entries = {}
	for _, entry in ipairs(Gio.AppInfo.get_all()) do
		if entry:should_show() then
			local name = entry:get_name()
			name = name:gsub("&", "&amp;")
			name = name:gsub("<", "&lt;")
			name = name:gsub("'", "&#39;")
			table.insert(entries, {name = name, appinfo = entry})
		end
	end
	return entries
end

-- Sort the generated desktop entries with a search query into multiple pages
-- (15 entries per page)
local function entries_sort(entries, search)
	local entries_sorted = {}
	search = string.lower(search or "")
	for _, entry in ipairs(entries) do
		if string.match(string.lower(entry.name), search) then
			table.insert(entries_sorted, entry)
		end
	end

	local tmp = {}
	local page = 1
	local index = 1
	for _, entry in ipairs(entries_sorted)  do
		if type(tmp[page]) ~= "table" then tmp[page] = {} end
		tmp[page][index] = entry
		index = index + 1
		if index > 15 then
			page = page + 1
			index = 1
		end
	end
	return tmp
end

-- Display the entries onto the grid
local function entries_display(grid, entries, page, index)
	-- Display the sorted entries onto the menu
	local widget_entries = grid:get_widgets_at(3, 1)[1]
	do -- Remove the entries that were previously displayed
		local i = 1
		while widget_entries:remove_widgets_at(i, 1) do
			i = i + 1
		end
	end

	if entries[page] == nil then return end
	for i, _ in ipairs(entries[page]) do
		local bg = "#ffffff00"
		local fg = beautiful.menubar_fg_normal or beautiful.fg_normal
		if i == index then
			bg = beautiful.menubar_bg_focus
			fg = beautiful.menubar_fg_focus
		end

		local widget = {
			widget = wibox.container.background,
			bg = bg,
			{
				widget = wibox.container.margin,
				margins = 5,
				{
					widget = wibox.widget.textbox,
					markup = string.format(
						"<span font='12' foreground='%s'>%s</span>",
						fg,
						entries[page][i].name
					)
				}
			}
		}
		widget_entries:add(wibox.widget(widget))
	end

	local page_widget = grid:get_widgets_at(4, 1)[1]
	page_widget.markup = string.format(
		"<span font='11'>%s/%s</span>",
		page,
		#entries
	)
end

local function choose_ensure(entries, page, index)
	if page < 1 then
		page = 1
	else
		tmp = entries or {}
		tmp = #tmp
		if page > tmp then page = tmp end
	end
	if index < 1 then
		index = 1
	else
		tmp = entries[page] or {}
		tmp = #tmp
		if index > tmp then index = tmp end
	end
	return page, index
end

local function choose_next(entries, page, index)
	local current_page = entries[page] or {}
	if index == #current_page then
		if page ~= #entries then
			page = page + 2
			index = 1
		end
	else
		index = index + 1
	end
	return choose_ensure(entries, page, index)
end

local function choose_prev(entries, page, index)
	if index == 1 then
		if page ~= 1 then
			page = page - 1
			index = 15
		end
	else
		index = index - 1
	end
	return choose_ensure(entries, page, index)
end

function menu.open()
	local geometry = awful.screen.focused().geometry
	menu.chosen_page = 1
	menu.chosen_index = 1
	menu.entries_unsorted = entries_gen()
	menu.popup = awful.popup {
		shape = gears.shape.rounded_rect,
		placement = awful.placement.centered,
		border_color = beautiful.border_focus,
		border_width = 3,
		ontop = true,
		widget = {
			widget = wibox.container.margin,
			margins = 20,
			{
				layout = wibox.layout.grid,
				forced_num_cols = 1,
				homogeneous = false,
				{ widget = wibox.widget.textbox }, -- Prompt
				{ -- Separator
					widget = wibox.container.margin,
					top = 10,
					{
						widget = wibox.widget.separator,
						orientation = "horizontal",
						color = beautiful.border_focus,
						thickness = 2,
						forced_height = 2,
						forced_width = geometry.width / 3
					}
				},
				{ -- Entries
					widget = wibox.layout.grid,
					forced_num_cols = 1
				},
				{ -- Page Info
					widget = wibox.widget.textbox,
					align = "right"
				}
			}
		}
	}

	awful.prompt.run {
		prompt = "Run: ",
		textbox = menu.popup.widget.widget:get_widgets_at(1, 1)[1],
		done_callback = function()
			menu.popup.visible = false
			menu.popup = nil
		end,
		exe_callback = function(cmd)
			local page = menu.chosen_page
			local index = menu.chosen_index
			local entry = entries_sort(menu.entries_unsorted, cmd)[page]
			if entry ~= nil then
				entry = entry[index]
				if entry ~= nil then
					naughty.notify {
						title = "Launching Application",
						text = entry.name
					}
					entry.appinfo:launch()
					return
				end
			end
			naughty.notify {
				title = "Running Command",
				text = cmd
			}
			awful.spawn.with_shell(cmd)
		end,
		keyreleased_callback = function(mod, key, cmd)
			local entries = entries_sort(menu.entries_unsorted, cmd)
			local page = menu.chosen_page
			local index = menu.chosen_index
			if key == "Down" or (mod.Control and key == "n") then
				page, index = choose_next(entries, page, index)
			elseif key == "Up" or (mod.Control and key == "p") then
				page, index = choose_prev(entries, page, index)
			end
			menu.chosen_page = page
			menu.chosen_index = index
			entries_display(menu.popup.widget.widget, entries, page, index)
		end
	}
end

return menu
