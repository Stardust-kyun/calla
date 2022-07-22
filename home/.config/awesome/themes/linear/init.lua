require("beautiful").init(require("gears").filesystem.get_configuration_dir() .. "themes/linear/theme.lua")
require("themes.linear.bar")
require("themes.linear.title")
require("themes.linear.volume")
require("themes.linear.launcher")
require("themes.linear.notif")
require("themes.linear.signals") 
-- requiring signals here prevents awesome from sending errors 
-- due to signals starting before widgets that need them.
