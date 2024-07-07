local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")

screen.connect_signal("request::desktop_decoration", function(s)

	s.dock = wibox {
		height = dpi(40),
		width = (s:get_bounding_geometry().width-dpi(10))/6,
		visible = true
	}
	
	local pins = wibox.widget {
		spacing = dpi(5),
		layout = wibox.layout.fixed.horizontal
	}

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
			icon = theme:lookup_icon("application-default-icon", 64, 0):get_filename()
		end
		local widget = hovercursor(wibox.widget {
			{
				wibox.widget.imagebox(icon),
				margins = dpi(5),
				widget = wibox.container.margin
			},
			shape = function(cr, width, height)
						gears.shape.rounded_rect(cr, width, height, dpi(10))
					end,
			bg = beautiful.bg,
			widget = wibox.container.background
		})

		local function check()
			local present = false
			local focused = false
			if client.focus and client.focus.class == class then
				widget.bg = beautiful.bgalt
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
						s.tasklist._do_tasklist_update_now()
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
						widget.bg = beautiful.bgmid
						widget.buttons = {
							awful.button({}, 1, function()
								if client.focus and c.first_tag ~= client.focus.first_tag or not client.focus then
									c.first_tag:view_only()
									for _, c in ipairs(client.get()) do
										if c.class == class then
											c.minimized = false
											c:raise()
										end
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
								s.tasklist._do_tasklist_update_now()
								local w = assert(io.open(".config/awesome/json/dock.json", "w"))
								w:write(require("json"):encode_pretty(pinned, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true }))
								w:close()
							end)
						}
						present = true
					end
				end
			end
			if not present then
				widget.bg = beautiful.bg
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
						s.tasklist._do_tasklist_update_now()
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

	s.tasklist = awful.widget.tasklist {
		screen = s,
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
				if not exclude and not contains(seen, c.class) then
					table.insert(seen, c.class)
					table.insert(ret, c)
				end
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
				awful.widget.clienticon,
				margins = dpi(5),
				widget = wibox.container.margin
			},
			widget = wibox.widget.background,
			create_callback = function(self, c)
				local exec
				awful.spawn.easy_async("readlink -f /proc/" .. c.pid .. "/exe", function(out)
					exec = out:gsub("\n", "")
				end)
				self.shape = function(cr, width, height)
						gears.shape.rounded_rect(cr, width, height, dpi(10))
					end
				self.buttons = {
					awful.button({}, 1, function()
						if client.focus and c.first_tag ~= client.focus.first_tag then
							c.first_tag:view_only()
							c:raise()
						end
					end),
					awful.button({ "Shift" }, 1, function()
						awful.spawn.with_shell(exec)
					end),
					awful.button({}, 3, function()
						pins:add(pin(c.class, exec))
						table.insert(pinned, { class = c.class, exec = exec })
						s.tasklist._do_tasklist_update_now()
						local w = assert(io.open(".config/awesome/json/dock.json", "w"))
						w:write(require("json"):encode_pretty(pinned, nil, { pretty = true, indent = "	", align_keys = false, array_newline = true }))
						w:close()
					end)
				}
				hovercursor(self)

				if client.focus and client.focus.class == c.class then
					self.bg = beautiful.bgalt
				else
					self.bg = beautiful.bgmid
				end

				local class = c.class -- for some reason using c.class borks

				client.connect_signal("focus", function()
					if client.focus and client.focus.class == class then
						self.bg = beautiful.bgalt
					else
						self.bg = beautiful.bgmid
					end
				end)
				client.connect_signal("unfocus", function()
					self.bg = beautiful.bgmid
				end)
				awesome.connect_signal("live::reload", function()
					if client.focus and client.focus.class == class then
						self.bg = beautiful.bgalt
					else
						self.bg = beautiful.bgmid
					end
				end)
			end
		}
	}

	for _, app in ipairs(pinned) do
		pins:add(pin(app.class, app.exec))
	end

	s.dock:setup {
		{
			{
			{
				pins,
				s.tasklist,
				spacing = dpi(5),
				layout = wibox.layout.fixed.horizontal
			},
			margins = dpi(5),
			widget = wibox.container.margin
		},
		halign = "center",
		widget = wibox.container.place
		},
		widget = live(wibox.container.background, { bg = "bg" })
	}

	awful.placement.bottom_right(
		s.dock,
		{
			margins = {
				bottom = dpi(10),
				right = dpi(10)
			},
			parent = s
		}
	)

end)
