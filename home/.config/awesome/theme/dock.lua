local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")

local tasklist

local pins = wibox.widget {
	spacing = dpi(5),
	layout = wibox.layout.fixed.horizontal
}

local separator = wibox.widget {
	orientation = "vertical",
	thickness = dpi(2),
	span_ratio = 0.75,
	forced_width = dpi(5),
	visible = false,
	widget = live(wibox.widget.separator, { color = "bgalt" })
}

if not gears.filesystem.file_readable(gears.filesystem.get_configuration_dir() .. "json/dock.json") then
	local w = assert(io.open(".config/awesome/json/dock.json", "w"))
	w:write(require("json"):encode_pretty({}, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true }))
	w:close()
end

local r = assert(io.open(".config/awesome/json/dock.json", "r"))
local t = r:read("*all")
r:close()
local pinned = require("json"):decode(t)

local function pin(class, exec)
	local theme = Gtk.IconTheme.get_default()
	local icon = theme:lookup_icon(class:lower(), 64, 0)
	if icon then
		icon = icon:get_filename()
	else
		icon = require("menubar").utils.lookup_icon_uncached(class:lower())
		if not icon then
			icon = theme:lookup_icon("application-default-icon", 64, 0):get_filename()
		end
	end
	local widget = hovercursor(wibox.widget {
		{
			{
				{
					shape = function(cr, width, height)
								gears.shape.rounded_rect(cr, width, height, dpi(8))
							end,
					id = "background",
					bg = beautiful.bg,
					widget = wibox.container.background
				},
				bottom = dpi(2),
				widget = wibox.container.margin
			},
			shape = function(cr, width, height)
						gears.shape.rounded_rect(cr, width, height, dpi(10))
					end,
			id = "foreground",
			bg = beautiful.fg,
			widget = wibox.container.background
		},
		{
			wibox.widget.imagebox(icon),
			margins = dpi(5),
			widget = wibox.container.margin
		},
		layout = wibox.layout.stack
	})

	local function check()
		local present = false
		local focused = false
		if client.focus and client.focus.class == class then
			widget:get_children_by_id("background")[1].bg = beautiful.bgalt
			widget:get_children_by_id("foreground")[1].bg = beautiful.fg
			widget.buttons = {
				awful.button({}, 1, function()
					for _, c in ipairs(client.get()) do
						if c.class == class then
							c.minimized = false
							c:raise()
						end
					end
				end),
				awful.button({ "Shift" }, 1, function()
					awful.spawn.with_shell(exec)
				end),
				awful.button({}, 3, function()
					for i, app in ipairs(pinned) do
						if app.class == class then
							table.remove(pinned, i)
						end
					end
					pins:remove(pins:index(widget))
					tasklist._do_tasklist_update_now()
					local w = assert(io.open(".config/awesome/json/dock.json", "w"))
					w:write(require("json"):encode_pretty(pinned, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true }))
					w:close()
				end)
			}
			present = true
			focused = true
		end
		if not focused then
			for _, c in ipairs(client.get()) do
				if c.class == class then
					widget:get_children_by_id("background")[1].bg = beautiful.bgmid
					widget:get_children_by_id("foreground")[1].bg = beautiful.fg .. "64"
					widget.buttons = {
						awful.button({}, 1, function()
							c.first_tag:view_only() -- check current tag first?
							for _, c in ipairs(client.get()) do
								if c.class == class then
									c.minimized = false
									c:raise()
									c:activate()
								end
							end
						end),
						awful.button({ "Shift" }, 1, function()
							awful.spawn.with_shell(exec)
						end),
						awful.button({}, 3, function()
							for i, app in ipairs(pinned) do
								if app.class == class then
									table.remove(pinned, i)
								end
							end
							pins:remove(pins:index(widget))
							tasklist._do_tasklist_update_now()
							local w = assert(io.open(".config/awesome/json/dock.json", "w"))
							w:write(require("json"):encode_pretty(pinned, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true }))
							w:close()
						end)
					}
					present = true
					return
				end
			end
		end
		if not present then
			widget:get_children_by_id("background")[1].bg = beautiful.bg
			widget:get_children_by_id("foreground")[1].bg = beautiful.bg
			widget.buttons = {
				awful.button({}, 1, function()
					awful.spawn.with_shell(exec)
				end),
				awful.button({}, 3, function()
					for i, app in ipairs(pinned) do
						if app.class == class then
							table.remove(pinned, i)
						end
					end
					pins:remove(pins:index(widget))
					tasklist._do_tasklist_update_now()
					local w = assert(io.open(".config/awesome/json/dock.json", "w"))
					w:write(require("json"):encode_pretty(pinned, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true }))
					w:close()
				end)
			}
		end
		widget:emit_signal("widget::redraw_needed")
	end

	client.connect_signal("request::manage", check)
	client.connect_signal("request::unmanage", check)
	client.connect_signal("focus", check)
	client.connect_signal("unfocus", check)
	awesome.connect_signal("live::reload", check)

	check()

	return widget
