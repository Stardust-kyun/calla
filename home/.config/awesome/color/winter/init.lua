local theme_path = require("gears").filesystem.get_configuration_dir() .. "color/winter/"

local color = {}

color.bg      	   = "#100e13"
color.fg 	   	   = "#8da4a6"
color.black		   = "#15131a"
color.white		   = "#8da4a6"
color.red		   = "#833c42"
color.green		   = "#437e44"
color.yellow	   = "#99782e"
color.blue		   = "#4d7588"
color.magenta	   = "#6a3c83"
color.cyan		   = "#3c837e"

color.bg_alt	   = color.black
color.urgent 	   = color.red
color.wall	   	   = theme_path .. "winter.png"

return color
