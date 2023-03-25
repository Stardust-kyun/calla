local theme_path = require("gears").filesystem.get_configuration_dir() .. "colors/mountainlight/"
local icon_path = theme_path .. "icons/"
local color = {}

color.bg      	   = "#fefefe"
color.bg_alt       = "#b9b9b9"
color.fg 	   	   = "#464646"
color.urgent 	   = "#7c7c7c"
color.font   	   = "RobotoMono Bold 11"
color.font_alt	   = "RobotoMono Italic Bold 11"
color.wall	   	   = theme_path .. "MountainLight.jpg"
color.close_normal = icon_path .. "close_normal.png"
color.close_focus  = icon_path .. "close_focus.png"
color.floating     = icon_path .. "floating.png"
color.max 		   = icon_path .. "max.png"
color.tile 	       = icon_path .. "tile.png"
color.submenu	   = icon_path .. "submenu.png"

return color
