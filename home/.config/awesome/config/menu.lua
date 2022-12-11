awesomemenu = {
	{ "Config", editor_cmd .. " " .. require("gears").filesystem.get_configuration_dir() },
	{ "Restart", awesome.restart },
	{ "Power", function() awesome.emit_signal("widget::power") end },
}

screenshotmenu = {
	{ "Full", "sh -c '~/.config/awesome/bin/screenshot full'" },
	{ "Full 5s", "sh -c '~/.config/awesome/bin/screenshot fullwait'" },
	{ "Partial", "sh -c '~/.config/awesome/bin/screenshot part'" }
}

rootmenu = require("awful").menu(
	{ items = { 
		{ "Awesome", awesomemenu },
		{ "Shot", screenshotmenu },
		{ "Terminal", terminal },
		{ "Browser", browser },
		{ "Files", files }
    }
})
