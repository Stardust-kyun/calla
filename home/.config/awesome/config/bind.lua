local awful = require("awful")

-- Mouse 
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
		-- Focus
        awful.button({ }, 1, function(c)
            c:activate { context = "mouse_click" }
        end),
		-- Move
        awful.button({ modkey }, 1, function(c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
		-- Resize
        awful.button({ modkey }, 3, function(c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

-- Keys
awful.keyboard.append_global_keybindings({

	-- Awesome
	awful.key(
		{ modkey, "Shift" }, "r", 
			awesome.restart,
		{ description = "reload awesome", group = "awesome" }
	),
	awful.key(
		{ modkey }, "z", function() 
			awful.layout.inc(1) 
		end,
 		{ description = "next layout", group = "awesome" }
	),

	-- Programs
	awful.key(
		{ modkey }, "Return", function() 
			awful.spawn.with_shell(terminal) 
		end,
        { description = "open a terminal", group = "awesome" }
	),
	awful.key(
		{ modkey }, "p", function() 
			awful.spawn.with_shell("killall picom") 
		end,
        { description = "kill picom", group = "awesome" }
	),
	awful.key(
		{ modkey, "Shift" }, "p", function() 
			awful.spawn.with_shell("picom & disown") 
		end,
        { description = "start picom", group = "awesome" }
	),
    awful.key(
		{ modkey }, "d", function() 
			awful.spawn.with_shell("rofi -show run") 
		end,
        { description = "run prompt", group = "launcher" }
	),
    awful.key(
		{ modkey, "Shift" }, "d", function() 
			awful.spawn.with_shell("~/.config/awesome/color/rofi.sh") 
		end,
        { description = "color menu", group = "launcher" }
	),

	-- Screenshot
	awful.key(
		{ modkey }, "Delete", function() 
			awesome.emit_signal("screenshot::full") 
		end,
        { description = "full screen", group = "screenshot" }
	),
	awful.key(
		{ modkey, "Control" }, "Delete", function()
			awesome.emit_signal("screenshot::fullwait")
		end,
        { description = "full screen delay", group = "screenshot" }
	),
	awful.key(
		{ modkey, "Shift" }, "Delete", function() 
			awesome.emit_signal("screenshot::part") 
		end,
        { description = "part screen", group = "screenshot" }
	),

	-- Volume
    awful.key(
		{ }, "XF86AudioRaiseVolume", function() 
			awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ 0")
			awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%")
			awesome.emit_signal("widget::volume")
		end,
        { description = "raise volume", group = "volume" }
	),
    awful.key(
		{ }, "XF86AudioLowerVolume", function() 
			awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ 0")
			awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%")
			awesome.emit_signal("widget::volume")
		end,
        { description = "lower volume", group = "volume" }
	),
    awful.key(
		{ }, "XF86AudioMute", function() 
			awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
			awesome.emit_signal("widget::volume")
		end,
        { description = "mute volume", group = "volume" }
	),

	-- Brightness
	awful.key(
		{ }, "XF86MonBrightnessUp", function() 
			awful.spawn.with_shell("brightnessctl s 5%+")
			awesome.emit_signal("widget::brightness")
		end,
        { description = "raise brightness", group = "brightness" }
	),
	awful.key(
		{ }, "XF86MonBrightnessDown", function() 
			awful.spawn.with_shell("brightnessctl s 5%-")
			awesome.emit_signal("widget::brightness")
		end,
        { description = "lower brightness", group = "brightness" }
	),

	-- Launcher
	awful.key(
		{ modkey }, "space", function() 
			awesome.emit_signal("widget::launcher") 
		end,
		{ description = "show launcher", group = "awesome" }
	),

	-- Management
	awful.key(
		{ modkey }, "c", function() 
			awful.placement.centered(client.focus, { honor_workarea = true }) 
		end,
		{ description = "center window", group = "management" }
	),
    awful.key(
		{ modkey }, "Tab", function() 
			awful.client.focus.byidx(1) 
		end,
        { description = "focus next by index", group = "management" }
    ),
    awful.key(
		{ modkey, "Shift" }, "Tab", function() 
			awful.client.focus.byidx(-1) 
		end,
		{ description = "focus previous by index", group = "management" }
    ),

	-- Tag
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Control" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag and follow",
        group       = "tag",
        on_press    = function(index)
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

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({

		-- Client
        awful.key(
			{ modkey }, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            { description = "toggle fullscreen", group = "client" }
		),
	    awful.key(
			{ modkey }, "s", 
			function(c)
				c.floating = not c.floating
				c:raise()
			end,
        	{ description = "toggle floating", group = "client" }
		),
	    awful.key(
			{ modkey }, "m", 
			function(c)
				c.maximized = not c.maximized
				c:raise()
			end,
        	{ description = "toggle maximize", group = "client" }
		),
		awful.key(
			{ modkey, "Shift" }, "q", function(c) 
				c:kill() 
			end,
 			{ description = "close", group = "client" }
		),
    })
end)
