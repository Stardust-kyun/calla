local theme_path = require("gears").filesystem.get_configuration_dir() .. "color/shore/"
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

color.bgalt        = color.black
color.wall	   	   = theme_path .. "shore.png"
color.icons		   = "shore"

return color
