local theme_path = require("gears").filesystem.get_configuration_dir() .. "colors/bloom/"
local icon_path = theme_path .. "icons/"
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

color.bg_alt       = color.white
color.urgent 	   = color.red
color.font   	   = "RobotoMono Bold 11"
color.font_alt	   = "RobotoMono Italic Bold 11"
color.wall	   	   = theme_path .. "bloom.jpg"
color.close 	   = icon_path .. "close.png"
color.maximize 	   = icon_path .. "maximize.png"
color.minimize	   = icon_path .. "minimize.png"
color.floating     = icon_path .. "floating.png"
color.max 		   = icon_path .. "max.png"
color.tile 	       = icon_path .. "tile.png"
color.submenu	   = icon_path .. "submenu.png"

return color
