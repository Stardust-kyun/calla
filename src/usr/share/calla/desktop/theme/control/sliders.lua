local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local function slider()
	return wibox.widget {
		bar_shape = gears.shape.rounded_rect,
		bar_height = dpi(5),
		bar_color = beautiful.bgalt,
		bar_active_color = beautiful.fg,
		handle_color = beautiful.fg,
		handle_shape = gears.shape.rounded_rect,
		handle_width = dpi(10),
		forced_height = dpi(10),
		value = 0,
		maximum = 100,
		widget = live(wibox.widget.slider, { bar_color = "bgalt", bar_active_color = "fg", handle_color = "fg" })
	}
end

local volumeslider = slider()

local volumepercent = wibox.widget.textbox()

local volumeicon = iconbox({ image = "volumemute" })

local volumehovering = false
local volumestore = 0
local mutestore = false

local function editvolume(volume, mute)
	if volume ~= nil then
		volumestore = volume
		mutestore = mute
	else
		volume = volumestore
		mute = mutestore
	end
	if not volumehovering then
		volumeslider.value = volume
	end
	if mute then
		volumepercent.text = "Muted"
		volumeicon.image = createicon("volumemute")
	else
		volumepercent.text = tostring(volume) .. "%"
		if volume > 100 then
			volumeicon.image = createicon("volumewarn")
		elseif volume >= 50 then
			volumeicon.image = createicon("volume100")
		elseif volume >= 25 then
			volumeicon.image = createicon("volume50")
		elseif volume > 0 then
			volumeicon.image = createicon("volume25")
		elseif volume == 0 then
			volumeicon.image = createicon("volume0")
		end
	end
end

awesome.connect_signal("signal::volume", function(volume, mute)
	editvolume(volume, mute)
end)
awesome.connect_signal("live::reload", function()
	editvolume()
end)

-- Very hacky workaround, vol will only be changed with signal when mouse is outside of slider
volumeslider:connect_signal("mouse::enter", function()
	volumehovering = true
end)
volumeslider:connect_signal("mouse::leave", function()
	volumehovering = false
end)
volumeslider:connect_signal("property::value", function(_, new)
	if volumehovering then
		awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
		awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. new .. "%")
	end
end)

local volume = wibox.widget {
	{
		{
			{
				wibox.widget.textbox("Volume"),
				nil,
				volumepercent,
				layout = wibox.layout.align.horizontal
			},
			nil,
			{
				volumeicon,
				{
					volumeslider,
					forced_height = dpi(10),
					widget = wibox.container.place
				},
				spacing = dpi(10),
				layout = wibox.layout.fixed.horizontal
			},
			layout = wibox.layout.align.vertical
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	forced_height = dpi(65),
	widget = background({ bg = "bgmid", fg = "fg" })
}

local brightnessslider = slider()

local brightnesspercent = wibox.widget.textbox()

local brightnessicon = iconbox({ image = "brightness0" })

local brightnesshovering = false
local brightnessstore = 0

local function editbrightness(brightness)
	if brightness ~= nil then
		brightnessstore = brightness
	else
		brightness = brightnessstore
	end
	if not brightnesshovering then
		brightnessslider.value = brightness
	end
	brightnesspercent.text = tostring(brightness) .. "%"
	if brightness >= 75 then
		brightnessicon.image = createicon("brightness100")
	elseif brightness >= 50 then
		brightnessicon.image = createicon("brightness75")
	elseif brightness >= 25 then
		brightnessicon.image = createicon("brightness50")
	elseif brightness > 0 then
		brightnessicon.image = createicon("brightness25")
	elseif brightness == 0 then
		brightnessicon.image = createicon("brightness0")
	end
end
awesome.connect_signal("signal::brightness", function(brightness)
	editbrightness(brightness)
end)
awesome.connect_signal("live::reload", function()
	editbrightness()
end)

brightnessslider:connect_signal("mouse::enter", function()
	brightnesshovering = true
end)
brightnessslider:connect_signal("mouse::leave", function()
	brightnesshovering = false
end)
brightnessslider:connect_signal("property::value", function(_, new)
	if brightnesshovering then
		awful.spawn.with_shell("brightnessctl s " .. new .. "%")
	end
end)

local brightness = wibox.widget {
	{
		{
			{
				wibox.widget.textbox("Brightness"),
				nil,
				brightnesspercent,
				layout = wibox.layout.align.horizontal
			},
			nil,
			{
				brightnessicon,
				{
					brightnessslider,
					forced_height = dpi(10),
					widget = wibox.container.place
				},
				spacing = dpi(10),
				layout = wibox.layout.fixed.horizontal
			},
			layout = wibox.layout.align.vertical
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	forced_height = dpi(65),
	widget = background({ bg = "bgmid", fg = "fg" })
}

local sliders = wibox.widget {
	volume,
	brightness,
	spacing = dpi(10),
	widget = wibox.layout.fixed.vertical
}

return sliders
