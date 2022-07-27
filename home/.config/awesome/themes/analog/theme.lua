local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful").xresources.apply_dpi
local color = require("colors")
local gears = require("gears")
local theme = {}

-- Default
theme.font 			= color.font

theme.bg_normal     = color.bg_alt
theme.bg_focus      = color.bg_alt
theme.bg_urgent     = color.bg_alt
theme.bg_minimize   = color.bg_alt

theme.fg_normal     = color.fg
theme.fg_focus      = color.fg
theme.fg_urgent     = color.bg_alt
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
theme.tasklist_bg_normal   = color.bg_alt
theme.tasklist_bg_focus    = color.bg
theme.tasklist_bg_urgent   = color.bg_alt
theme.tasklist_bg_minimize = color.bg_alt

theme.tasklist_fg_normal   = color.fg
theme.tasklist_fg_focus    = color.fg
theme.tasklist_fg_urgent   = color.urgent
theme.tasklist_fg_minimize = color.fg

theme.tasklist_font_minimized  = color.font_alt
theme.tasklist_plain_task_name = true

-- Taglist
theme.taglist_bg_normal   = color.bg
theme.taglist_bg_focus    = color.bg
theme.taglist_bg_urgent   = color.bg
theme.taglist_bg_minimize = color.bg

theme.taglist_fg_normal   = color.fg
theme.taglist_fg_focus    = color.fg
theme.taglist_fg_urgent   = color.urgent
theme.taglist_fg_minimize = color.fg

-- Menu
theme.menu_submenu_icon = gears.color.recolor_image(color.submenu, color.fg)
theme.menu_font 		= color.font
theme.menu_bg_normal 	= color.bg
theme.menu_bg_focus 	= color.bg_alt
theme.menu_fg_normal	= color.fg
theme.menu_fg_focus 	= color.fg
theme.menu_height		= dpi(38)
theme.menu_width 		= dpi(150)

-- Misc
theme.useless_gap         = dpi(10)
theme.border_width        = dpi(0)
theme.bg_systray    	  = color.bg

-- Disable tooltips
theme.tooltip_opacity = 0

-- Wallpaper
theme.wallpaper = color.wall

-- Titlebar icons
theme.titlebar_close_button_normal = gears.color.recolor_image(color.close, color.bg_alt)
theme.titlebar_close_button_focus  = gears.color.recolor_image(color.close, color.fg)

theme.titlebar_maximized_button_normal_inactive = gears.color.recolor_image(color.maximize, color.bg_alt)
theme.titlebar_maximized_button_focus_inactive  = gears.color.recolor_image(color.maximize, color.fg)
theme.titlebar_maximized_button_normal_active = gears.color.recolor_image(color.maximize, color.bg_alt)
theme.titlebar_maximized_button_focus_active  = gears.color.recolor_image(color.maximize, color.fg)

theme.titlebar_minimize_button_normal = gears.color.recolor_image(color.minimize, color.bg_alt)
theme.titlebar_minimize_button_focus  = gears.color.recolor_image(color.minimize, color.fg)

-- Layout icons
theme.layout_floating  = gears.color.recolor_image(color.floating, color.fg)
theme.layout_max	   = gears.color.recolor_image(color.max, color.fg)
theme.layout_tile	   = gears.color.recolor_image(color.tile, color.fg)

-- Awesome icon
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, color.fg, color.bg
)

-- Icon theme
theme.icon_theme = nil

return theme
