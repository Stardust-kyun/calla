local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local function togglebutton(widget)
	local switch = function(param, cases)
		local case = cases[param]
		if case then return case() end
	end

	local onicon, officon
	local icon = iconbox({ image = "error" })

	local state
	local iscompositor, compositorinit
	if widget == "compositor" then iscompositor, compositorinit = true, false end

	local button = hovercursor(wibox.widget {
		{
			icon,
			margins = dpi(5),
			widget = wibox.container.margin
		},
		forced_width = dpi(95),
		forced_height = dpi(50),
		widget = background({ bg = "bgalt", fg = "fg" })
	})

	local function init()
		switch(widget, {
			["wifi"] = function()
				onicon, officon = "wifion", "wifioff"
			end,
			["bluetooth"] = function()
				onicon, officon = "bluetoothon", "bluetoothoff"
			end,
			["compositor"] = function()
				onicon, officon = "compositoron", "compositoroff"
			end,
			["notifs"] = function()
				onicon, officon = "notificationson", "notificationsoff"
			end
		})
	end

	local function getstate()
		local function finish()
			if state then
				icon.image = createicon(onicon)
				button.bg = beautiful.fg .. 33
			else
				icon.image = createicon(officon)
				button.bg = beautiful.bgalt
			end
		end

		switch(widget, {
			["wifi"] = function()
				state = awful.spawn.easy_async_with_shell("nmcli radio wifi", function(out)
					if out:match("enabled") then
						 state = true
					else
						 state = false
					end
					finish()
				end)
			end,
			["bluetooth"] = function()
				state = awful.spawn.easy_async_with_shell("bluetoothctl show | grep 'Powered: yes'", function(out)
					if out ~= "" then
						 state = true
					else
						 state = false
					end
					finish()
				end)
			end,
			["compositor"] = function()
				awful.spawn.easy_async_with_shell("ps aux | grep picom | grep -v grep", function(out)
					if not compositorinit then awesome.emit_signal("compositor::init") compositorinit = true end
					if out ~= "" then
						 state = true
					else
						 state = false
					end
					finish()
				end)
			end,
			["notifs"] = function()
				state = not naughty.suspended
				finish()
			end
		})
	end

	local function changestate()
		switch(widget, {
			["wifi"] = function()
				local command
				if state then
					command = "off"
				else
					command = "on"
				end
				awful.spawn.easy_async_with_shell("nmcli radio wifi " .. command, function() getstate() end)
			end,
			["bluetooth"] = function()
				local command
				if state then
					command = "off"
				else
					command = "on"
				end
				awful.spawn.easy_async_with_shell("bluetoothctl power " .. command, function() getstate() end)
			end,
			["compositor"] = function()
				if state then
					awful.spawn.easy_async_with_shell("killall picom", function() getstate() end)
				else
					awful.spawn.easy_async_with_shell("picom -b --config '/usr/share/calla/compositor.conf'", function() getstate() end)
				end
			end,
			["notifs"] = function()
				naughty.suspended = not naughty.suspended
				getstate()
			end
		})
	end

	if iscompositor then
		awesome.connect_signal("compositor::init", function()
			init()
			getstate()
			button.buttons = { awful.button({}, 1, changestate) }
		end)
	else
		init()
		getstate()
		button.buttons = { awful.button({}, 1, changestate) }
	end
	awesome.connect_signal("live::reload", function()
		getstate()
	end)

	return button
end

local toggles = wibox.widget {
	{
		{
			togglebutton("wifi"),
			togglebutton("bluetooth"),
			togglebutton("compositor"),
			togglebutton("notifs"),
			column_count = 2,
			spacing = dpi(10),
			layout = wibox.layout.grid
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	forced_width = dpi(220),
	forced_height = dpi(130),
	widget = background({ bg = "bgmid", fg = "fg" })
}

return toggles

