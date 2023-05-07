local awful = require("awful")
local ruled = require("ruled")

ruled.client.connect_signal("request::rules", function()

	-- New clients

    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
			placement = awful.placement.no_offscreen--+awful.placement.centered
		}
    }

    -- Floating clients

    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Gcolor3", "Blueberry.py", "SimpleScreenRecorder", "Usbimager"
            },
            name    = {
                "Event Tester",  -- xev
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
