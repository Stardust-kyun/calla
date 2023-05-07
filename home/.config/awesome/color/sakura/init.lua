local theme_path = require("gears").filesystem.get_configuration_dir() .. "color/sakura/"

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

color.bgalt	   	   = color.black
color.urgent 	   = color.red
color.wall	   	   = theme_path .. "sakura.png"
color.icons		   = "sakura"

return color
