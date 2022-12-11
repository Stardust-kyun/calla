local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful").xresources.apply_dpi
local color = require("themes.colors")
local gears = require("gears")
local menubar = require("menubar")
local theme_path = require("gears").filesystem.get_configuration_dir() .. "themes/linear/"
local icon_path = theme_path .. "icons/"
local theme = {}

-- Default
theme.font 			= color.font

theme.bg_normal     = color.bg
theme.bg_focus      = color.bg_alt
theme.bg_urgent     = color.urgent
theme.bg_minimize   = color.bg_alt

theme.fg_normal     = color.fg
theme.fg_focus      = color.fg
theme.fg_urgent     = color.urgent
theme.fg_minimize   = color.bg_alt

-- Titlebar
theme.titlebar_bg_normal   = color.bg_alt
theme.titlebar_bg_focus    = color.bg_alt
theme.titlebar_bg_urgent   = color.bg_alt
theme.titlebar_bg_minimize = color.bg_alt

theme.titlebar_fg_normal   = color.bg_alt
theme.titlebar_fg_focus    = color.fg
theme.titlebar_fg_urgent   = color.urgent
theme.titlebar_fg_minimize = color.bg_alt

-- Tasklist
theme.tasklist_bg_normal   = color.bg
theme.tasklist_bg_focus    = color.bg
theme.tasklist_bg_urgent   = color.bg
theme.tasklist_bg_minimize = color.bg

theme.tasklist_fg_normal   = color.fg .. "25"
theme.tasklist_fg_focus    = color.fg
theme.tasklist_fg_urgent   = color.urgent
theme.tasklist_fg_minimize = color.fg .. "25"

theme.tasklist_font_minimized  = color.font_alt
theme.tasklist_plain_task_name = true

-- Taglist
theme.taglist_bg_normal   = color.bg
theme.taglist_bg_focus    = color.bg
theme.taglist_bg_urgent   = color.bg
theme.taglist_bg_minimize = color.bg
theme.taglist_bg_empty 	  = color.bg
theme.taglist_bg_occupied = color.bg

theme.taglist_fg_normal   = color.bg_alt
theme.taglist_fg_focus    = color.fg
theme.taglist_fg_urgent   = color.urgent
theme.taglist_fg_minimize = color.fg
theme.taglist_fg_empty	  = color.fg .. "25"
theme.taglist_fg_occupied = color.fg .. "75"

theme.taglist_spacing = dpi(10)

-- Menu
theme.menu_submenu_icon = gears.color.recolor_image(icon_path .. "submenu.png", color.fg)
theme.menu_font 		= color.font
theme.menu_bg_normal 	= color.bg
theme.menu_bg_focus 	= color.bg_alt
theme.menu_fg_normal	= color.fg
theme.menu_fg_focus 	= color.fg
theme.menu_height		= dpi(38)
theme.menu_width 		= dpi(150)

-- Misc
theme.useless_gap           = dpi(10)
theme.border_width          = dpi(0)
theme.bg_systray    	    = color.bg
theme.systray_icon_spacing  = dpi(18)
theme.systray_max_rows		= 3

-- Notification spacing
theme.notification_spacing = dpi(10)

-- Disable tooltips
theme.tooltip_opacity = 0

-- Wallpaper
theme.wallpaper = color.wall

-- Layout icons
theme.layout_floating  = gears.color.recolor_image(icon_path .. "floating.png", color.fg)
theme.layout_max	   = gears.color.recolor_image(icon_path .. "max.png", color.fg)
theme.layout_tile	   = gears.color.recolor_image(icon_path .. "tile.png", color.fg)

-- Titlebar icons
theme.close    = gears.color.recolor_image(icon_path .. "close.png", color.fg)
theme.minimize = gears.color.recolor_image(icon_path .. "minimize.png", color.fg)
theme.maximize = gears.color.recolor_image(icon_path .. "maximize.png", color.fg)

-- Systray icon
theme.systray = gears.color.recolor_image(icon_path .. "systray.png", color.fg)

-- Awesome icon
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, color.fg, color.bg
)

-- Icon theme
theme.icon_theme = nil

return theme
