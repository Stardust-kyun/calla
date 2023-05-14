local theme_path = require("gears").filesystem.get_configuration_dir() .. "color/everforest-light/"

local color = {}

color.bg      	   = "#eae3ca"
color.fg 	   	   = "#5c6a72"
color.black		   = "#eaead3"
color.white		   = "#f3ead3"
color.red		   = "#f86662"
color.green		   = "#8da101"
color.yellow	   = "#dfa000"
color.blue		   = "#3a94c5"
color.magenta	   = "#df69ba"
color.cyan		   = "#35a77c"

color.bgalt	   	   = color.black
color.urgent 	   = color.red
color.wall	   	   = theme_path .. "everforest-light.png"

return color
