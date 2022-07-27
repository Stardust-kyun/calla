local theme_path = require("gears").filesystem.get_configuration_dir() .. "themes/colors/shore/"
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

return color
