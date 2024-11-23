----------------------------------------------------------------------------
--- Manage a notification action list.
--
-- A notification action is a "button" that will trigger an action on the sender
-- process. `notify-send` doesn't support actions, but `libnotify` based
-- applications do.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_nwidget_actionlist_simple.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local notif = naughty.notification {
--         title   = &#34A notification&#34,
--         message = &#34This notification has actions!&#34,
--         actions = {
--             naughty.action {
--                 name = &#34Accept&#34,
--             },
--             naughty.action {
--                 name = &#34Refuse&#34,
--             },
--             naughty.action {
--                 name = &#34Ignore&#34,
--             },
--         }
--     }
--  
--     wibox.widget {
--         notification = notif,
--         widget = naughty.list.actions,
--     }
--
-- This example has a custom vertical widget template:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_nwidget_actionlist_fancy.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--  
--     wibox.widget {
--         notification = notif,
--         base_layout = wibox.widget {
--             spacing        = 3,
--             spacing_widget = wibox.widget {
--                 orientation = &#34horizontal&#34,
--                 widget      = wibox.widget.separator,
--             },
--             layout         = wibox.layout.fixed.vertical
--         },
--         widget_template = {
--             {
--                 {
--                     {
--                         id     = &#34text_role&#34,
--                         widget = wibox.widget.textbox
--                     },
--                     widget = wibox.container.place
--                 },
--                 shape              = gears.shape.rounded_rect,
--                 shape_border_width = 2,
--                 shape_border_color = beautiful.bg_normal,
--                 forced_height      = 30,
--                 widget             = wibox.container.background,
--             },
--             margins = 4,
--             widget  = wibox.container.margin,
--         },
--         widget = naughty.list.actions,
--     }
--
-- This example has a horizontal widget template and icons:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_nwidget_actionlist_fancy_icons.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--  
--     wibox.widget {
--         notification = notif,
--         base_layout = wibox.widget {
--             spacing        = 3,
--             spacing_widget = wibox.widget {
--                 orientation = &#34vertical&#34,
--                 widget      = wibox.widget.separator,
--             },
--             layout         = wibox.layout.flex.horizontal
--         },
--         widget_template = {
--             {
--                 {
--                     {
--                         id            = &#34icon_role&#34,
--                         forced_height = 16,
--                         forced_width  = 16,
--                         widget        = wibox.widget.imagebox
--                     },
--                     {
--                         id     = &#34text_role&#34,
--                         widget = wibox.widget.textbox
--                     },
--                     spacing = 5,
--                     layout = wibox.layout.fixed.horizontal
--                 },
--                 id = &#34background_role&#34,
--                 widget             = wibox.container.background,
--             },
--             margins = 4,
--             widget  = wibox.container.margin,
--         },
--         widget = naughty.list.actions,
--     }
--
-- This example uses the theme/style variables instead of the template. This is
-- less flexible, but easier to put in the theme file. Note that each style
-- variable has a `beautiful` equivalent.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_nwidget_actionlist_style.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--  
--     wibox.widget {
--         notification = notif,
--         base_layout = wibox.widget {
--             spacing        = 3,
--             spacing_widget = wibox.widget {
--                 orientation = &#34vertical&#34,
--                 widget      = wibox.widget.separator,
--             },
--             layout         = wibox.layout.flex.horizontal
--         },
--         style = {
--             underline_normal             = false,
--             underline_selected           = true,
--             shape_normal                 = gears.shape.octogon,
--             shape_selected               = gears.shape.hexagon,
--             shape_border_width_normal    = 2,
--             shape_border_width_selected  = 4,
--             icon_size_normal             = 16,
--             icon_size_selected           = 24,
--             shape_border_color_normal    = &#34#0000ff&#34,
--             shape_border_color_selected  = &#34#ff0000&#34,
--             bg_normal                    = &#34#ffff00&#34,
--             bg_selected                  = &#34#00ff00&#34,
--         },
--         forced_height = beautiful.get_font_height(beautiful.font) * 2.5,
--         widget = naughty.list.actions,
--     }
--
-- @author Emmanuel Lepage Vallee &lt;elv1313@gmail.com&gt;
-- @copyright 2017 Emmanuel Lepage Vallee
-- @widgetmod naughty.list.actions
-- @supermodule wibox.widget.base
-- @see awful.widget.common
----------------------------------------------------------------------------

local wibox    = require("wibox")
local awcommon = require("awful.widget.common")
local abutton  = require("awful.button")
local gtable   = require("gears.table")
local beautiful= require("beautiful")

local module = {}

--- Whether or not to underline the action name.
-- @beautiful beautiful.notification_action_underline_normal
-- @param[opt=true] boolean

--- Whether or not to underline the selected action name.
-- @beautiful beautiful.notification_action_underline_selected
-- @param[opt=true] boolean

--- Whether or not the action label should be shown.
-- @beautiful beautiful.notification_action_icon_only
-- @param[opt=false] boolean

