local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local notifcontainer = wibox.widget {
	spacing = dpi(10),
	layout = wibox.layout.fixed.vertical
}

local notifempty = wibox.widget {
	wibox.widget.textbox("No Notifications"),
	fill_vertical = true,
	align = "center",
	layout = wibox.container.place
}

local function notifbutton(widget)
	return hovercursor(wibox.widget {
		{
			iconbox({ image = widget.image }),
			margins = dpi(5),
			widget = wibox.container.margin
		},
		widget = background({ bg = "bgalt", fg = "fg" })
	})
end

local function removenotif(notif)
	notifcontainer:remove_widgets(notif)
	if #notifcontainer.children == 0 then
		notifempty.visible = true
	end
end

local function createnotif(n)
	local notif = wibox.widget {
		{
			{
				{
					{
						{
							{
								wibox.widget.textbox(n.title),
								width = dpi(140),
								widget = wibox.container.constraint
							},
							nil,
							{
								{ id = "remove", widget = hovercursor(wibox.widget {
									{
										iconbox({ image = "close" }),
										margins = dpi(5),
										widget = wibox.container.margin
									},
									widget = background({ bg = "bgmid", fg = "fg" })
								})},
								valign = "top",
								widget = wibox.container.place
							},
							layout = wibox.layout.align.horizontal
						},
						left = dpi(10),
						right = dpi(5),
						top = dpi(5),
						bottom = dpi(5),
						widget = wibox.container.margin
					},
					widget = background({ bg = "bgmid", fg = "fg" })
				},
				{
					wibox.widget.textbox(n.message:gsub("'", "\'")),
					margins = dpi(5),
					widget = wibox.container.margin
				},
				spacing = dpi(5),
				layout = wibox.layout.fixed.vertical
			},
			margins = dpi(10),
			widget = wibox.container.margin
		},
		widget = background({ bg = "bgalt", fg = "fg" })
	}

	notif:get_children_by_id("remove")[1].buttons = { awful.button({}, 1, function() removenotif(notif) end) }

	return notif
end

local notifs = wibox.widget {
	{
		{
			{
				{
					{ id = "pageup", widget = notifbutton({ image = "up" }) },
					{ id = "pagedown", widget = notifbutton({ image = "down" }) },
					spacing = dpi(10),
					layout = wibox.layout.fixed.horizontal
				},
				nil,
				{ id = "clear", widget = notifbutton({ image = "close" }) },
				layout = wibox.layout.align.horizontal
			},
			{
				notifempty,
				notifcontainer,
				layout = wibox.layout.stack
			},
			spacing = dpi(10),
			layout = wibox.layout.fixed.vertical
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	forced_width = dpi(220),
	forced_height = dpi(340),
	widget = background({ bg = "bgmid", fg = "fg" })
}

local notifposition = 1
local function notifmove(direction)
	if #notifcontainer.children > 0 then
		if direction == "down" then
			if notifposition < #notifcontainer.children then
				notifcontainer.children[notifposition].visible = false
				notifposition = notifposition + 1
			end
		elseif direction == "up" then
			if notifposition > 1 then
				notifposition = notifposition - 1
				notifcontainer.children[notifposition].visible = true
			end
		end
	end
end

notifs:get_children_by_id("pageup")[1].buttons = { awful.button({}, 1, function() notifmove("up") end) }
notifs:get_children_by_id("pagedown")[1].buttons = { awful.button({}, 1, function() notifmove("down") end) }
notifs:get_children_by_id("clear")[1].buttons = { awful.button({}, 1, function() notifcontainer:reset() notifempty.visible = true notifposition = 1 end) }

local activelen = 0
naughty.connect_signal("property::active", function()
	local notiflen = #naughty.active
	if notiflen > activelen then
		notifcontainer:insert(1, createnotif(naughty.active[notiflen]))
		notifempty.visible = false
	end
	activelen = notiflen
end)

return notifs
