---------------------------------------------------------------------------
--- Display the time (and date) in a text box.
--
-- The `wibox.widget.textclock` widget is part of the Awesome WM's widget
-- system (see @{03-declarative-layout.md}).
--
-- This widget displays a text clock formatted by the
-- [GLib Date Time format](https://developer.gnome.org/glib/stable/glib-GDateTime.html#g-date-time-format)
-- and [GTimeZone](https://developer.gnome.org/glib/stable/glib-GTimeZone.html#g-time-zone-new).
--
-- The `wibox.widget.textclock` inherits from `wibox.widget.textbox`. It means
-- that, once created, the user will receive a derivated instance of
-- `wibox.widget.textbox` associated with a private `gears.timer` to manage
-- timed updates of the displayed clock.
--
-- Use a `wibox.widget.textclock`
-- ---
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_widget_defaults_textclock.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local my_textclock = wibox.widget.textclock('%a %b %d, %H:%M')
--
-- Alternatively, you can declare the `textclock` widget using the
-- declarative pattern (Both codes are strictly equivalent):
--
-- 
--
--
-- 
--     local my_textclock = wibox.widget {
--         format = '%a %b %d, %H:%M',
--         widget = wibox.widget.textclock
--     }
--
-- The GLib DateTime format
-- ---
--
-- The time displayed by the textclock widget can be formated by the GLib
-- DateTime format.
--
-- Here is a short list with commonly used format specifiers (extracted from
-- the Glib API references):
--
----<table class='widget_list' border=1>
-- <tr>
--   <th align='center'>Format</th>
--   <th align='center'>Description</th>
-- </tr>
--   <tr><td>%a</td><td>The abbreviated weekday name according to the current locale</td></tr>
--   <tr><td>%A</td><td>the full weekday name according to the current locale</td></tr>
--   <tr><td>%b</td><td>The abbreviated month name according to the current locale</td></tr>
--   <tr><td>%B</td><td>The full month name according to the current locale</td></tr>
--   <tr><td>%d</td><td>The day of the month as a decimal number (range 01 to 31)</td></tr>
--   <tr><td>%e</td><td>The day of the month as a decimal number (range 1 to 31)</td></tr>
--   <tr><td>%F</td><td>Equivalent to %Y-%m-%d (the ISO 8601 date format)</td></tr>
--   <tr><td>%H</td><td>The hour as a decimal number using a 24-hour clock (range 00 to 23)</td></tr>
--   <tr><td>%I</td><td>The hour as a decimal number using a 12-hour clock (range 01 to 12)</td></tr>
--   <tr><td>%k</td><td>The hour (24-hour clock) as a decimal number (range 0 to 23); single digits are preceded by a blank</td></tr>
--   <tr><td>%l</td><td>The hour (12-hour clock) as a decimal number (range 1 to 12); single digits are preceded by a blank</td></tr>
--   <tr><td>%m</td><td>The month as a decimal number (range 01 to 12)</td></tr>
--   <tr><td>%M</td><td>The minute as a decimal number (range 00 to 59)</td></tr>
--   <tr><td>%p</td><td>Either \"AM\" or \"PM\" according to the given time value, or the corresponding strings for the current locale. Noon is treated as \"PM\" and midnight as \"AM\".</td></tr>
--   <tr><td>%P</td><td>Like %p but lowercase: \"am\" or \"pm\" or a corresponding string for the current locale</td></tr>
--   <tr><td>%r</td><td>The time in a.m. or p.m. notation</td></tr>
--   <tr><td>%R</td><td>The time in 24-hour notation (%H:%M)</td></tr>
--   <tr><td>%S</td><td>The second as a decimal number (range 00 to 60)</td></tr>
--   <tr><td>%T</td><td>The time in 24-hour notation with seconds (%H:%M:%S)</td></tr>
--   <tr><td>%y</td><td>The year as a decimal number without the century</td></tr>
--   <tr><td>%Y</td><td>The year as a decimal number including the century</td></tr>
--   <tr><td>%%</td><td>A literal % character</td></tr>
-- </table>
--
-- You can read more on the GLib DateTime format in the
-- [GLib documentation](https://developer.gnome.org/glib/stable/glib-GDateTime.html#g-date-time-format).
--
-- @author Julien Danjou &lt;julien@danjou.info&gt;
-- @copyright 2009 Julien Danjou
-- @widgetmod wibox.widget.textclock
-- @supermodule wibox.widget.textbox
---------------------------------------------------------------------------

local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local timer = require("gears.timer")
local gtable = require("gears.table")
local glib = require("lgi").GLib
local DateTime = glib.DateTime
local TimeZone = glib.TimeZone

local textclock = { mt = {} }

local DateTime_new_now = DateTime.new_now

-- When $SOURCE_DATE_EPOCH and $SOURCE_DIRECTORY are both set, then this code is
-- most likely being run by the test runner. Ensure reproducible dates.
local source_date_epoch = tonumber(os.getenv("SOURCE_DATE_EPOCH"))
if source_date_epoch and os.getenv("SOURCE_DIRECTORY") then
    DateTime_new_now = function()
        return DateTime.new_from_unix_utc(source_date_epoch)
    end
end

--- Set the clock's format.
--
-- For information about the format specifiers, see
-- [the GLib docs](https://developer.gnome.org/glib/stable/glib-GDateTime.html#g-date-time-format).
-- @property format
-- @tparam[opt=" %a %b %d %H:%M"] string format The new time format. This can contain pango markup.

function textclock:set_format(format)
    self._private.format = format
    self:force_update()
end

function textclock:get_format()
    return self._private.format
end

--- Set the clock's timezone.
--
-- e.g. "Z" for UTC, "±hh:mm" or "Europe/Amsterdam". See
-- [GTimeZone](https://developer.gnome.org/glib/stable/glib-GTimeZone.html#g-time-zone-new).
-- @property timezone
-- @tparam[opt=TimeZone.new()] string timezone

function textclock:set_timezone(tzid)
    self._private.tzid = tzid
    self._private.timezone = tzid and TimeZone.new(tzid)
    self:force_update()
end

function textclock:get_timezone()
    return self._private.tzid
end

--- Set the clock's refresh rate.
--
-- @property refresh
-- @tparam[opt=60] number refresh How often the clock is updated, in seconds
-- @propertyunit second
-- @negativeallowed false

function textclock:set_refresh(refresh)
    self._private.refresh = refresh or self._private.refresh
    self:force_update()
end

function textclock:get_refresh()
    return self._private.refresh
end

--- Force a textclock to update now.
--
-- @noreturn
-- @method force_update
function textclock:force_update()
    self._timer:emit_signal("timeout")
end

--- This lowers the timeout so that it occurs "correctly". For example, a timeout
-- of 60 is rounded so that it occurs the next time the clock reads ":00 seconds".
local function calc_timeout(real_timeout)
    return real_timeout - os.time() % real_timeout
end

--- Create a textclock widget. It draws the time it is in a textbox.
--
-- @tparam[opt=" %a %b %d&comma; %H:%M "] string format The time [format](#format).
-- @tparam[opt=60] number refresh How often to update the time (in seconds).
-- @tparam[opt=local timezone] string timezone The [timezone](#timezone) to use.
-- @treturn table A textbox widget.
-- @constructorfct wibox.widget.textclock
local function new(format, refresh, tzid)
    local w = textbox()
    gtable.crush(w, textclock, true)

    w._private.format = format or " %a %b %d, %H:%M "
    w._private.refresh = refresh or 60
    w._private.tzid = tzid
    w._private.timezone = tzid and TimeZone.new(tzid)

    function w._private.textclock_update_cb()
        local str = DateTime_new_now(w._private.timezone or TimeZone.new_local()):format(w._private.format)
        if str == nil then
            require("gears.debug").print_warning("textclock: "
                    .. "g_date_time_format() failed for format "
                    .. "'" .. w._private.format .. "'")
        end
        w:set_markup(str)
        w._timer.timeout = calc_timeout(w._private.refresh)
        w._timer:again()
        return true -- Continue the timer
    end

    w._timer = timer.weak_start_new(refresh, w._private.textclock_update_cb)
    w:force_update()
    return w
end

function textclock.mt:__call(...)
    return new(...)
end

return setmetatable(textclock, textclock.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
