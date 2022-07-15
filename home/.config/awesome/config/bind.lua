local awful = require("awful")

-- Mouse 
awful.mouse.append_global_mousebindings({
	awful.button({ }, 1, function () rootmenu:hide() end),
    awful.button({ }, 3, function () rootmenu:toggle() end),
})

-- General keys
awful.keyboard.append_global_keybindings({
    awful.key(
		{ c.modkey, "Shift" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }
	),
    awful.key(
		{ c.modkey, }, "Return", function () awful.spawn(c.terminal) end,
        { description = "open a terminal", group = "launcher" }
	),
    awful.key(
		{ c.modkey }, "d", function () awful.spawn("rofi -show run") end,
        { description = "run prompt", group = "launcher" }
	),
    awful.key(
		{ c.modkey }, "e", function () awful.spawn.with_shell("~/.config/rofi/kaomoji.sh") end,
        { description = "kaomoji menu", group = "launcher" }
	),
    awful.key(
		{ c.modkey, "Shift" }, "d", function () awful.spawn.with_shell("~/.config/awesome/colors/scripts/rofi.sh") end,
        { description = "desktop menu", group = "launcher" }
	),
	awful.key(
		{ c.modkey }, "Delete", function () awful.spawn.with_shell("~/.config/awesome/bin/screenshot full") end,
        { description = "full screen", group = "screenshot" }
	),
	awful.key(
		{ c.modkey, "Shift" }, "Delete", function () awful.spawn.with_shell("~/.config/awesome/bin/screenshot part") end,
        { description = "part screen", group = "screenshot" }
	),
    awful.key(
		{ }, "XF86AudioRaiseVolume", function () 
			awful.spawn.with_shell "pactl set-sink-mute @DEFAULT_SINK@ 0"
			awful.spawn.with_shell "pactl set-sink-volume @DEFAULT_SINK@ +5%"
			awesome.emit_signal("widget::volume")
		end,
        { description = "raise volume", group = "volume" }
	),
    awful.key(
		{ }, "XF86AudioLowerVolume", function () 
			awful.spawn.with_shell "pactl set-sink-mute @DEFAULT_SINK@ 0"
			awful.spawn.with_shell "pactl set-sink-volume @DEFAULT_SINK@ -5%"
			awesome.emit_signal("widget::volume")
		end,
        { description = "lower volume", group = "volume" }
	),
    awful.key(
		{ }, "XF86AudioMute", function () 
			awful.spawn.with_shell "pactl set-sink-mute @DEFAULT_SINK@ toggle"
			awesome.emit_signal("widget::volume")
		end,
        { description = "mute volume", group = "volume" }
	),
})

awful.keyboard.append_global_keybindings({
    awful.key({ c.modkey,           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ c.modkey, "Shift", }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key {
        modifiers   = { c.modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers = { c.modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
					tag:view_only()
                end
            end
        end,
    }
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
		-- Focus
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
		-- Move
        awful.button({ c.modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
		-- Resize
        awful.button({ c.modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key(
			{ c.modkey }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            { description = "toggle fullscreen", group = "client" }
		),
	    awful.key(
			{ c.modkey }, "s", 
			function(c)
				c.floating = not c.floating
				c:raise()
			end,
        	{ description = "toggle floating", group = "client" }
		),
	    awful.key(
			{ c.modkey }, "m", 
			function(c)
				c.maximized = not c.maximized
				c:raise()
			end,
        	{ description = "toggle maximize", group = "client" }
		),
		awful.key(
			{ c.modkey, "Shift" }, "q", function (c) c:kill() end,
 			{ description = "close", group = "client" }
		),
    })
end)
