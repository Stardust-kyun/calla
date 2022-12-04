local theme_path = require("gears").filesystem.get_configuration_dir() .. "colors/cabin/"
local icon_path = theme_path .. "icons/"
local color = {}

color.bg      	   = "#201e1a"
color.fg 	   	   = "#79695a"
color.black		   = "#443a36"
color.white		   = "#867564"
color.red		   = "#674441"
color.green		   = "#5d6051"
color.yellow	   = "#84694e"
color.blue		   = "#545e5e"
color.magenta	   = "#614c4c"
color.cyan		   = "#4d5c5c"

color.bg_alt       = color.black
color.urgent 	   = color.red
color.font   	   = "RobotoMono Bold 11"
color.font_alt	   = "RobotoMono Italic Bold 11"
color.wall	   	   = theme_path .. "Cabin.png"
color.close 	   = icon_path .. "close.png"
color.maximize 	   = icon_path .. "maximize.png"
color.minimize	   = icon_path .. "minimize.png"
color.floating     = icon_path .. "floating.png"
color.max 		   = icon_path .. "max.png"
color.tile 	       = icon_path .. "tile.png"
color.submenu	   = icon_path .. "submenu.png"

return color
