local theme_path = require("gears").filesystem.get_configuration_dir() .. "colors/noel/"
local icon_path = theme_path .. "icons/"
local color = {}

color.bg      	   = "#403B47"
color.fg 	   	   = "#E8D4CF"
color.black		   = "#5C5566"
color.white		   = "#E8D4CF"
color.red		   = "#CE9C97"
color.green		   = "#B6A4A0"
color.yellow	   = "#D1AD8D"
color.blue		   = "#B9B9C4"
color.magenta	   = "#B68F95"
color.cyan		   = "#675D72"

color.bg_alt       = color.black
color.urgent 	   = color.red
color.font   	   = "RobotoMono Bold 11"
color.font_alt	   = "RobotoMono Italic Bold 11"
color.wall	   	   = theme_path .. "Noel.png"
color.close 	   = icon_path .. "close.png"
color.maximize 	   = icon_path .. "maximize.png"
color.minimize	   = icon_path .. "minimize.png"
color.floating     = icon_path .. "floating.png"
color.max 		   = icon_path .. "max.png"
color.tile 	       = icon_path .. "tile.png"
color.submenu	   = icon_path .. "submenu.png"

return color
