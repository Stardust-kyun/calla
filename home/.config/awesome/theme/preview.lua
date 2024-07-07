local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local scale = 0.15

local function createpreview(t, s, geometry)
    local clientlayout = wibox.layout.manual()
    clientlayout.forced_height = geometry.height
    clientlayout.forced_width = geometry.width
    for _, c in ipairs(t:clients()) do
        if not c.hidden and not c.minimized then

            local imagebox = wibox.widget {
                resize = true,
                forced_height = dpi(150) * scale,
                forced_width = dpi(150) * scale,
                widget = wibox.widget.imagebox
            }

			if not pcall(function() imagebox.image = gears.surface.load(c.icon) end) then
				imagebox.image = beautiful.calla
			end

            local clientbox = wibox.widget({
                {
                    nil,
                    {
                        nil,
                        imagebox,
                        nil,
                        expand = "outside",
                        layout = wibox.layout.align.horizontal,
                    },
                    nil,
                    expand = "outside",
                    widget = wibox.layout.align.vertical,
                },
                forced_height = math.floor(c.height * scale),
                forced_width = math.floor(c.width * scale),
                bg = beautiful.bg,
				border_width = dpi(2),
				border_color = beautiful.bgmid,
                shape = function(cr, width, height)
							gears.shape.rounded_rect(cr, width, height, dpi(10))
						end,
                widget = wibox.container.background
            })

            clientbox.point = {
                x = math.floor((c.x - geometry.x) * scale),
                y = math.floor((c.y - geometry.y) * scale),
            }

            clientlayout:add(clientbox)
        end
    end

	if t:clients()[1] == nil then
		return wibox.widget {
			{
				{
					image = gears.surface.crop_surface {
						surface = gears.surface.load_uncached(beautiful.wallpaper),
						ratio = s.geometry.width/s.geometry.height
					},
					widget = wibox.widget.imagebox
				},
				{
					{
						{
							{
								colortext({ text = "Empty" }),
								top = dpi(5),
								bottom = dpi(5),
								left = dpi(8),
								right = dpi(8),
								widget = wibox.container.margin
							},
							bg = beautiful.bg,
							shape = function(cr, width, height)
										gears.shape.rounded_rect(cr, width, height, dpi(10))
									end,
							widget = wibox.container.background
						},
						valign = "center",
						halign = "center",
						widget = wibox.container.place
					},
					bg = beautiful.bg.."96",
					widget = wibox.container.background
				},
				layout = wibox.layout.stack
			},
			shape = function(cr, width, height)
						gears.shape.rounded_rect(cr, width, height, dpi(10))
					end,
			widget = wibox.container.background
		}
	else
		return wibox.widget {
			{
				{
					image = gears.surface.crop_surface {
						surface = gears.surface.load_uncached(beautiful.wallpaper),
						ratio = s.geometry.width/s.geometry.height
					},
					widget = wibox.widget.imagebox
				},
				{
					clientlayout,
					forced_height = geometry.height,
					forced_width = geometry.width,
					widget = wibox.container.place
				},
				layout = wibox.layout.stack
			},
			shape = function(cr, width, height)
						gears.shape.rounded_rect(cr, width, height, dpi(10))
					end,
			widget = wibox.container.background
		}
	end
end

local previewbox = wibox {
	width = dpi(100),
	height = dpi(100),
	ontop = true,
	visible = false,
	widget = live(wibox.container.background, { bg = "bg" })
}

local previewlist = wibox.widget {
	expand = true,
	orientation = "horizontal",
	spacing = dpi(5),
	layout = wibox.layout.grid
}

awesome.connect_signal("widget::preview", function()
	awesome.emit_signal("widget::launcher:hide")

	if previewbox.visible then
		previewbox.visible = false
		return
	end

	previewlist:reset()

	local geometry = awful.screen.focused():get_bounding_geometry()
	local tags = awful.screen.focused().tags
	local numtags

	for i, tag in ipairs(tags) do
		numtags = i

		local preview = wibox.widget {
			hovercursor(createpreview(tag, tag.screen, geometry)),
			buttons = {
				awful.button({}, 1, function()
					awesome.emit_signal("widget::preview")
					tag:view_only()
				end)
			},
			widget = wibox.container.background
		}

		previewlist:add(preview)
	end

	previewbox.width = geometry.width * scale * numtags + (numtags + 1) * dpi(5)
	previewbox.height = geometry.height * scale + (2 * dpi(5))
	previewbox.widget = wibox.widget {
			{
			previewlist,
			margins = dpi(5),
			widget = wibox.container.margin
		},
		widget = live(wibox.container.background, { bg = "bg" })
	}

	awful.placement.bottom_left(
		previewbox,
		{
			margins = {
				bottom = dpi(60),
				left = dpi(10),
			},
			parent = awful.screen.focused()
		}
	)

	previewbox.visible = true
end)

awesome.connect_signal("widget::preview:hide", function()
	previewbox.visible = false
end)
