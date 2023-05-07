local theme_path = require("gears").filesystem.get_configuration_dir() .. "color/wave/"
local color = {}

color.bg      	   = "#f0fafa"
color.fg 	   	   = "#262626"
color.black		   = "#404040"
color.white		   = "#dce6e6"
color.red		   = "#e68383"
color.green		   = "#a0e6af"
color.yellow	   = "#ffcd96"
color.blue		   = "#83b4e6"
color.magenta	   = "#e1aae1"
color.cyan		   = "#8cd7d2"

color.bgalt        = color.white
color.urgent 	   = color.red
color.wall	   	   = theme_path .. "wave.png"
color.icons		   = "wave"

return color
