local tym = require("tym")

tym.set_config({
	shell = "/usr/bin/bash",
	cursor_shape = "block",
	cursor_blink_mode = "off",
	font = "Roboto Mono 14",
	padding_horizontal = 25,
	padding_vertical = 25,
})

tym.set_hook('activated', function()
	tym.set_config({
		color_cursor = foreground,
		color_cursor_foreground = background,
	})
end)

tym.set_hook('deactivated', function()
	tym.set_config({
		color_cursor = background,
		color_cursor_foreground = foreground,
	})
end)
