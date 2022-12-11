local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Mouse 
awful.mouse.append_global_mousebindings({
	awful.button({ }, 1, function () rootmenu:hide() end),
    awful.button({ }, 3, function () rootmenu:toggle() end),
})

-- General keys
awful.keyboard.append_global_keybindings({

    awful.key(
		{ modkey, }, "Return", function () awful.spawn.with_shell(terminal) end,
        { description = "open a terminal", group = "awesome" }
	),
	awful.key(
		{ modkey }, "k", function() hotkeys_popup.show_help() end,
		{ description = "show keybindings", group = "awesome" }
	),
	awful.key(
		{ modkey }, "0", function() awesome.emit_signal("widget::power") end,
		{ description = "show power menu", group = "awesome" }
	),
	awful.key(
		{ modkey, "Shift" }, "r", awesome.restart,
		{ description = "reload awesome", group = "awesome" }
	),
    awful.key(
		{ modkey }, "d", function () awful.spawn.with_shell("rofi -show run") end,
        { description = "run prompt", group = "launcher" }
	),
    awful.key(
		{ modkey }, "e", function () awful.spawn.with_shell("~/.config/awesome/bin/kaomoji") end,
        { description = "kaomoji menu", group = "launcher" }
	),
    awful.key(
		{ modkey, "Shift" }, "d", function () awful.spawn.with_shell("~/.config/awesome/themes/colors/scripts/rofi.sh") end,
        { description = "desktop menu", group = "launcher" }
	),
	awful.key(
		{ modkey }, "Delete", function () awful.spawn.with_shell("~/.config/awesome/bin/screenshot full") end,
        { description = "full screen", group = "screenshot" }
	),
	awful.key(
		{ modkey, "Shift" }, "Delete", function () awful.spawn.with_shell("~/.config/awesome/bin/screenshot part") end,
        { description = "part screen", group = "screenshot" }
	),
    awful.key(
		{ }, "XF86AudioRaiseVolume", function () 
			awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ 0")
			awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%")
			awesome.emit_signal("widget::volume")
		end,
        { description = "raise volume", group = "volume" }
	),
    awful.key(
		{ }, "XF86AudioLowerVolume", function () 
			awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ 0")
			awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%")
			awesome.emit_signal("widget::volume")
		end,
        { description = "lower volume", group = "volume" }
	),
    awful.key(
		{ }, "XF86AudioMute", function () 
			awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
			awesome.emit_signal("widget::volume")
		end,
        { description = "mute volume", group = "volume" }
	),
	awful.key(
		{ }, "XF86MonBrightnessUp", function () 
			awful.spawn.with_shell("light -A 5")
			awesome.emit_signal("widget::brightness")
		end,
        { description = "raise brightness", group = "brightness" }
	),
	awful.key(
		{ }, "XF86MonBrightnessDown", function () 
			awful.spawn.with_shell("light -U 5")
			awesome.emit_signal("widget::brightness")
		end,
        { description = "lower brightness", group = "brightness" }
	),
})

awful.keyboard.append_global_keybindings({
    awful.key(
		{ modkey }, "Tab", function () awful.client.focus.byidx(1) end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key(
		{ modkey, "Shift" }, "Tab", function () awful.client.focus.byidx(-1) end,
		{ description = "focus previous by index", group = "client" }
    ),
    awful.key {
        modifiers   = { modkey },
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
        modifiers = { modkey, "Shift" },
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
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
		-- Resize
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key(
			{ modkey }, "f",
            function (c)
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
			{ modkey, "Shift" }, "q", function (c) c:kill() end,
 			{ description = "close", group = "client" }
		),
    })
end)