end

local function contains(table, name)
	for _, app in ipairs(table) do
		if app == name then
			return true
		end
	end
	return false
end

tasklist = awful.widget.tasklist {
	screen = awful.screen.focused(),
	filter = awful.widget.tasklist.filter.allscreen,
	source = function()
		local seen = {}
		local ret = {}

		for _, c in ipairs(client.get()) do
			local exclude = false
			for _, app in ipairs(pinned) do
				if c.class == app.class then
					exclude = true
					break
				end
			end
			if not exclude and not contains(seen, c.class) or c.minimized == true then
				table.insert(seen, c.class)
				table.insert(ret, c)
			end
		end

		if seen[1] and pinned[1] then
			separator.visible = true
		else
			separator.visible = false
		end

		return ret
	end,
	style = {
		shape = function(cr, width, height)
					gears.shape.rounded_rect(cr, width, height, dpi(10))
				end
	},
	layout = {
		spacing = dpi(5),
		spacing_widget = wibox.container.background,
		layout = wibox.layout.fixed.horizontal
	},
	widget_template = {
		{
			{
				{
					awful.widget.clienticon,
					margins = dpi(5),
					widget = wibox.container.margin
				},
				shape = function(cr, width, height)
							gears.shape.rounded_rect(cr, width, height, dpi(8))
						end,
				id = "background",
				widget = wibox.widget.background
			},
			bottom = dpi(2),
			widget = wibox.container.margin
		},
		shape = function(cr, width, height)
					gears.shape.rounded_rect(cr, width, height, dpi(10))
				end,
		id = "foreground",
		bg = beautiful.fg,
		widget = wibox.container.background,
		create_callback = function(self, c)
			local exec
			if c.pid then
				awful.spawn.easy_async("readlink -f /proc/" .. c.pid .. "/exe", function(out)
					exec = out:gsub("\n", "")
				end)
			end
			self.buttons = {
				awful.button({}, 1, function()
					c.first_tag:view_only()
					c.minimized = false
					c:raise()
				end),
				awful.button({}, 3, function()
					local seen
					for _, app in ipairs(pinned) do
						if app.class == c.class then
							seen = true
							return
						end
					end
					if not seen then
						pins:add(pin(c.class, exec))
						table.insert(pinned, { class = c.class, exec = exec })
						tasklist._do_tasklist_update_now()
						local w = assert(io.open(".config/awesome/json/dock.json", "w"))
						w:write(require("json"):encode_pretty(pinned, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true }))
						w:close()
					end
				end)
			}
			hovercursor(self)

			if client.focus == c then
				self:get_children_by_id("background")[1].bg = beautiful.bgalt
				self:get_children_by_id("foreground")[1].bg = beautiful.fg
			else
				self:get_children_by_id("background")[1].bg = beautiful.bgmid
				self:get_children_by_id("foreground")[1].bg = beautiful.fg .. "64"
			end
			client.connect_signal("focus", function()
				if client.focus == c then
					self:get_children_by_id("background")[1].bg = beautiful.bgalt
					self:get_children_by_id("foreground")[1].bg = beautiful.fg
				else
					self:get_children_by_id("background")[1].bg = beautiful.bgmid
					self:get_children_by_id("foreground")[1].bg = beautiful.fg .. "64"
				end
			end)
			client.connect_signal("unfocus", function()
				self:get_children_by_id("background")[1].bg = beautiful.bgmid
				self:get_children_by_id("foreground")[1].bg = beautiful.fg .. "64"
			end)
			awesome.connect_signal("live::reload", function()
				if client.focus == c then
					self:get_children_by_id("background")[1].bg = beautiful.bgalt
					self:get_children_by_id("foreground")[1].bg = beautiful.fg
				else
					self:get_children_by_id("background")[1].bg = beautiful.bgmid
					self:get_children_by_id("foreground")[1].bg = beautiful.fg .. "64"
				end
			end)
		end
	}
}

for _, app in ipairs(pinned) do
	pins:add(pin(app.class, app.exec))
end

local dock = wibox.widget {
	{
		pins,
		separator,
		tasklist,
		spacing = dpi(5),
		layout = wibox.layout.fixed.horizontal
	},
	halign = "center",
	widget = wibox.container.place
}

return dock
