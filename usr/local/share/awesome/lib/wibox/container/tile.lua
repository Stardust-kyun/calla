---------------------------------------------------------------------------
-- Replicate the content of the widget over and over.
--
-- This contained is intended to be used for wallpapers. It currently doesn't
-- support mouse input in the replicated tiles.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_defaults_tile.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @author Emmanuel Lepage-Vallee
-- @copyright 2021 Emmanuel Lepage-Vallee
-- @containermod wibox.container.tile
-- @supermodule wibox.container.place
local place = require("wibox.container.place")
local cairo = require("lgi").cairo
local widget = require("wibox.widget")
local gtable = require("gears.table")

local module = {mt = {}}

function module:draw(context, cr, width, height)
    if not self._private.tiled then return end
    if not self._private.widget then return end

    local x, y, w, h = self:_layout(context, width, height)

    local vspace, hspace = self.vertical_spacing, self.horizontal_spacing
    local vcrop, hcrop = self.vertical_crop, self.horizontal_crop

    -- In theory we could avoid a few repaints by tracking the child widget
    -- redraw independently from the container redraw. However it is nearly a
    -- 1:1 march, so there's little reasons to do it.
    if not self._private.surface then
        self._private.surface = cairo.ImageSurface(cairo.Format.ARGB32, w+hspace, h+vspace)
        self._private.cr = cairo.Context(self._private.surface)
        self._private.cr:set_source(cr:get_source())
        self._private.pattern = cairo.Pattern.create_for_surface(self._private.surface)
        self._private.pattern.extend = cairo.Extend.REPEAT
        self._private.cr:translate(math.ceil(hspace), math.ceil(vspace))
    else
        self._private.cr:set_operator(cairo.Operator.CLEAR)
        self._private.cr:set_source_rgba(0,0,0,1)
        self._private.cr:paint()
        self._private.cr:set_operator(cairo.Operator.SOURCE)
    end

    widget.draw_to_cairo_context(self._private.widget, self._private.cr, w, h, context)

    cr:save()

    -- We do our own clip.
    cr:reset_clip()

    local x0, y0 = 0, 0

    -- Avoid painting incomplete tiles
    if hcrop and x ~= 0 then
        x0 = x - math.floor(x/(w+hspace))*(w+hspace)
    end

    if hcrop then
        width = x + w + hspace + math.floor((width - (x + w + hspace))/(w+hspace))*(w+hspace)
    end

    if vcrop and y ~= 0 then
        y0 = y - math.floor(y/(h+vspace))*(h+vspace)
    end

    if vcrop then
        height = (y+h+vspace) + math.floor((height - (y+h+vspace))/(h+vspace))*(h+vspace)
    end

    -- Create a clip around the "real" widget in case there is some transparency.
    cr:rectangle(x0, y0, width-x0, y-y0)
    cr:rectangle(x0, y0, x-hspace-x0, height-y0)
    cr:rectangle(x+hspace+w, y0, width - (x+w+hspace), height-y0)
    cr:rectangle(x, y+vspace+h, w+hspace, height - (y+h+vspace))
    cr:clip()

    -- Make sure the tiles are aligned with the child widget.
    cr:translate(x - hspace, y - vspace)


    -- Use OVER rather than SOURCE to preserve the alpha.
    cr.operator = cairo.Operator.OVER
    cr.source = self._private.pattern
    cr:paint()

    cr:restore()
end

--- The horizontal spacing between the tiled.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_tile_horizontal_spacing.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, i in ipairs {0, 2, 5, 10} do
--     local w = wibox.widget {
--         {
--             image         = beautiful.awesome_icon,
--             forced_height = 30,
--             forced_width  = 30,
--             widget        = wibox.widget.imagebox
--         },
--         valign             = &#34top&#34,
--         halign             = &#34left&#34,
--         horizontal_spacing = i,
--         widget             = wibox.container.tile
--     }
-- end
--
-- @property horizontal_spacing
-- @tparam[opt=0] number horizontal_spacing
-- @propemits true false
-- @propertyunit pixel
-- @negativeallowed false
-- @see vertical_spacing

--- The vertical spacing between the tiled.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_tile_vertical_spacing.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, i in ipairs {0, 2, 5, 10} do
--     local w = wibox.widget {
--         {
--             image         = beautiful.awesome_icon,
--             forced_height = 30,
--             forced_width  = 30,
--             widget        = wibox.widget.imagebox
--         },
--         valign             = &#34top&#34,
--         halign             = &#34left&#34,
--         vertical_spacing   = i,
--         widget             = wibox.container.tile
--     }
-- end
--
-- @property vertical_spacing
-- @tparam[opt=0] number vertical_spacing
-- @propertyunit pixel
-- @negativeallowed false
-- @propemits true false
-- @see horizontal_spacing

