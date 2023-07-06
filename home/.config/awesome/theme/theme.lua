local color = require("color." .. user.color)
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local icon_path = require("gears").filesystem.get_configuration_dir() .. "theme/icons/"

local theme = {}

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

theme.titlebar_bg_normal   = color.bgalt
theme.titlebar_bg_focus    = color.bgalt
theme.titlebar_bg_urgent   = color.bgalt

theme.titlebar_fg_normal   = color.bgalt
theme.titlebar_fg_focus    = color.fg
theme.titlebar_fg_urgent   = color.red

-- Tasklist

theme.tasklist_bg_focus    = color.bg
theme.tasklist_bg_urgent   = color.bg

theme.tasklist_fg_normal   = color.fg .. "25"
theme.tasklist_fg_focus    = color.fg
theme.tasklist_fg_urgent   = color.red
theme.tasklist_fg_minimize = color.fg .. "25"

theme.tasklist_font_minimized  = user.fontalt
theme.tasklist_plain_task_name = true

-- Taglist

theme.taglist_bg_focus    = color.bg
theme.taglist_bg_urgent   = color.bg

theme.taglist_fg_focus    = color.fg
theme.taglist_fg_urgent   = color.red
theme.taglist_fg_empty	  = color.fg .. "25"
theme.taglist_fg_occupied = color.fg .. "75"

theme.taglist_spacing = dpi(10)

-- Menu

theme.menu_submenu_icon = gears.color.recolor_image(icon_path .. "submenu.png", color.fg)
theme.menu_font         = user.font
theme.menu_bg_normal    = color.bg
theme.menu_bg_focus     = color.bg_alt
theme.menu_fg_normal    = color.fg
theme.menu_fg_focus     = color.fg
theme.menu_height       = dpi(40)
theme.menu_width        = dpi(160)

-- Snap

theme.snap_bg     = color.fg
theme.snap_shape  = gears.shape.rectangle
theme.snapper_gap = dpi(16)

-- Misc

theme.useless_gap           = dpi(8)
theme.border_width          = dpi(0)
theme.bg_systray    	    = color.bgalt
theme.systray_icon_spacing  = dpi(20)
theme.systray_max_rows		= 3
theme.notification_spacing  = dpi(10)
theme.tooltip_opacity       = 0

-- Wallpaper

theme.wallpaper = user.wallpaper or color.wall

screen.connect_signal("request::wallpaper", function(s)
	require("awful").wallpaper {
		screen = s,
		bg = theme.bg_normal
	}
end)

-- Profile picture

theme.pfp = user.pfp or gears.color.recolor_image(icon_path .. "pfp.png", color.fg)

-- Layout icons

theme.layout_floating  = gears.color.recolor_image(icon_path .. "floating.png", color.fg)
theme.layout_max	   = gears.color.recolor_image(icon_path .. "max.png", color.fg)
theme.layout_tile	   = gears.color.recolor_image(icon_path .. "tile.png", color.fg)

-- Titlebar icons

theme.close    = gears.color.recolor_image(icon_path .. "close.png", color.fg)
theme.minimize = gears.color.recolor_image(icon_path .. "minimize.png", color.fg)
theme.maximize = gears.color.recolor_image(icon_path .. "maximize.png", color.fg)

theme.titlebar_close_button_normal              = gears.color.recolor_image(theme.close, color.bgalt)
theme.titlebar_close_button_focus               = theme.close
theme.titlebar_minimize_button_normal           = gears.color.recolor_image(theme.minimize, color.bgalt)
theme.titlebar_minimize_button_focus            = theme.minimize
theme.titlebar_maximized_button_normal_inactive = gears.color.recolor_image(theme.maximize, color.bgalt)
theme.titlebar_maximized_button_focus_inactive  = theme.maximize
theme.titlebar_maximized_button_normal_active   = gears.color.recolor_image(theme.maximize, color.bgalt)
theme.titlebar_maximized_button_focus_active    = theme.maximize

-- Awesome icon

theme.awesome = require("beautiful.theme_assets").awesome_icon(dpi(40), color.fg, color.bg)

-- Icon theme

theme.icons = color.icons

return theme