--- Whether or not the action icon should be shown.
-- @beautiful beautiful.notification_action_label_only
-- @param[opt=false] boolean

--- The shape used for a normal action.
-- @beautiful beautiful.notification_action_shape_normal
-- @tparam[opt=gears.shape.rectangle] gears.shape shape
-- @see gears.shape

--- The shape used for a selected action.
-- @beautiful beautiful.notification_action_shape_selected
-- @tparam[opt=gears.shape.rectangle] gears.shape shape
-- @see gears.shape

--- The shape border color for normal actions.
-- @beautiful beautiful.notification_action_shape_border_color_normal
-- @param color
-- @see gears.color

--- The shape border color for selected actions.
-- @beautiful beautiful.notification_action_shape_border_color_selected
-- @param color
-- @see gears.color

--- The shape border width for normal actions.
-- @beautiful beautiful.notification_action_shape_border_width_normal
-- @param[opt=0] number

--- The shape border width for selected actions.
-- @beautiful beautiful.notification_action_shape_border_width_selected
-- @param[opt=0] number

--- The action icon size.
-- @beautiful beautiful.notification_action_icon_size_normal
-- @param[opt=0] number

--- The selected action icon size.
-- @beautiful beautiful.notification_action_icon_size_selected
-- @param[opt=0] number

--- The background color for normal actions.
-- @beautiful beautiful.notification_action_bg_normal
-- @param color
-- @see gears.color

--- The background color for selected actions.
-- @beautiful beautiful.notification_action_bg_selected
-- @param color
-- @see gears.color

--- The foreground color for normal actions.
-- @beautiful beautiful.notification_action_fg_normal
-- @param color
-- @see gears.color

--- The foreground color for selected actions.
-- @beautiful beautiful.notification_action_fg_selected
-- @param color
-- @see gears.color

--- The background image for normal actions.
-- @beautiful beautiful.notification_action_bgimage_normal
-- @tparam gears.surface|string action_bgimage_normal
-- @see gears.surface

--- The background image for selected actions.
-- @beautiful beautiful.notification_action_bgimage_selected
-- @tparam gears.surface|string action_bgimage_selected
-- @see gears.surface

local props = {"shape_border_color", "bg_image" , "fg",
               "shape_border_width", "underline", "bg",
               "shape",              "icon_size",     }

-- Use a cached loop instead of an large function like the taglist and tasklist
local function update_style(self)
    self._private.style_cache = self._private.style_cache or {}

    for _, state in ipairs {"normal", "selected"} do
        local s = {}

        for _, prop in ipairs(props) do
            if self._private.style[prop.."_"..state] ~= nil then
                s[prop] = self._private.style[prop.."_"..state]
            else
                s[prop] = beautiful["notification_action_"..prop.."_"..state]
            end
        end

        -- Set a fallback for the icon size to prevent them from being gigantic
        s.icon_size = s.icon_size
            or beautiful.get_font_height(beautiful.font) * 1.5

        self._private.style_cache[state] = s
    end
end

local function wb_label(action, self)
    -- Get the name
    local name = action.name

    local style = self._private.style_cache[action.selected and "selected" or "normal"]

    -- Add the underline
    name = style.underline ~= false and
        ("<u>"..name.."</u>") or name

    local icon = beautiful.notification_action_label_only ~= true and action.icon or nil

    if style.fg then
        name = "<span color='" .. style.fg .. "'>" .. name .. "</span>"
    end

    if action.icon_only or beautiful.notification_action_icon_only then
        name = nil
    end

    return name, style.bg, style.bg_image, icon, style
end

local function update(self)
    local n = self._private.notification[1]

    if not self._private.layout or not n then return end

    awcommon.list_update(
        self._private.layout,
        self._private.default_buttons,
        function(o) return wb_label(o, self) end,
        self._private.data,
        n.actions,
        {
            widget_template = self._private.widget_template
        }
    )
end

local actionlist = {}

--- The actionlist parent notification.
-- @property notification
-- @tparam[opt=nil] naughty.notification|nil notification
-- @propemits true false
-- @see naughty.notification

--- The actionlist layout.
-- If no layout is specified, a `wibox.layout.fixed.horizontal` will be created
-- automatically.
-- @property base_layout
-- @tparam[opt=wibox.layout.fixed.horizontal] widget base_layout
-- @propemits true false
-- @see wibox.layout.fixed.horizontal

--- The actionlist parent notification.
-- @property widget_template
-- @tparam[opt=nil] template|nil widget_template
-- @propemits true false

