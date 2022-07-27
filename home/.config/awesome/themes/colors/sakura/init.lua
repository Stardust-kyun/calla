local theme_path = require("gears").filesystem.get_configuration_dir() .. "themes/colors/sakura/"

local color = {}

color.bg      	   = "#000f14"
color.fg 	   	   = "#a0a0b4"
color.black		   = "#0a191e"
color.white		   = "#a0a0b4"
color.red		   = "#824655"
color.green		   = "#468264"
color.yellow	   = "#827d50"
color.blue		   = "#326482"
color.magenta	   = "#645078"
color.cyan		   = "#327d7d"

color.bg_alt	   = color.black
color.urgent 	   = color.red
color.font   	   = "RobotoMono Bold 11"
color.font_alt	   = "RobotoMono Italic Bold 11"
color.wall	   	   = theme_path .. "sakura.jpg"

return color
