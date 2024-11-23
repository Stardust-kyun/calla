---------------------------------------------------------------------------
--- An auto-resized, free floating or modal wibox built around a widget.
--
-- This type of widget box (wibox) is auto closed when being clicked on and is
-- automatically resized to the size of its main widget.
--
-- Note that the widget itself should have a finite size. If something like a
-- `wibox.layout.flex` is used, then the size would be unlimited and an error
-- will be printed. The `wibox.layout.fixed`, `wibox.container.constraint`,
-- `forced_width` and `forced_height` are recommended.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_popup_simple.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     awful.popup {
--         widget = {
--             {
--                 {
--                     text   = &#34foobar&#34,
--                     widget = wibox.widget.textbox
--                 },
--                 {
--                     {
--                         text   = &#34foobar&#34,
--                         widget = wibox.widget.textbox
--                     },
--                     bg     = &#34#ff00ff&#34,
--                     clip   = true,
--                     shape  = gears.shape.rounded_bar,
--                     widget = wibox.widget.background
--                 },
--                 {
--                     value         = 0.5,
--                     forced_height = 30,
--                     forced_width  = 100,
--                     widget        = wibox.widget.progressbar
--                 },
--                 layout = wibox.layout.fixed.vertical,
--             },
--             margins = 10,
--             widget  = wibox.container.margin
--         },
--         border_color = &#34#00ff00&#34,
--         border_width = 5,
--         placement    = awful.placement.top_left,
--         shape        = gears.shape.rounded_rect,
--         visible      = true,
--     }
--
-- Here is an example of how to create an alt-tab like dialog by leveraging
-- the `awful.widget.tasklist`.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_popup_alttab.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     awful.popup {
--         widget = awful.widget.tasklist {
--             screen   = screen[1],
--             filter   = awful.widget.tasklist.filter.allscreen,
--             buttons  = tasklist_buttons,
--             style    = {
--                 shape = gears.shape.rounded_rect,
--             },
--             layout   = {
--                 spacing = 5,
--                 row_count = 2,
--                 layout = wibox.layout.grid.horizontal
--             },
--             widget_template = {
--                 {
--                     {
--                         id     = &#34clienticon&#34,
--                         widget = awful.widget.clienticon,
--                     },
--                     margins = 4,
--                     widget  = wibox.container.margin,
--                 },
--                 id              = &#34background_role&#34,
--                 forced_width    = 48,
--                 forced_height   = 48,
--                 widget          = wibox.container.background,
--                 create_callback = function(self, c, index, objects) --luacheck: no unused
--                     self:get_children_by_id(&#34clienticon&#34)[1].client = c
--                 end,
--             },
--         },
--         border_color = &#34#777777&#34,
--         border_width = 2,
--         ontop        = true,
--         placement    = awful.placement.centered,
--         shape        = gears.shape.rounded_rect
--     }
--
-- @author Emmanuel Lepage Vallee
-- @copyright 2016 Emmanuel Lepage Vallee
-- @popupmod awful.popup
-- @supermodule wibox
---------------------------------------------------------------------------
local wibox     = require( "wibox"           )
local gtable    = require( "gears.table"     )
local placement = require( "awful.placement" )
local xresources= require("beautiful.xresources")
local timer     = require( "gears.timer"     )
local capi      = {mouse = mouse}


local module = {}

local main_widget = {}

-- Get the optimal direction for the wibox
-- This (try to) avoid going offscreen
local function set_position(self)
    -- First, if there is size to be applied, do it
    if self._private.next_width then
        self.width = self._private.next_width
        self._private.next_width = nil
    end

    if self._private.next_height then
        self.height = self._private.next_height
        self._private.next_height = nil
    end

    local pf = self._private.placement

    if pf == false then return end

    if pf then
        pf(self, {bounding_rect = self.screen.geometry})
        return
    end

    local geo = self._private.widget_geo

    if not geo then return end

    local _, pos_name, anchor_name = placement.next_to(self, {
        preferred_positions = self._private.preferred_directions,
        geometry            = geo,
        preferred_anchors   = self._private.preferred_anchors,
        offset              = self._private.offset or { x = 0, y = 0},
    })

    if pos_name ~= self._private.current_position then
        local old = self._private.current_position
        self._private.current_position = pos_name
        self:emit_signal("property::current_position", pos_name, old)
    end

    if anchor_name ~= self._private.current_anchor then
        local old = self._private.current_anchor
        self._private.current_anchor = anchor_name
        self:emit_signal("property::current_anchor", anchor_name, old)
    end
end

-- Set the wibox size taking into consideration the limits
local function apply_size(self, width, height, set_pos)
    local prev_geo = self:geometry()

    width  = math.max(self._private.minimum_width  or 1, math.ceil(width  or 1))
    height = math.max(self._private.minimum_height or 1, math.ceil(height or 1))

    if self._private.maximum_width then
        width = math.min(self._private.maximum_width, width)
    end

    if self._private.maximum_height then
        height = math.min(self._private.maximum_height, height)
    end

    self._private.next_width, self._private.next_height = width, height

    if set_pos or width ~= prev_geo.width or height ~= prev_geo.height then
        set_position(self)
    end
end

-- Layout this widget
function main_widget:layout(context, width, height)
    if self._private.widget then
        local w, h = wibox.widget.base.fit_widget(
            self,
            context,
            self._private.widget,
            self._wb._private.maximum_width  or 9999,
            self._wb._private.maximum_height or 9999
        )
        timer.delayed_call(function()
            apply_size(self._wb, w, h, true)
        end)
        return { wibox.widget.base.place_widget_at(self._private.widget, 0, 0, width, height) }
    end
end

-- Set the widget that is drawn on top of the background
function main_widget:set_widget(widget)
    if widget then
        wibox.widget.base.check_widget(widget)
    end
    self._private.widget = widget
    self:emit_signal("widget::layout_changed")
    self:emit_signal("property::widget")
end

function main_widget:get_widget()
    return self._private.widget
end

function main_widget:get_children_by_id(name)
    return self._wb:get_children_by_id(name)
end

local popup = {}

--- Set the preferred popup position relative to its parent.
--
-- This allows, for example, to have a submenu that goes on the right of the
-- parent menu. If there is no space on the right, it tries on the left and so
-- on.
--
-- The basic use case for this method is to give it a parent wibox:
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_popup_position1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    for _, v in ipairs {&#34left&#34, &#34right&#34, &#34bottom&#34, &#34top&#34} do
--        local p2 = awful.popup {
--            widget = wibox.widget {
--                text   = &#34On the &#34..v,
--                widget = wibox.widget.textbox
--            },
--            border_color        = &#34#777777&#34,
--            border_width        = 2,
--            preferred_positions = v,
--            ontop               = true,
--        }
--        p2:move_next_to(p)
--    end
--
-- As demonstrated by this second example, it is also possible to use a widget
-- as a parent object:
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_popup_position2.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    for _, v in ipairs {&#34left&#34, &#34right&#34} do
--        local p2 = awful.popup {
--            widget = wibox.widget {
--                text = &#34On the &#34..v,
--                forced_height = 100,
--                widget = wibox.widget.textbox
--            },
--            border_color  = &#34#0000ff&#34,
--            preferred_positions = v,
--            border_width  = 2,
--        }
--        p2:move_next_to(textboxinstance, v)
--    end
--
-- @property preferred_positions
-- @tparam table|string preferred_positions
-- @propertydefault `{ "right", "left", "top", "bottom" }`
-- @propertytype string A single position with no fallback. It will be used
--  even if it doesn't fit.
-- @propertytype table A list of possible positions. The first one to fit will be
--  used.
-- @propertyvalue "left"
-- @propertyvalue "right"
-- @propertyvalue "top"
-- @propertyvalue "bottom"
-- @see awful.placement.next_to
-- @see awful.popup.preferred_anchors
-- @propemits true false

function popup:set_preferred_positions(pref_pos)
    self._private.preferred_directions = pref_pos
    set_position(self)
    self:emit_signal("property::preferred_positions", pref_pos)
end

--- Set the preferred popup anchors relative to the parent.
--
-- For details information, see the `awful.placement.next_to` documentation.
--
-- In this example, it is possible to see the effect of having a fallback
-- preferred anchors when the popup would otherwise not fit:
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_popup_anchors.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local p2 = awful.popup {
--         widget = wibox.widget {
--             text   = &#34A popup&#34,
--             forced_height = 100,
--             widget = wibox.widget.textbox
--         },
--         border_color        = &#34#777777&#34,
--         border_width        = 2,
--         preferred_positions = &#34right&#34,
--         preferred_anchors   = {&#34front&#34, &#34back&#34},
--     }
--     local p4 = awful.popup {
--         widget = wibox.widget {
--             text   = &#34A popup2&#34,
--             forced_height = 100,
--             widget = wibox.widget.textbox
--         },
--         border_color        = &#34#777777&#34,
--         border_width        = 2,
--         preferred_positions = &#34right&#34,
--         preferred_anchors   = {&#34front&#34, &#34back&#34},
--     }
--
-- @property preferred_anchors
-- @tparam[opt="back"] table|string preferred_anchors
--  ordered by priority.
-- @propertytype string A single anchor value with no fallback.
-- @propertytype table A list of possible anchor, the first one has the higher
--  priority, but will fallback if it doesn't fit.
-- @propertyvalue "front"
-- @propertyvalue "middle"
-- @propertyvalue "back"
-- @propemits true false
-- @see awful.placement.next_to
-- @see awful.popup.preferred_positions

function popup:set_preferred_anchors(pref_anchors)
    self._private.preferred_anchors = pref_anchors
    set_position(self)
    self:emit_signal("property::preferred_anchors", pref_anchors)
end

--- The current position relative to the parent object.
--
-- If there is a parent object (widget, wibox, wibar, client or the mouse), then
-- this property returns the current position. This is determined using
-- `preferred_positions`. It is usually the preferred position, but when there
-- isn't enough space, it can also be one of the fallback.
--
-- @property current_position
-- @tparam string current_position
-- @propertydefault This depends on where the popup was displayed.
-- @propertyvalue "left"
-- @propertyvalue "right"
-- @propertyvalue "top"
-- @propertyvalue "bottom"
-- @readonly
-- @see awful.popup.preferred_positions

function popup:get_current_position()
    return self._private.current_position
end

--- Get the current anchor relative to the parent object.
--
-- If there is a parent object (widget, wibox, wibar, client or the mouse), then
-- this property returns the current anchor. The anchor is the "side" of the
-- parent object on which the popup is based on. It will "grow" in the
-- opposite direction from the anchor.
--
-- @property current_anchor
-- @tparam string current_anchor
-- @propertydefault This depends on where the popup was displayed.
-- @propertyvalue "front"
-- @propertyvalue "middle"
-- @propertyvalue "back"
-- @readonly
-- @see awful.popup.preferred_anchors

function popup:get_current_anchor()
    return self._private.current_anchor
end

--- Move the wibox to a position relative to `geo`.
-- This will try to avoid overlapping the source wibox and auto-detect the right
-- direction to avoid going off-screen.
--
-- @param[opt=mouse] obj An object such as a wibox, client or a table entry
--  returned by `wibox:find_widgets()`.
-- @see awful.placement.next_to
-- @see awful.popup.preferred_positions
-- @see awful.popup.preferred_anchors
-- @treturn table The new geometry
-- @method move_next_to
function popup:move_next_to(obj)
    if self._private.is_relative == false then return end

    self._private.widget_geo = obj

    obj = obj or capi.mouse

    if obj._apply_size_now then
        obj:_apply_size_now(false)
    end

    self.visible = true

    self:_apply_size_now(true)

    self._private.widget_geo = nil
end

--- Bind the popup to a widget button press.
--
-- @tparam widget widget The widget
-- @tparam[opt=1] number button The button index
-- @method bind_to_widget
-- @noreturn
function popup:bind_to_widget(widget, button)
    if not self._private.button_for_widget then
        self._private.button_for_widget = {}
    end

    self._private.button_for_widget[widget] = button or 1
    widget:connect_signal("button::press", self._private.show_fct)
end

--- Unbind the popup from a widget button.
-- @tparam widget widget
-- @propertytype widget A widget or declarative widget construct.
-- @method unbind_to_widget
-- @noreturn
function popup:unbind_to_widget(widget)
    widget:disconnect_signal("button::press", self._private.show_fct)
end

--- Hide the popup when right clicked.
--
-- @property hide_on_right_click
-- @tparam[opt=false] boolean hide_on_right_click
-- @propemits true false

function popup:set_hide_on_right_click(value)
    self[value and "connect_signal" or "disconnect_signal"](
        self, "button::press", self._private.hide_fct
    )
    self:emit_signal("property::hide_on_right_click", value)
end

--- The popup minimum width.
--
-- @property minimum_width
-- @tparam[opt=1] integer minimum_width
-- @propertyunit pixel
-- @rangestart 1
-- @propemits true false

--- The popup minimum height.
--
-- @property minimum_height
-- @tparam[opt=1] integer minimum_height
-- @propertyunit pixel
-- @rangestart 1
-- @propemits true false

--- The popup maximum width.
--
-- @property maximum_width
-- @tparam[opt=1] integer maximum_width
-- @propertyunit pixel
-- @rangestart 1
-- @propemits true false

--- The popup maximum height.
--
-- @property maximum_height
-- @tparam[opt=1] integer maximum_height
-- @propertyunit pixel
-- @rangestart 1
-- @propemits true false

for _, orientation in ipairs {"_width", "_height"} do
    for _, limit in ipairs {"minimum", "maximum"} do
        local prop = limit..orientation
        popup["set_"..prop] = function(self, value)
            self._private[prop] = value
            self._private.container:emit_signal("widget::layout_changed")
            self:emit_signal("property::"..prop, value)
        end
        popup["get_"..prop] = function(self)
            return self._private[prop]
        end
    end
end

--- The distance between the popup and its parent (if any).
--
-- Here is an example of 5 popups stacked one below the other with an y axis
-- offset (spacing).
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_popup_position3.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    local previous = nil
--    for i=1, 5 do
--        local p2 = awful.popup {
--            widget = wibox.widget {
--                text   = &#34Hello world!  &#34..i..&#34  aaaa.&#34,
--                widget = wibox.widget.textbox
--            },
--            border_color        = beautiful.border_color,
--            preferred_positions = &#34bottom&#34,
--            border_width        = 2,
--            preferred_anchors   = &#34back&#34,
--            placement           = (not previous) and awful.placement.top or nil,
--            offset = {
--                 y = 10,
--            },
--        }
--        p2:move_next_to(previous)
--        previous = p2
--    end
-- @property offset
-- @tparam[opt=0] table|integer offset
-- @tparam[opt=0] integer offset.x The horizontal offset.
-- @tparam[opt=0] integer offset.y The vertical offset.
-- @propertytype integer A value for both `x` and `y` simultaneously.
-- @propertytype table Specify values for `x` and `y` individually.
-- @negativeallowed true
-- @propertyunit pixel
-- @propemits true false

function popup:set_offset(offset)

    if type(offset) == "number" then
        offset = {
            x = offset or 0,
            y = offset or 0,
        }
    end

    local oldoff = self._private.offset or {x=0, y=0}

    if oldoff.x == offset.x and oldoff.y == offset.y then return end

    offset.x, offset.y = offset.x or oldoff.x or 0, offset.y or oldoff.y or 0

    self._private.offset = offset

    self:_apply_size_now(false)

    self:emit_signal("property::offset", offset)
end

--- Set the placement function.
--
-- @property placement
-- @tparam[opt=awful.placement.next_to] placement|string|boolean placement
-- @propertytype boolean Use `false` to disable automatic placement.
-- @propertytype string The name of an `awful.placement` function, like `"next_to"`.
-- @propemits true false
-- @see awful.placement

function popup:set_placement(f)
    if type(f) == "string" then
        f = placement[f]
    end

    self._private.placement = f
    self:_apply_size_now(false)
    self:emit_signal("property::placement")
end

-- For the tests and the race condition when 2 popups are placed next to each
-- other.
function popup:_apply_size_now(skip_set)
    if not self.widget then return end

    local w, h = wibox.widget.base.fit_widget(
        self.widget,
        {dpi= self.screen.dpi or xresources.get_dpi()},
        self.widget,
        self._private.maximum_width  or 9999,
        self._private.maximum_height or 9999
    )

    -- It is important to do it for the obscure reason that calling `w:geometry()`
    -- is actually mutating the state due to quantum determinism thanks to XCB
    -- async nature... It is only true the very first time `w:geometry()` is
    -- called
    self.width  = math.max(1, math.ceil(w or 1))
    self.height = math.max(1, math.ceil(h or 1))

    apply_size(self, w, h, skip_set ~= false)
end

function popup:set_widget(wid)
    self._private.widget = wid
    self._private.container:set_widget(wid)
    self:emit_signal("property::widget", wid)
end

function popup:get_widget()
    return self._private.widget
end

--- Create a new popup build around a passed in widget.
-- @tparam[opt=nil] table args
-- @tparam integer args.border_width Border width.
-- @tparam string args.border_color Border color.
-- @tparam[opt=false] boolean args.ontop On top of other windows.
-- @tparam string args.cursor The mouse cursor.
-- @tparam boolean args.visible Visibility.
-- @tparam[opt=1] number args.opacity The opacity, between 0 and 1.
-- @tparam string args.type The window type (desktop, normal, dock, …).
-- @tparam integer args.x The x coordinates.
-- @tparam integer args.y The y coordinates.
-- @tparam integer args.width The width.
-- @tparam integer args.height The height.
-- @tparam screen args.screen The wibox screen.
-- @tparam wibox.widget args.widget The widget that the wibox displays.
-- @param args.shape_bounding The wibox’s bounding shape as a (native) cairo surface.
-- @param args.shape_clip The wibox’s clip shape as a (native) cairo surface.
-- @param args.shape_input The wibox’s input shape as a (native) cairo surface.
-- @tparam color args.bg The background.
-- @tparam surface args.bgimage The background image of the drawable.
-- @tparam color args.fg The foreground (text) color.
-- @tparam gears.shape args.shape The shape.
-- @tparam[opt=false] boolean args.input_passthrough If the inputs are
--  forward to the element below.
-- @tparam function args.placement The `awful.placement` function
-- @tparam string|table args.preferred_positions
-- @tparam string|table args.preferred_anchors
-- @tparam table|number args.offset The X and Y offset compared to the parent object
-- @tparam boolean args.hide_on_right_click Whether or not to hide the popup on
--  right clicks.
-- @constructorfct awful.popup
local function create_popup(_, args)
    assert(args)

    -- Temporarily remove the widget
    local original_widget = args.widget
    args.widget = nil

    assert(original_widget, "The `awful.popup` requires a `widget` constructor argument")

    local child_widget = wibox.widget.base.make_widget_from_value(original_widget)

    local ii = wibox.widget.base.make_widget(child_widget, "awful.popup", {
        enable_properties = true
    })

    gtable.crush(ii, main_widget, true)

    -- Create a wibox to host the widget
    local w = wibox(args or {})

    rawset(w, "_private", {
        container            = ii,
        preferred_directions = { "right", "left", "top", "bottom" },
        preferred_anchors    = { "back", "front", "middle" },
        widget = child_widget
    })

    gtable.crush(w, popup)

    ii:set_widget(child_widget)

    -- Create the signal handlers
    function w._private.show_fct(wdg, _, _, button, _, geo)
        if button == w._private.button_for_widget[wdg] then
            w:move_next_to(geo)
        end
    end
    function w._private.hide_fct()
        w.visible = false
    end

    -- Restore
    args.widget = original_widget

    -- Cross-link the wibox and widget
    ii._wb = w
    wibox.set_widget(w, ii)

    --WARNING The order is important
    -- First, apply the limits to avoid a flicker with large width or height
    -- when set_position is called before the limits
    for _,v in ipairs{"minimum_width", "minimum_height", "maximum_height",
      "maximum_width", "offset", "placement","preferred_positions",
      "preferred_anchors", "hide_on_right_click"} do
        if args[v] ~= nil then
            w["set_"..v](w, args[v])
        end
    end

    -- Default to visible
    if args.visible ~= false then
        w.visible = true
    end

    return w
end

return setmetatable(module, {__call = create_popup})
