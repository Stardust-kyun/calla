local wibox = require("wibox")
local awful = require("awful")
local Gio = require("lgi").Gio
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Widgets

local colordisplay = wibox {
	width = dpi(400),
	height = dpi(460),
	bg = beautiful.bg_normal,
	ontop = true,
	visible = false
}

local prompt = wibox.widget.textbox()

local entries = wibox.widget {
	homogeneous = false,
	expand = true,
	forced_num_cols = 1,
	layout = wibox.layout.grid
}

colordisplay:setup {
	{
		{
			prompt,
			forced_width = dpi(400),
			forced_height = dpi(40),
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
		entries,
		margins = dpi(10),
		widget = wibox.container.margin
	},
	forced_height = dpi(460),
	layout = wibox.layout.fixed.vertical
}

-- Functions

local function next(entries)
	if index_entry ~= #filtered then
		index_entry = index_entry + 1
		if index_entry > index_start + 9 then
			index_start = index_start + 1
		end
	end
end

local function back(entries)
	if index_entry ~= 1 then
		index_entry = index_entry - 1
		if index_entry < index_start then
			index_start = index_start - 1
		end
	end
end

local function gen()
	local entries = {}

	for dir in io.popen([[ls ~/.config/awesome/color | sed 's/.*\.sh//g' | tr -s '\n']]):lines() do
		table.insert(entries, dir)
	end

	return entries
end

local function filter(cmd)

	filtered = {}
	regfiltered = {}
	
	-- Filter entries

	for _, entry in ipairs(unfiltered) do
		if string.sub(string.lower(entry), 1, string.len(cmd)) == string.lower(cmd) then
			table.insert(filtered, entry)
		elseif string.match(string.lower(entry), string.lower(cmd)) then
			table.insert(regfiltered, entry)
		end
	end

	-- Sort entries

	table.sort(filtered, function(a, b) 
		return string.lower(a) < string.lower(b) 
	end)
	table.sort(regfiltered, function(a, b) 
		return string.lower(a) < string.lower(b) 
	end)

	-- Merge entries

	for i = 1, #regfiltered do
		filtered[#filtered+1] = regfiltered[i]
	end
	
	-- Clear entries

	entries:reset()

	-- Add filtered entries

	for i, entry in ipairs(filtered) do
		local widget = wibox.widget {
			{
				{
					text = entry,
					widget = wibox.widget.textbox
				},
				margins = dpi(10),
				widget = wibox.container.margin
			},
			widget = wibox.container.background
		}

		if index_start <= i and i <= index_start + 9 then
			entries:add(widget)
		end

		if i == index_entry then
			widget.bg = beautiful.bg_focus
		end
	end

	-- Fix position

	if index_entry > #filtered then
		index_entry = 1
		index_start = 1
	elseif index_entry < 1 then
		index_entry = 1
	end

	collectgarbage()
end

local function open()

	-- Reset index and page

	index_start = 1
	index_entry = 1

	-- Get entries

	unfiltered = gen()
	filter("")

	-- Prompt

	awful.prompt.run {
		prompt = "Color ",
		textbox = prompt,
		done_callback = function() 
			colordisplay.visible = false 
		end,
		changed_callback = function(cmd) 
			filter(cmd) 
		end,
		exe_callback = function(cmd)
			local entry = filtered[index_entry]
			awful.spawn.easy_async_with_shell("~/.config/awesome/color/" .. entry .. "/" .. entry .. ".sh")
		end,
		keypressed_callback = function(mod, key, cmd)
			if key == "Down" then
				next(entries)
			elseif key == "Up" then
				back(entries)
			end
		end
	}
end

awesome.connect_signal("widget::color", function()
	open()

	colordisplay.visible = not colordisplay.visible

	awful.placement.centered(
		colordisplay,
		{
			parent = awful.screen.focused()
		}
	)
end)
