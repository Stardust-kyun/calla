local theme_path = require("gears").filesystem.get_configuration_dir() .. "colors/shore/"
local icon_path = theme_path .. "icons/"
local color = {}

color.bg      	   = "#19191e"
color.fg 	   	   = "#9999a8"
color.black		   = "#2b2b33"
color.white		   = "#9999a8"
color.red		   = "#825a5a"
color.green		   = "#5a825a"
color.yellow	   = "#968264"
color.blue		   = "#505a82"
color.magenta	   = "#735a87"
color.cyan		   = "#5a7387"

color.bg_alt       = color.black
color.urgent 	   = color.red
color.font   	   = "RobotoMono Bold 11"
color.font_alt	   = "RobotoMono Italic Bold 11"
color.wall	   	   = theme_path .. "shore.jpg"
color.close 	   = icon_path .. "close.png"
color.maximize 	   = icon_path .. "maximize.png"
color.minimize	   = icon_path .. "minimize.png"
color.floating     = icon_path .. "floating.png"
color.max 		   = icon_path .. "max.png"
color.tile 	       = icon_path .. "tile.png"
color.submenu	   = icon_path .. "submenu.png"

return color
