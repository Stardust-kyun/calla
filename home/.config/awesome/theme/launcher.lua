local wibox = require("wibox")
local awful = require("awful")
local Gio = require("lgi").Gio
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Widgets

local launcherdisplay = wibox {
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

launcherdisplay:setup {
	{
		{
			prompt,
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
	layout = wibox.layout.fixed.vertical
}

-- Functions

local function next()
	if entryindex ~= #filtered then
		entries:get_widgets_at(entryindex, 1)[1].bg = nil
		entries:get_widgets_at(entryindex+1, 1)[1].bg = beautiful.bg_focus
		entryindex = entryindex + 1
		if entryindex > startindex + 9 then
			entries:get_widgets_at(entryindex-10, 1)[1].visible = false
			entries:get_widgets_at(entryindex, 1)[1].visible = true
			startindex = startindex + 1
		end
	end
	move = true
end

local function back()
	if entryindex ~= 1 then
		entries:get_widgets_at(entryindex, 1)[1].bg = nil
		entries:get_widgets_at(entryindex-1, 1)[1].bg = beautiful.bg_focus
		entryindex = entryindex - 1
		if entryindex < startindex then
			entries:get_widgets_at(entryindex+10, 1)[1].visible = false
			entries:get_widgets_at(entryindex, 1)[1].visible = true
			startindex = startindex - 1
		end
	end
	move = true
end

local function gen()
	local entries = {}
	for _, entry in ipairs(Gio.AppInfo.get_all()) do
		if entry:should_show() then
			local name = entry:get_name():gsub("&", "&amp;"):gsub("<", "&lt;"):gsub("'", "&#39;")
			table.insert(
				entries,
				{ name = name, appinfo = entry }
			)
		end
	end
	return entries
end

local function filter(cmd)

	filtered = {}
	regfiltered = {}
	
	-- Filter entries

	for _, entry in ipairs(unfiltered) do
		if entry.name:lower():sub(1, cmd:len()) == cmd:lower() then
			table.insert(filtered, entry)
		elseif entry.name:lower():match(cmd:lower()) then
			table.insert(regfiltered, entry)
		end
	end

	-- Sort entries

	table.sort(filtered, function(a, b) return a.name:lower() < b.name:lower() end)
	table.sort(regfiltered, function(a, b) return a.name:lower() < b.name:lower() end)

	-- Merge entries

	for i = 1, #regfiltered do
		filtered[#filtered+1] = regfiltered[i]
	end
	
	-- Clear entries

	entries:reset()

	-- Fix position

	entryindex, startindex = 1, 1

	-- Add filtered entries

	for i, entry in ipairs(filtered) do
		local widget = hovercursor(wibox.widget {
			{
				{
					text = entry.name,
					widget = wibox.widget.textbox
				},
				margins = dpi(10),
				widget = wibox.container.margin
			},
			buttons = {
				awful.button({}, 1, function()
					if entryindex == i then
						local entry = filtered[entryindex]
						entry.appinfo:launch()
						awful.keygrabber.stop()
						launcherdisplay.visible = false
					else
						entries:get_widgets_at(entryindex, 1)[1].bg = nil
						entryindex = i
						entries:get_widgets_at(entryindex, 1)[1].bg = beautiful.bg_focus
					end
				end),
				awful.button({}, 3, function()
					awful.keygrabber.stop()
					launcherdisplay.visible = false
				end),
				awful.button({}, 4, function()
					back()
				end),
				awful.button({}, 5, function()
					next()
				end)
			},
			widget = wibox.container.background
		})

		if startindex <= i and i <= startindex + 9 then
			widget.visible = true
		else
			widget.visible = false
		end

		entries:add(widget)

		if i == entryindex then
			widget.bg = beautiful.bg_focus
		end
	end

	collectgarbage("collect")

end

local function open()

	-- Reset variables

	startindex, entryindex, move = 1, 1, false

	-- Get entries

	unfiltered = gen()
	filter("")

	-- Prompt

	awful.prompt.run {
		prompt = "Launch ",
		textbox = prompt,
		done_callback = function() 
			launcherdisplay.visible = false 
		end,
		changed_callback = function(cmd)
			if move == false then	
				filter(cmd)
			else
				move = false
			end
		end,
		exe_callback = function(cmd)
			local entry = filtered[entryindex]
			if entry then
				entry.appinfo:launch()
			else
				awful.spawn.with_shell(cmd)
			end
		end,
		keypressed_callback = function(_, key)
			if key == "Down" then
				next()
			elseif key == "Up" then
				back()
			end
		end
	}
end

awesome.connect_signal("widget::launcher", function()
	open()

	launcherdisplay.visible = not launcherdisplay.visible

	awful.placement.centered(
		launcherdisplay,
		{
			parent = awful.screen.focused()
		}
	)
end)
