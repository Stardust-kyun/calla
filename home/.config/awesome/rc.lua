-- To Do:
-- Panel redesign
-- Widget placement userconf
-- Theme reloading
-- Multihead support
-- Refactoring, always

-- Errors

require("naughty").connect_signal("request::display_error", function(message, startup)
    require("naughty").notification {
        urgency = "critical",
        title   = "Error"..(startup and " during startup!" or "!"),
        message = message
    }
end)

-- Config

require("awful.autofocus")
require("user")
require("signal")
require("config")
require("theme")

-- Autostart

require("awful").spawn.with_shell("~/.config/awesome/autostart")
