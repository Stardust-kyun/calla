local awful = require("awful")
local gears = require("gears")
local ruled = require("ruled")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

ruled.client.connect_signal("request::rules", function()

	-- New clients

    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
			placement = awful.placement.no_offscreen
		}
    }

    -- Floating clients

    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Gcolor3", "Blueberry.py", "SimpleScreenRecorder", "Usbimager", "Yad", "Settings"
            },
            name    = {
                "Event Tester",  -- xev
				"ncmpcpp"
            },
        },
        properties = { floating = true }
    }

    -- Titlebars

    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = true }
    }

end)
