----------------------------------------------------------------------------
--- A notification background widget.
--
-- This widget holds the boilerplate code associated with the notification
-- background. This includes the color and potentially some other styling
-- elements such as the shape and border.
--
-- * Honor the `beautiful` notification variables.
-- * React to the `naughty.notification` changes.
--
--
--
-- Note that this widget is based on the `wibox.container.background`. This is
-- an implementation detail and may change in the future without prior notice.
--
-- @author Emmanuel Lepage Vallee &lt;elv1313@gmail.com&gt;
-- @copyright 2019 Emmanuel Lepage Vallee
-- @containermod naughty.widget.background
-- @supermodule wibox.container.background
-- @see wibox.container.background
----------------------------------------------------------------------------
local wbg       = require("wibox.container.background")
local gtable    = require("gears.table")
local beautiful = require("beautiful")
local gshape    = require("gears.shape")

local background = {}

local function update_background(notif, wdg)
    local bg    = notif.bg           or beautiful.notification_bg
    local bw    = notif.border_width or beautiful.notification_border_width
    local bc    = notif.border_color or beautiful.notification_border_color

    -- Always fallback to the rectangle to make sure the border works
    local shape = notif.shape or
        beautiful.notification_shape or gshape.rectangle

    wdg:set_bg(bg)
    wdg:set_shape(shape) -- otherwise there's no borders
    wdg:set_border_width(bw)
    wdg:set_border_color(bc)
end

--- The attached notification.
-- @property notification
-- @tparam naughty.notification notification
-- @propertydefault This is usually set in the construtor.
-- @propemits true false

function background:set_notification(notif)
    local old = self._private.notification[1]

    if old == notif then return end

    if old then
        old:disconnect_signal("property::bg",
            self._private.background_changed_callback)
        old:disconnect_signal("property::border_width",
            self._private.background_changed_callback)
        old:disconnect_signal("property::border_color",
            self._private.background_changed_callback)
        old:disconnect_signal("property::shape",
            self._private.background_changed_callback)
    end

    update_background(notif, self)

    self._private.notification = setmetatable({notif}, {__mode="v"})

    notif:connect_signal("property::bg"          , self._private.background_changed_callback)
    notif:connect_signal("property::border_width", self._private.background_changed_callback)
    notif:connect_signal("property::border_color", self._private.background_changed_callback)
    notif:connect_signal("property::shape"       , self._private.background_changed_callback)
    self:emit_signal("property::notification", notif)
end

--- Create a new naughty.container.background.
-- @tparam table args
-- @tparam naughty.notification args.notification The notification.
-- @constructorfct naughty.container.background
-- @usebeautiful beautiful.notification_border_width Fallback when the `border_width` property isn't set.
-- @usebeautiful beautiful.notification_border_color Fallback when the `border_color` property isn't set.
-- @usebeautiful beautiful.notification_shape Fallback when the `shape` property isn't set.

local function new(args)
    args = args or {}

    local bg = wbg()
    bg._private.notification = {}
    bg:set_border_strategy("inner")

    gtable.crush(bg, background, true)

    function bg._private.background_changed_callback()
        update_background(bg._private.notification[1], bg)
    end

    if args.notification then
        bg:set_notification(args.notification)
    end

    return bg
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

return setmetatable(background, {__call = function(_, ...) return new(...) end})