--- Avoid painting incomplete horizontal tiles.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_tile_horizontal_crop.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, i in ipairs {true, false} do
--     local w = wibox.widget {
--         {
--             {
--                 image         = beautiful.awesome_icon,
--                 forced_height = 30,
--                 forced_width  = 30,
--                 widget        = wibox.widget.imagebox
--             },
--             horizontal_crop = i,
--             widget          = wibox.container.tile
--         },
--         bg     = beautiful.bg_normal,
--         widget = wibox.container.background
--     }
-- end
--
-- @property horizontal_crop
-- @tparam[opt=false] boolean horizontal_crop
-- @see vertical_crop

--- Avoid painting incomplete vertical tiles.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_tile_vertical_crop.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, i in ipairs {true, false} do
--     local w = wibox.widget {
--         {
--             {
--                 image         = beautiful.awesome_icon,
--                 forced_height = 30,
--                 forced_width  = 30,
--                 widget        = wibox.widget.imagebox
--             },
--             vertical_crop  = i,
--             widget         = wibox.container.tile
--         },
--         bg     = beautiful.bg_normal,
--         widget = wibox.container.background
--     }
-- end
--
-- @property vertical_crop
-- @tparam[opt=false] boolean vertical_crop
-- @see horizontal_crop

--- Enable or disable the tiling.
--
-- When set to `false`, this container behaves exactly like
-- `wibox.container.place`.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_tile_tiled.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, i in ipairs {true, false} do
--     local w = wibox.widget {
--         {
--             image         = beautiful.awesome_icon,
--             forced_height = 30,
--             forced_width  = 30,
--             widget        = wibox.widget.imagebox
--         },
--         tiled  = i,
--         widget = wibox.container.tile
--     }
-- end
--
-- @property tiled
-- @tparam[opt=true] boolean tiled

local defaults = {
    horizontal_spacing = 0,
    vertical_spacing   = 0,
    tiled              = true,
    horizontal_crop    = false,
    vertical_crop      = false,
}

for prop in pairs(defaults) do

    module["set_"..prop] = function(self, value)
        self._private[prop] = value
        self:emit_signal("widget::redraw_needed", value)
    end

    module["get_"..prop] = function(self)
        if self._private[prop] == nil then
            return defaults[prop]
        end

        return self._private[prop]
    end
end

local function new(_, args)
    args = args or {}
    local ret = place(args.widget, args.halign, args.valign)
    gtable.crush(ret, module, true)
    ret._private.tiled = true

    local function redraw()
        ret:emit_signal("widget::redraw_needed")
    end

    -- Resize the pattern as needed.
    local function reset()
        if ret._private.surface then
            ret._private.surface:finish()
        end

        ret._private.cr = nil
        ret._private.surface = nil
        ret._private.pattern = nil
    end

    local w = nil

    ret:connect_signal("property::widget", function()
        reset()

        if w then
            w:disconnect_signal("widget::redraw_needed", redraw)
            w:disconnect_signal("widget::layout_changed", reset)
        end

        w = ret._private.widget

        if w then
            w:connect_signal("widget::redraw_needed", redraw)
            w:connect_signal("widget::layout_changed", reset)
        end
    end)

    return ret
end

--- Create a new tile container.
-- @tparam table args
-- @tparam wibox.widget args.widget args.widget The widget to tile.
-- @tparam string args.halign Either `left`, `right` or `center`.
-- @tparam string args.valign Either `top`, `bottom` or `center`.
-- @tparam number args.horizontal_spacing The horizontal spacing between the tiled.
-- @tparam number args.vertical_spacing The vertical spacing between the tiled.
-- @tparam boolean args.horizontal_crop Avoid painting incomplete horizontal tiles.
-- @tparam boolean args.vertical_crop Avoid painting incomplete vertical tiles.
-- @tparam boolean args.tiled Enable or disable the tiling.
-- @tparam wibox.widget args.widget The widget to be placed.
-- @tparam boolean args.fill_vertical Fill the vertical space.
-- @tparam boolean args.fill_horizontal Fill the horizontal space.
-- @tparam boolean args.content_fill_vertical Stretch the contained widget so it takes all the vertical space.
-- @tparam boolean args.content_fill_horizontal Stretch the contained widget so it takes all the horizontal space.
-- @constructorfct wibox.container.tile
function module.mt:__call(...)
    return new(...)
end

return setmetatable(module, module.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