--- A table with values to override each `beautiful.notification_action` values.
-- @property style
-- @tparam[opt={}] table|nil style
-- @tparam boolean|nil style.underline_normal
-- @tparam boolean|nil style.underline_selected
-- @tparam shape|nil style.shape_normal
-- @tparam shape|nil style.shape_selected
-- @tparam gears.color|string|nil style.shape_border_color_normal
-- @tparam gears.color|string|nil style.shape_border_color_selected
-- @tparam number|nil style.shape_border_width_normal
-- @tparam number|nil style.shape_border_width_selected
-- @tparam number|nil style.icon_size
-- @tparam color|string|nil style.bg_normal
-- @tparam color|string|nil style.bg_selected
-- @tparam color|string|nil style.fg_normal
-- @tparam color|string|nil style.fg_selected
-- @tparam surface|string|nil style.bgimage_normal
-- @tparam surface|string|nil style.bgimage_selected
-- @propemits true false
-- @usebeautiful beautiful.font Fallback when the `font` property isn't set.
-- @usebeautiful beautiful.notification_action_underline_normal Fallback.
-- @usebeautiful beautiful.notification_action_underline_selected Fallback.
-- @usebeautiful beautiful.notification_action_icon_only Fallback.
-- @usebeautiful beautiful.notification_action_label_only Fallback.
-- @usebeautiful beautiful.notification_action_shape_normal Fallback.
-- @usebeautiful beautiful.notification_action_shape_selected Fallback.
-- @usebeautiful beautiful.notification_action_shape_border_color_normal Fallback.
-- @usebeautiful beautiful.notification_action_shape_border_color_selected Fallback.
-- @usebeautiful beautiful.notification_action_shape_border_width_normal Fallback.
-- @usebeautiful beautiful.notification_action_shape_border_width_selected Fallback.
-- @usebeautiful beautiful.notification_action_icon_size_normal Fallback.
-- @usebeautiful beautiful.notification_action_icon_size_selected Fallback.
-- @usebeautiful beautiful.notification_action_bg_normal Fallback.
-- @usebeautiful beautiful.notification_action_bg_selected Fallback.
-- @usebeautiful beautiful.notification_action_fg_normal Fallback.
-- @usebeautiful beautiful.notification_action_fg_selected Fallback.
-- @usebeautiful beautiful.notification_action_bgimage_normal Fallback.
-- @usebeautiful beautiful.notification_action_bgimage_selected Fallback.


function actionlist:set_notification(notif)
    self._private.notification = setmetatable({notif}, {__mode="v"})

    if not self._private.layout then
        self._private.layout = wibox.layout.fixed.horizontal()
    end

    update(self)

    self:emit_signal("widget::layout_changed")
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::notification", notif)
end

function actionlist:set_base_layout(layout)
    self._private.layout = layout

    update(self)

    self:emit_signal("widget::layout_changed")
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::base_layout", layout)
end

function actionlist:set_widget_template(widget_template)
    self._private.widget_template = widget_template

    -- Remove the existing instances
    self._private.data = {}

    update(self)

    self:emit_signal("widget::layout_changed")
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::widget_template", widget_template)
end

function actionlist:set_style(style)
    self._private.style = style or {}

    update_style(self)
    update(self)

    self:emit_signal("widget::layout_changed")
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::style", style)
end

function actionlist:get_notification()
    return self._private.notification
end

function actionlist:layout(_, width, height)
    if self._private.layout then
        return { wibox.widget.base.place_widget_at(self._private.layout, 0, 0, width, height) }
    end
end

function actionlist:fit(context, width, height)
    if not self._private.layout then
        return 0, 0
    end

    return wibox.widget.base.fit_widget(self, context, self._private.layout, width, height)
end

--- Create an action list.
--
-- @tparam table args
-- @tparam naughty.notification args.notification The notification.
-- @tparam widget args.base_layout The action layout.
-- @tparam table args.style Override the beautiful values.
-- @tparam boolean args.style.underline_normal
-- @tparam boolean args.style.underline_selected
-- @tparam gears.shape args.style.shape_normal
-- @tparam gears.shape args.style.shape_selected
-- @tparam gears.color|string args.style.shape_border_color_normal
-- @tparam gears.color|string args.style.shape_border_color_selected
-- @tparam number args.style.shape_border_width_normal
-- @tparam number args.style.shape_border_width_selected
-- @tparam number args.style.icon_size
-- @tparam gears.color|string args.style.bg_normal
-- @tparam gears.color|string args.style.bg_selected
-- @tparam gears.color|string args.style.fg_normal
-- @tparam gears.color|string args.style.fg_selected
-- @tparam gears.surface|string args.style.bgimage_normal
-- @tparam gears.surface|string args.style.bgimage_selected
-- @tparam[opt] table widget_template A custom widget to be used for each action.
-- @treturn widget The action widget.
-- @constructorfct naughty.list.actions

local function new(_, args)
    args = args or {}

    local wdg = wibox.widget.base.make_widget(nil, nil, {
        enable_properties = true,
    })

    gtable.crush(wdg, actionlist, true)

    wdg._private.data = {}
    wdg._private.notification = {}

    gtable.crush(wdg, args, false)

    wdg._private.style = wdg._private.style or {}

    update_style(wdg)

    wdg._private.default_buttons = gtable.join(
        abutton({ }, 1, function(a)
            local notif = wdg._private.notification[1]
            a:invoke(notif)
        end)
    )

    return wdg
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

return setmetatable(module, {__call = new})

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
