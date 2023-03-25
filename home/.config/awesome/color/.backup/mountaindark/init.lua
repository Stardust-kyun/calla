local theme_path = require("gears").filesystem.get_configuration_dir() .. "colors/mountaindark/"
local icon_path = theme_path .. "icons/"
local color = {}

color.bg      	   = "#161616"
color.bg_alt       = "#525252"
color.fg 	   	   = "#b9b9b9"
color.urgent 	   = "#7c7c7c"
color.font   	   = "RobotoMono Bold 11"
color.font_alt	   = "RobotoMono Italic Bold 11"
color.wall	   	   = theme_path .. "MountainDark.jpg"
color.close_normal = icon_path .. "close_normal.png"
color.close_focus  = icon_path .. "close_focus.png"
color.floating     = icon_path .. "floating.png"
color.max 		   = icon_path .. "max.png"
color.tile 	       = icon_path .. "tile.png"
color.submenu	   = icon_path .. "submenu.png"

return color
