local theme_path = require("gears").filesystem.get_configuration_dir() .. "color/everforest-dark/"

local color = {}

color.bg      	   = "#3a464c"
color.fg 	   	   = "#d3c6aa"
color.black		   = "#293136"
color.white		   = "#333c43"
color.red		   = "#e67e80"
color.green		   = "#a7c080"
color.yellow	   = "#dbbc7f"
color.blue		   = "#7fbbb3"
color.magenta	   = "#d699b6"
color.cyan		   = "#83c092"

color.bgalt	   	   = color.black
color.urgent 	   = color.red
color.wall	   	   = theme_path .. "everforest-dark.png"

return color
