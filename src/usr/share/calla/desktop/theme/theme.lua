local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local iconpath = require("gears").filesystem.get_configuration_dir() .. "theme/icons/"

local color = readjson(gears.filesystem.get_configuration_dir() .. "color/" .. user.color .. "/" .. user.color .. ".json")

local theme = {}

theme.bg	  = color.bg
theme.bgmid	  = color.bgmid
theme.bgalt	  = color.bgalt
theme.fg	  = color.fg
theme.black   = color.black
theme.white	  = color.white
theme.red     = color.red
theme.green	  = color.green
theme.yellow  = color.yellow
theme.blue	  = color.blue
theme.magenta = color.magenta
theme.cyan	  = color.cyan

-- Default

theme.font 			= user.font

theme.bg_normal     = color.bg
theme.bg_focus      = color.bgalt
theme.bg_urgent     = color.red

theme.fg_normal     = color.fg
theme.fg_focus      = color.fg
theme.fg_urgent     = color.red

-- Titlebar

theme.titlebar_bg_normal   = color.bg
theme.titlebar_bg_focus    = color.bg
theme.titlebar_bg_urgent   = color.bg

theme.titlebar_fg_normal   = color.fg .. "40"
theme.titlebar_fg_focus    = color.fg
theme.titlebar_fg_urgent   = color.red

-- Tasklist

theme.tasklist_bg_normal   = color.bgmid
theme.tasklist_bg_focus    = color.fg .. "20"
theme.tasklist_bg_urgent   = color.bgmid
theme.tasklist_bg_minimize = color.bg

-- Taglist

theme.taglist_bg_focus    = color.bgmid
theme.taglist_bg_urgent   = color.bgmid

theme.taglist_fg_focus    = color.fg
theme.taglist_fg_urgent   = color.red

-- Snap

theme.snap_bg     = color.fg
theme.snap_shape  = function(cr, width, height)
						gears.shape.rounded_rect(cr, width, height, dpi(15))
					end
theme.snapper_gap = dpi(15)

-- Misc

theme.useless_gap           = dpi(5)
theme.border_width          = dpi(0)
theme.bg_systray    	    = color.bgmid
theme.systray_icon_spacing  = dpi(5)
theme.notification_spacing  = dpi(20)
theme.tooltip_opacity       = 0
theme.prompt_bg_cursor		= color.fg

-- Wallpaper

color.wall = gears.filesystem.get_configuration_dir() .. color.wall
theme.wallpaper = user.wallpaper or color.wall

-- Layout icons

theme.layout_floating  = gears.color.recolor_image(iconpath .. "floating.png", color.fg)
theme.layout_tile	   = gears.color.recolor_image(iconpath .. "tile.png", color.fg)

-- Theme icon

theme.calla = gears.color.recolor_image(iconpath .. "calla.png", color.fg)

-- Profile picture

if gears.filesystem.file_readable(iconpath .. "pfp.png") then
	theme.pfp = iconpath .. "pfp.png"
else
	theme.pfp = theme.calla
end

-- Icon theme

theme.icons = color.icons

return theme
