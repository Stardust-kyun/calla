local theme_path = require("gears").filesystem.get_configuration_dir() .. "color/bloom/"
local color = {}

color.bg      	   = "#fffaf5"
color.fg 	   	   = "#4b4646"
color.black		   = "#4b4646"
color.white		   = "#ebe6e1"
color.red		   = "#eb8c8c"
color.green		   = "#96e6a5"
color.yellow	   = "#f0cd96"
color.blue		   = "#9bb9f0"
color.magenta	   = "#d7a0e6"
color.cyan		   = "#a0e1d2"

color.bgalt        = color.white
color.urgent 	   = color.red
color.wall	   	   = theme_path .. "bloom.png"
color.icons		   = "bloom"

return color
