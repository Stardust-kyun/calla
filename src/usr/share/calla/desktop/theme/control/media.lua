local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local function mediabutton(args)
	return hovercursor(wibox.widget {
		buttons = { awful.button({}, 1, args.run) },
		widget = iconbox({ image = args.icon, size = dpi(24) })
	})
end

local media = wibox.widget {
	{
		{
			{
				{
					{
						id = "cover",
						upscale = false,
						downscale = true,
						valign = "center",
						halign = "center",
						clip_shape = function(cr, width, height)
							gears.shape.rounded_rect(cr, width, height, dpi(5))
						end,
						widget = wibox.widget.imagebox
					},
					widget = background({ bg = "bgalt", fg = "fg" })
				},
				width = dpi(200),
				height = dpi(200),
				strategy = "exact",
				widget = wibox.container.constraint
			},
			nil,
			{
				{
					{
						{
							{
								id = "title",
								align = "center",
								widget = wibox.widget.textbox("Not Playing")
							},
							height = dpi(20),
							widget = wibox.container.constraint
						},
						{
							{
								id = "artist",
								align = "center",
								widget = wibox.widget.textbox("No Artist")
							},
							height = dpi(20),
							widget = wibox.container.constraint
						},
						spacing = dpi(5),
						layout = wibox.layout.fixed.vertical
					},
					align = "center",
					widget = wibox.container.place
				},
				{
					{
						{
							id = "elapsed",
							widget = wibox.widget.textbox("0:00")
						},
						right = dpi(10),
						widget = wibox.container.margin
					},
					{
						{
							id = "progress",
							max_value = 0,
							value = 0,
							bar_shape = gears.shape.rounded_rect,
							shape = gears.shape.rounded_rect,
							forced_height = dpi(5),
							expand = true,
							widget = live(wibox.widget.progressbar, { color = "fg", background_color = "bgalt" })
						},
						forced_height = dpi(10),
						widget = wibox.container.place
					},
					{
						{
							id = "total",
							widget = wibox.widget.textbox("0:00")
						},
						left = dpi(10),
						widget = wibox.container.margin
					},
					layout = wibox.layout.align.horizontal
				},
				{
					{
						mediabutton({ icon = "previous", run = function() awful.spawn.with_shell("playerctl previous") end }),
						{
							id = "pause",
							widget = mediabutton({ icon = "play", run = function() awful.spawn.with_shell("playerctl play-pause") end })
						},
						mediabutton({ icon = "next", run = function() awful.spawn.with_shell("playerctl next") end }),
						spacing = dpi(5),
						layout = wibox.layout.fixed.horizontal
					},
					align = "center",
					widget = wibox.container.place
				},
				spacing = dpi(10),
				layout = wibox.layout.fixed.vertical
			},
			layout = wibox.layout.align.vertical
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	forced_width = dpi(220),
	forced_height = dpi(300),
	widget = background({ bg = "bgmid", fg = "fg" })
}

awesome.connect_signal("signal::playerctl", function(title, album, artist, cover, elapsed, total, status)
	media:get_children_by_id("title")[1].text = title
	media:get_children_by_id("artist")[1].text = artist

	local coverart = cover
	if cover == "None" then coverart = beautiful.calla end
	media:get_children_by_id("cover")[1].image = coverart

	if total ~= "" then
		media:get_children_by_id("elapsed")[1].text = elapsed
		media:get_children_by_id("total")[1].text = total
		local elapsedseconds = tonumber(elapsed:match("(.*):"))*60 + tonumber(elapsed:match(":(.*)"))
		local totalseconds = tonumber(total:match("(.*):"))*60 + tonumber(total:match(":(.*)"))
		media:get_children_by_id("progress")[1].value = elapsedseconds
		media:get_children_by_id("progress")[1].max_value = totalseconds
	end

	if status then
		media:get_children_by_id("pause")[1].image = createicon("pause")
	else
		media:get_children_by_id("pause")[1].image = createicon("play")
	end

	awesome.connect_signal("live::reload", function()
		if cover == "None" then coverart = beautiful.calla end
		media:get_children_by_id("cover")[1].image = coverart
	end)
end)

return media
