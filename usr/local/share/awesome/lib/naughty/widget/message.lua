----------------------------------------------------------------------------
--- A notification content message widget.
--
-- This widget is a specialized `wibox.widget.textbox` with the following extra
-- features:
--
-- * Honor the `beautiful` notification variables.
-- * React to the `naughty.notification` object message changes.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_nwidget_message_simple.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
--     local notif = naughty.notification {
--         title   = &#34A notification&#34,
--         message = &#34This notification no actions!&#34,
--         icon    = beautiful.awesome_icon,
--     }
--  
--     wibox.widget {
--         notification = notif,
--         widget       = naughty.widget.message,
--     }
--
-- @author Emmanuel Lepage Vallee &lt;elv1313@gmail.com&gt;
-- @copyright 2017 Emmanuel Lepage Vallee
-- @widgetmod naughty.widget.message
-- @supermodule wibox.widget.textbox
-- @see wibox.widget.textbox
----------------------------------------------------------------------------
local textbox = require("wibox.widget.textbox")
local gtable  = require("gears.table")
local beautiful = require("beautiful")
local markup  = require("naughty.widget._markup").set_markup

local message = {}

--- The attached notification.
-- @property notification
-- @tparam naughty.notification notification
-- @propertydefault This is usually set in the construtor.
-- @propemits true false

function message:set_notification(notif)
    local old = self._private.notification[1]

    if old == notif then return end

    if old then
        old:disconnect_signal("property::message",
            self._private.message_changed_callback)
        old:disconnect_signal("property::fg",
            self._private.message_changed_callback)
    end

    markup(self, notif.message, notif.fg, notif.font)

    self._private.notification = setmetatable({notif}, {__mode="v"})

    notif:connect_signal("property::message", self._private.message_changed_callback)
    notif:connect_signal("property::fg"     , self._private.message_changed_callback)
    self:emit_signal("property::notification", notif)
end

--- Create a new naughty.widget.message.
-- @tparam table args
-- @tparam naughty.notification args.notification The notification.
-- @constructorfct naughty.widget.message
-- @usebeautiful beautiful.notification_fg
-- @usebeautiful beautiful.notification_font

local function new(args)
    args = args or {}
    local tb = textbox()
    tb:set_wrap("word")
    tb:set_font(beautiful.notification_font)
    tb._private.notification = {}

    gtable.crush(tb, message, true)

    function tb._private.message_changed_callback()
        local n = tb._private.notification[1]

        if n then
            markup(
                tb,
                n.message,
                n.fg,
                n.font
            )
        else
            markup(tb, nil, nil)
        end
    end

    if args.notification then
        tb:set_notification(args.notification)
    end

    return tb
end

--
--- Disconnect from a signal.
-- @tparam string name The name of the signal.
-- @tparam function func The callback that should be disconnected.
-- @method disconnect_signal
-- @treturn boolean `true` when the function was disconnected or `false` if it
--  wasn't found.
-- @baseclass gears.object

--- Emit a signal.
--
-- @tparam string name The name of the signal.
-- @param ... Extra arguments for the callback functions. Each connected
--   function receives the object as first argument and then any extra
--   arguments that are given to emit_signal().
-- @method emit_signal
-- @noreturn
-- @baseclass gears.object

--- Connect to a signal.
-- @tparam string name The name of the signal.
-- @tparam function func The callback to call when the signal is emitted.
-- @method connect_signal
-- @noreturn
-- @baseclass gears.object

--- Connect to a signal weakly.
--
-- This allows the callback function to be garbage collected and
-- automatically disconnects the signal when that happens.
--
-- **Warning:**
-- Only use this function if you really, really, really know what you
-- are doing.
-- @tparam string name The name of the signal.
-- @tparam function func The callback to call when the signal is emitted.
-- @method weak_connect_signal
-- @noreturn
-- @baseclass gears.object

return setmetatable(message, {__call = function(_, ...) return new(...) end})
