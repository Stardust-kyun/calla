---------------------------------------------------------------------------
-- A container capable of changing the background color, foreground color and
-- widget shape.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_defaults_background.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @author Uli Schlachter
-- @copyright 2010 Uli Schlachter
-- @containermod wibox.container.background
-- @supermodule wibox.widget.base
---------------------------------------------------------------------------

local base = require("wibox.widget.base")
local color = require("gears.color")
local surface = require("gears.surface")
local beautiful = require("beautiful")
local cairo = require("lgi").cairo
local gtable = require("gears.table")
local gshape = require("gears.shape")
local gdebug = require("gears.debug")
local setmetatable = setmetatable
local type = type
local unpack = unpack or table.unpack -- luacheck: globals unpack (compatibility with Lua 5.1)

local background = { mt = {} }

-- If a background is resized with the mouse, it might create a large
-- number of scaled texture. After the cache grows beyond this number, it
-- is purged.
local MAX_CACHE_SIZE = 10
local global_scaled_pattern_cache = setmetatable({}, {__mode = "k"})

local function clone_stops(input, output)
    local err, count = input:get_color_stop_count()

    if err ~= "SUCCESS" then return end

    for idx = 0, count-1 do
        local _, off, r, g, b, a = input:get_color_stop_rgba(idx)
        output:add_color_stop_rgba(off, r, g, b, a)
    end
end

local function stretch_lineal_gradient(input, width, height)
    -- First, get the original values.
    local err, x0, y0, x1, y1 = input:get_linear_points()

    if err ~= "SUCCESS" then
        return input
    end


    local new_x0, new_y0 = x1 == 0 and 0 or ((x0/x1)*width), y1 == 0 and 0 or ((y0/y1)*height)

    local output = cairo.Pattern.create_linear(new_x0, new_y0, width, height)

    clone_stops(input, output)

    return output
end

local function stretch_radial_gradient(input, width, height)
    local err, cx0, cy0, radius0, cx1, cy1, radius1 = input:get_radial_circles()

    if err ~= "SUCCESS" then
        return input
    end

    -- Create a box for the original gradient, starting at 0x0.
    local x1 = math.max(cx0 + radius0, cx1 + radius1)
    local y1 = math.max(cy0 + radius0, cy1 + radius1)

    -- Now scale this box to `width`x`height`
    local x_factor, y_factor = width/x1, height/y1
    local rad_factor = math.sqrt(width^2 + height^2) / math.sqrt(x1^1+y1^2)

    local output = cairo.Pattern.create_radial(
        cx0*x_factor, cy0*y_factor, radius0*rad_factor, cx1*x_factor, cx1*y_factor, radius1*rad_factor
    )

    clone_stops(input, output)

    return output
end

local function get_pattern_size(pat)
    local t = pat.type

    if t == "LINEAR" then
        local _, _, _, x1, y1 = pat:get_linear_points()

        return x1, y1
    elseif t == "RADIAL" then
        local _, _, _, cx1, cy1, _ = pat:get_radial_circles()

        return cx1, cy1
    end
end

local function stretch_common(self, width, height)
    if (not self._private.background) and (not self._private.bgimage) then return end

    if not (self._private.stretch_horizontally or self._private.stretch_vertically) then
        return self._private.background, self._private.bgimage
    end

    local old = self._private.background
    local size_w, size_h = get_pattern_size(old)

    -- Note that technically, we could handle cairo.SurfacePattern and
    -- cairo.RasterSourcePattern. However, this might create some surprising
    -- results. For example switching to a different theme which uses tiled
    -- pattern would change the "meaning" of this property.
    if not size_w then return end

    -- Don't try to resize zero-sized patterns. They are used for
    -- generic liear gradient means "there is no gradient in this axis"
    if self._private.stretch_vertically and size_h ~= 0 then
        size_h = height
    end

    if self._private.stretch_horizontally and size_w ~= 0 then
        size_w = width
    end

    local hash = size_w.."x"..size_h

    if self._private.scale_cache[hash] then
        return self._private.scale_cache[hash]
    end

    if global_scaled_pattern_cache[old] and global_scaled_pattern_cache[old][hash] then
        -- Don't bother clearing the cache, if the pattern is already cached
        -- elsewhere, it will remain in memory anyway.
        self._private.scale_cache[hash] = global_scaled_pattern_cache[old][hash]
        self._private.scale_cache_size = self._private.scale_cache_size + 1
    end

    local t, new = old.type

    if t == "LINEAR" then
        new = stretch_lineal_gradient(old, size_w, size_h)
    elseif t == "RADIAL" then
        new = stretch_radial_gradient(old, size_w, size_h)
    end

    global_scaled_pattern_cache[old] = global_scaled_pattern_cache[old] or setmetatable({}, {__mode = "v"})
    global_scaled_pattern_cache[old][hash] = new

    -- Prevent the memory leak.
    if self._private.scale_cache_size > MAX_CACHE_SIZE then
        self._private.scale_cache_size = 0
        self._private.scale_cache = {}
    end

    self._private.scale_cache[hash] = new
    self._private.scale_cache_size = self._private.scale_cache_size + 1

    return new, self._private.bgimage
end

-- The Cairo SVG backend doesn't support surface as patterns correctly.
-- The result is both glitchy and blocky. It is also impossible to introspect.
-- Calling this function replace the normal code path is a "less correct", but
-- more widely compatible version.
function background._use_fallback_algorithm()
    background.before_draw_children = function(self, _, cr, width, height)
        local bw    = self._private.shape_border_width or 0
        local shape = self._private.shape or gshape.rectangle

        if bw > 0 then
            cr:translate(bw, bw)
            width, height = width - 2*bw, height - 2*bw
        end

        shape(cr, width, height)

        local bg = stretch_common(self, width, height)

        if bg then
            cr:save() --Save to avoid messing with the original source
            cr:set_source(bg)
            cr:fill_preserve()
            cr:restore()
        end

        cr:translate(-bw, -bw)
        cr:clip()

        if self._private.foreground then
            cr:set_source(self._private.foreground)
        end
    end

    background.after_draw_children = function(self, _, cr, width, height)
        local bw    = self._private.shape_border_width or 0
        local shape = self._private.shape or gshape.rectangle

        if bw > 0 then
            cr:save()
            cr:reset_clip()

            local mat = cr:get_matrix()

            -- Prevent the inner part of the border from being written.
            local mask = cairo.RecordingSurface(cairo.Content.COLOR_ALPHA,
                cairo.Rectangle { x = 0, y = 0, width = mat.x0 + width, height = mat.y0 + height })

            local mask_cr = cairo.Context(mask)
            mask_cr:set_matrix(mat)

            -- Clear the surface.
            mask_cr:set_operator(cairo.Operator.CLEAR)
            mask_cr:set_source_rgba(0, 1, 0, 0)
            mask_cr:paint()

            -- Paint the inner and outer borders.
            mask_cr:set_operator(cairo.Operator.SOURCE)
            mask_cr:translate(bw, bw)
            mask_cr:set_source_rgba(1, 0, 0, 1)
            mask_cr:set_line_width(2*bw)
            shape(mask_cr, width - 2*bw, height - 2*bw)
            mask_cr:stroke_preserve()

            -- Remove the inner part.
            mask_cr:set_source_rgba(0, 1, 0, 0)
            mask_cr:set_operator(cairo.Operator.CLEAR)
            mask_cr:fill()
            mask:flush()

            cr:set_source(color(self._private.shape_border_color or self._private.foreground or beautiful.fg_normal))
            cr:mask_surface(mask, 0,0)
            cr:restore()
        end
    end
end

-- Make sure a surface pattern is freed *now*
local function dispose_pattern(pattern)
    local status, s = pattern:get_surface()
    if status == "SUCCESS" then
        s:finish()
    end
end

-- Prepare drawing the children of this widget
function background:before_draw_children(context, cr, width, height)
    local bw    = self._private.shape_border_width or 0
    local shape = self._private.shape or (bw > 0 and gshape.rectangle or nil)

    -- Redirect drawing to a temporary surface if there is a shape
    if shape then
        cr:push_group_with_content(cairo.Content.COLOR_ALPHA)
    end

    local bg, bgimage = stretch_common(self, width, height)

    -- Draw the background
    if bg then
        cr:save()
        cr:set_source(bg)
        cr:rectangle(0, 0, width, height)
        cr:fill()
        cr:restore()
    end

    if bgimage then
        cr:save()
        if type(self._private.bgimage) == "function" then
            self._private.bgimage(context, cr, width, height,unpack(self._private.bgimage_args))
        else
            local pattern = cairo.Pattern.create_for_surface(self._private.bgimage)
            cr:set_source(pattern)
            cr:rectangle(0, 0, width, height)
            cr:fill()
        end
        cr:restore()
    end

    if self._private.foreground then
        cr:set_source(self._private.foreground)
    end
end

-- Draw the border
function background:after_draw_children(_, cr, width, height)
    local bw    = self._private.shape_border_width or 0
    local shape = self._private.shape or (bw > 0 and gshape.rectangle or nil)

    if not shape then
        return
    end

    -- Okay, there is a shape. Get it as a path.

    cr:translate(bw, bw)
    shape(cr, width - 2*bw, height - 2*bw, unpack(self._private.shape_args or {}))
    cr:translate(-bw, -bw)

    if bw > 0 then
        -- Now we need to do a border, somehow. We begin with another
        -- temporary surface.
        cr:push_group_with_content(cairo.Content.ALPHA)

        -- Mark everything as "this is border"
        cr:set_source_rgba(0, 0, 0, 1)
        cr:paint()

        -- Now remove the inside of the shape to get just the border
        cr:set_operator(cairo.Operator.SOURCE)
        cr:set_source_rgba(0, 0, 0, 0)
        cr:fill_preserve()

        local mask = cr:pop_group()
        -- Now actually draw the border via the mask we just created.
        cr:set_source(color(self._private.shape_border_color or self._private.foreground or beautiful.fg_normal))
        cr:set_operator(cairo.Operator.SOURCE)
        cr:mask(mask)

        dispose_pattern(mask)
    end

    -- We now have the right content in a temporary surface. Copy it to the
    -- target surface. For this, we need another mask
    cr:push_group_with_content(cairo.Content.ALPHA)

    -- Draw the border with 2 * border width (this draws both
    -- inside and outside, only half of it is outside)
    cr.line_width = 2 * bw
    cr:set_source_rgba(0, 0, 0, 1)
    cr:stroke_preserve()

    -- Now fill the whole inside so that it is also include in the mask
    cr:fill()

    local mask = cr:pop_group()
    local source = cr:pop_group() -- This pops what was pushed in before_draw_children

    -- This now draws the content of the background widget to the actual
    -- target, but only the part that is inside the mask
    cr:set_operator(cairo.Operator.OVER)
    cr:set_source(source)
    cr:mask(mask)

    dispose_pattern(mask)
    dispose_pattern(source)
end

-- Layout this widget
function background:layout(_, width, height)
    if self._private.widget then
        local bw = self._private.border_strategy == "inner" and
            self._private.shape_border_width or 0

        return { base.place_widget_at(
            self._private.widget, bw, bw, width-2*bw, height-2*bw
        ) }
    end
end

-- Fit this widget into the given area
function background:fit(context, width, height)
    if not self._private.widget then
        return 0, 0
    end

    local bw = self._private.border_strategy == "inner" and
        self._private.shape_border_width or 0

    local w, h = base.fit_widget(
        self, context, self._private.widget, width - 2*bw, height - 2*bw
    )

    return w+2*bw, h+2*bw
end

--- The widget displayed in the background widget.
-- @property widget
-- @tparam[opt=nil] widget|nil widget The widget to be disaplayed inside of
--  the background area.
-- @interface container

background.set_widget = base.set_widget_common

function background:get_widget()
    return self._private.widget
end

function background:get_children()
    return {self._private.widget}
end

function background:set_children(children)
    self:set_widget(children[1])
end

--- Stretch the background gradient horizontally.
--
-- This only works for linear or radial gradients. It does nothing
-- for solid colors, `bgimage` or raster patterns.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_background_stretch_horizontally.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- local gradients = {
--     gears.color {
--         type  = &#34linear&#34,
--         from  = { 0  , 0 },
--         to    = { 100, 0 },
--         stops = {
--             { 0  , &#34#0000ff&#34 },
--             { 0.8, &#34#0000ff&#34 },
--             { 1  , &#34#ff0000&#34 }
--         }
--     },
--     gears.color {
--         type = &#34radial&#34,
--         from  = { 30, 98, 20  },
--         to    = { 30, 98, 120 },
--         stops = {
--             { 0  , &#34#ff0000&#34 },
--             { 0.5, &#34#00ff00&#34 },
--             { 1  , &#34#0000ff&#34 },
--         }
--     }
-- }
--  
-- for k, stretch in ipairs { false, true } do
--     for __, grad in ipairs(gradients) do
--         for idx, width in ipairs { 50, 100, 150, 200 } do
--             local w = wibox.widget {
--                 {
--                     {
--                         text   = &#34  Width: &#34 .. width .. &#34  &#34,
--                         valign = &#34center&#34,
--                         align  = &#34center&#34,
--                         widget = wibox.widget.textbox
--                     },
--                     bg                   = grad,
--                     stretch_horizontally = stretch,
--                     forced_width         = width,
--                     fg                   = &#34#ffffff&#34,
--                     shape                = gears.shape.rounded_rect,
--                     widget               = wibox.container.background
--                 },
--                 forced_width  = 200,
--                 widget        = wibox.container.place
--             }
--         end
--     end
-- end
--
-- @property stretch_horizontally
-- @tparam[opt=false] boolean stretch_horizontally
-- @propemits true false
-- @see stretch_vertically
-- @see bg
-- @see gears.color

--- Stretch the background gradient vertically.
--
-- This only works for linear or radial gradients. It does nothing
-- for solid colors, `bgimage` or raster patterns.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_background_stretch_vertically.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- local gradients = {
--     gears.color {
--         type  = &#34linear&#34,
--         from  = { 0, 0   },
--         to    = { 0, 100 },
--         stops = {
--             { 0  , &#34#0000ff&#34 },
--             { 0.8, &#34#0000ff&#34 },
--             { 1  , &#34#ff0000&#34 }
--         }
--     },
--     gears.color {
--         type = &#34radial&#34,
--         from  = { 30, 98, 20  },
--         to    = { 30, 98, 120 },
--         stops = {
--             { 0  , &#34#ff0000&#34 },
--             { 0.5, &#34#00ff00&#34 },
--             { 1  , &#34#0000ff&#34 },
--         }
--     }
-- }
--  
-- for k, stretch in ipairs { false, true } do
--     for _, gradient in ipairs(gradients) do
--         for idx, height in ipairs { 10, 50, 100, 150 } do
--             local w = wibox.widget {
--                 {
--                     {
--                         text   = &#34  Height: &#34 .. height .. &#34  &#34,
--                         valign = &#34center&#34,
--                         align  = &#34center&#34,
--                         widget = wibox.widget.textbox
--                     },
--                     bg                 = gradient,
--                     stretch_vertically = stretch,
--                     forced_height      = height,
--                     fg                 = &#34#ffffff&#34,
--                     shape              = gears.shape.rounded_rect,
--                     widget             = wibox.container.background
--                 },
--                 forced_height = 150,
--                 widget        = wibox.container.place
--             }
--         end
--     end
-- end
--
-- @property stretch_vertically
-- @tparam[opt=false] boolean stretch_vertically
-- @propemits true false
-- @see stretch_horizontally
-- @see bg
-- @see gears.color

for _, orientation in ipairs {"horizontally", "vertically"} do
    background["set_stretch_"..orientation] = function(self, value)
        self._private["stretch_"..orientation] = value
        self:emit_signal("widget::redraw_needed")
        self:emit_signal("property::stretch_"..orientation, value)
    end
end

--- The background color/pattern/gradient to use.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_background_bg.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- local text_widget = {
--     text   = &#34Hello world!&#34,
--     widget = wibox.widget.textbox
-- }
-- parent : setup {
--     {
--         text_widget,
--         bg     = '#ff0000',
--         widget = wibox.container.background
--     },
--     {
--         text_widget,
--         bg     = '#00ff00',
--         widget = wibox.container.background
--     },
--     {
--         text_widget,
--         bg     = '#0000ff',
--         widget = wibox.container.background
--     },
--     spacing = 10,
--     layout  = wibox.layout.fixed.vertical
-- }
--
-- @property bg
-- @tparam color bg
-- @propertydefault When unspecified, it will inherit the value from an higher
--  level `wibox.container.background` or directly from the `wibox.bg` property.
-- @see gears.color
-- @propemits true false

function background:set_bg(bg)
    if bg then
        self._private.background = color(bg)
    else
        self._private.background = nil
    end
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::bg", bg)
end

function background:get_bg()
    return self._private.background
end

--- The foreground (text) color/pattern/gradient to use.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_background_fg.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- local text_widget = {
--     text   = &#34Hello world!&#34,
--     widget = wibox.widget.textbox
-- }
-- parent : setup {
--     {
--         text_widget,
--         fg     = '#ff0000',
--         widget = wibox.container.background
--     },
--     {
--         text_widget,
--         fg     = '#00ff00',
--         widget = wibox.container.background
--     },
--     {
--         text_widget,
--         fg     = '#0000ff',
--         widget = wibox.container.background
--     },
--     spacing = 10,
--     layout  = wibox.layout.fixed.vertical
-- }
--
-- @property fg
-- @tparam color fg A color string, pattern or gradient
-- @propertydefault When unspecified, it will inherit the value from an higher
--  level `wibox.container.background` or directly from the `wibox.fg` property.
-- @propemits true false
-- @see gears.color

function background:set_fg(fg)
    if fg then
        self._private.foreground = color(fg)
    else
        self._private.foreground = nil
    end
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::fg", fg)
end

function background:get_fg()
    return self._private.foreground
end

--- The background shape.
--
-- Use `set_shape` to set additional shape paramaters.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_background_shape.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- parent : setup {
--     {
--         -- Adding a shape without margin may result in cropped output
--         {
--             text   = &#34Hello world!&#34,
--             widget = wibox.widget.textbox
--         },
--         shape              = gears.shape.hexagon,
--         bg                 = beautiful.bg_normal,
--         shape_border_color = beautiful.border_color,
--         shape_border_width = beautiful.border_width,
--         widget             = wibox.container.background
--     },
--     {
--         -- To solve this, use a margin
--         {
--             {
--                 text   = &#34Hello world!&#34,
--                 widget = wibox.widget.textbox
--             },
--             left   = 10,
--             right  = 10,
--             top    = 3,
--             bottom = 3,
--             widget = wibox.container.margin
--         },
--         shape        = gears.shape.hexagon,
--         bg           = beautiful.bg_normal,
--         border_color = beautiful.border_color,
--         border_width = beautiful.border_width,
--         widget       = wibox.container.background
--     },
--     spacing = 10,
--     layout  = wibox.layout.fixed.vertical
-- }
--
-- @property shape
-- @tparam[opt=gears.shape.rectangle] shape shape
-- @see gears.shape
-- @see set_shape

--- Set the background shape.
--
-- Any other arguments will be passed to the shape function.
--
-- @method set_shape
-- @tparam gears.shape|function shape A function taking a context, width and height as arguments
-- @noreturn
-- @propemits true false
-- @see gears.shape
-- @see shape
function background:set_shape(shape, ...)
    local args = {...}

    if shape == self._private.shape and #args == 0 then return end

    self._private.shape = shape
    self._private.shape_args = {...}
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::shape", shape)
end

function background:get_shape()
    return self._private.shape
end

--- When a `shape` is set, also draw a border.
--
-- See `wibox.container.background.shape` for an usage example.
--
-- @deprecatedproperty shape_border_width
-- @tparam number width The border width
-- @renamedin 4.4 border_width
-- @see border_width

--- Add a border of a specific width.
--
-- If the shape is set, the border will also be shaped.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_background_border_width.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, width in ipairs {0, 1, 3, 10 } do
--     local w = wibox.widget {
--         {
--             {
--                 text          = &#34  Content  &#34,
--                 valign        = &#34center&#34,
--                 align         = &#34center&#34,
--                 widget        = wibox.widget.textbox
--             },
--             margins = 10,
--             widget  = wibox.container.margin
--         },
--         border_color = beautiful.bg_normal,
--         border_width = width,
--         shape        = gears.shape.rounded_rect,
--         widget       = wibox.container.background
--     }
-- end
--
-- @property border_width
-- @tparam[opt=0] number border_width
-- @propertyunit pixel
-- @negativeallowed false
-- @propemits true false
-- @introducedin 4.4
-- @see border_color

function background:set_border_width(width)
    if self._private.shape_border_width == width then return end

    self._private.shape_border_width = width
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::border_width", width)
end

function background:get_border_width()
    return self._private.shape_border_width
end

function background.get_shape_border_width(...)
    gdebug.deprecate("Use `border_width` instead of `shape_border_width`",
        {deprecated_in=5})

    return background.get_border_width(...)
end

function background.set_shape_border_width(...)
    gdebug.deprecate("Use `border_width` instead of `shape_border_width`",
        {deprecated_in=5})

    background.set_border_width(...)
end

--- When a `shape` is set, also draw a border.
--
-- See `wibox.container.background.shape` for an usage example.
--
-- @deprecatedproperty shape_border_color
-- @usebeautiful beautiful.fg_normal Fallback when 'fg' and `border_color` aren't set.
-- @tparam color fg The border color, pattern or gradient
-- @renamedin 4.4 border_color
-- @see gears.color
-- @see border_color

--- Set the color for the border.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_background_border_color.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- local colors = {
--     beautiful.bg_normal,
--     &#34#00ff00&#34,
--     gears.color {
--         type  = &#34linear&#34,
--         from  = { 0 , 20 },
--         to    = { 20, 0  },
--         stops = {
--             { 0, &#34#0000ff&#34 },
--             { 1, &#34#ff0000&#34 }
--         },
--     },
-- }
--  
-- for _, color in ipairs(colors) do
--     local w = wibox.widget {
--         {
--             {
--                 text          = &#34  Content  &#34,
--                 valign        = &#34center&#34,
--                 align         = &#34center&#34,
--                 widget        = wibox.widget.textbox
--             },
--             margins = 10,
--             widget  = wibox.container.margin
--         },
--         border_color         = color,
--         border_width         = 3,
--         stretch_vertically   = true,
--         stretch_horizontally = true,
--         shape                = gears.shape.rounded_rect,
--         widget               = wibox.container.background
--     }
-- end
--
-- See `wibox.container.background.shape` for an usage example.
-- @property border_color
-- @tparam color border_color
-- @propertydefault `wibox.container.background.fg` if set, otherwise `beautiful.fg_normal`.
-- @propemits true false
-- @usebeautiful beautiful.fg_normal Fallback when 'fg' and `border_color` aren't set.
-- @introducedin 4.4
-- @see gears.color
-- @see border_width

function background:set_border_color(fg)
    if self._private.shape_border_color == fg then return end

    self._private.shape_border_color = fg
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::border_color", fg)
end

function background:get_border_color()
    return self._private.shape_border_color
end

function background.get_shape_border_color(...)
    gdebug.deprecate("Use `border_color` instead of `shape_border_color`",
        {deprecated_in=5})

    return background.get_border_color(...)
end

function background.set_shape_border_color(...)
    gdebug.deprecate("Use `border_color` instead of `shape_border_color`",
        {deprecated_in=5})

    background.set_border_color(...)
end

function background:set_shape_clip(value)
    if value then return end
    require("gears.debug").print_warning("shape_clip property of background container was removed."
        .. " Use wibox.layout.stack instead if you want shape_clip=false.")
end

function background:get_shape_clip()
    require("gears.debug").print_warning("shape_clip property of background container was removed."
        .. " Use wibox.layout.stack instead if you want shape_clip=false.")
    return true
end

--- How the border width affects the contained widget.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_container_background_border_strategy.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for k, strategy in ipairs { &#34none&#34, &#34inner&#34 } do
--     for idx, width in ipairs {0, 1, 3, 10 } do
--         local w = wibox.widget {
--             {
--                 {
--                     text          = &#34border_width = &#34..width,
--                     valign        = &#34center&#34,
--                     align         = &#34center&#34,
--                     widget        = wibox.widget.textbox
--                 },
--                 border_color    = beautiful.bg_normal,
--                 border_width    = width,
--                 border_strategy = strategy,
--                 shape           = gears.shape.rounded_rect,
--                 widget          = wibox.container.background
--             },
--             widget = wibox.container.place
--         }
--     end
-- end
--
-- @property border_strategy
-- @tparam[opt="none"] string border_strategy
-- @propertyvalue "none" Just apply the border, do not affect the content size (default).
-- @propertyvalue "inner" Squeeze the size of the content by the border width.
-- @propemits true false

function background:set_border_strategy(value)
    self._private.border_strategy = value
    self:emit_signal("widget::layout_changed")
    self:emit_signal("property::border_strategy", value)
end

--- The background image to use.
--
-- This property is deprecated. The `wibox.container.border` provides a much
-- more fine-grained support for background images. It is now out of the
-- `wibox.container.background` scope. `wibox.layout.stack` can also be used
-- to overlay a widget on top of a `wibox.widget.imagebox`. This solution
-- exposes all availible imagebox properties. Finally, if you wish to use the
-- `function` callback support, implement the `before_draw_children` method
-- on any widget. This gives you the same level of control without all the
-- `bgimage` corner cases.
--
-- If `image` is a function, it will be called with `(context, cr, width, height)`
-- as arguments. Any other arguments passed to this method will be appended.
--
-- @deprecatedproperty bgimage
-- @tparam string|surface|function bgimage A background image or a function.
-- @see gears.surface
-- @see wibox.container.border
-- @see wibox.widget.imagebox
-- @see wibox.layout.stack

function background:set_bgimage(image, ...)
    self._private.bgimage = type(image) == "function" and image or surface.load(image)
    self._private.bgimage_args = {...}
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::bgimage", image)
end

function background:get_bgimage()
    return self._private.bgimage
end

--- Returns a new background container.
--
-- A background container applies a background and foreground color
-- to another widget.
--
-- @tparam[opt] widget widget The widget to display.
-- @tparam[opt] color bg The background to use for that widget.
-- @tparam[opt] gears.shape|function shape A `gears.shape` compatible shape function
-- @constructorfct wibox.container.background
local function new(widget, bg, shape)
    local ret = base.make_widget(nil, nil, {
        enable_properties = true,
    })

    gtable.crush(ret, background, true)

    ret._private.shape = shape
    ret._private.scale_cache = {}
    ret._private.scale_cache_size = 0

    ret:set_widget(widget)
    ret:set_bg(bg)

    return ret
end

function background.mt:__call(...)
    return new(...)
end

return setmetatable(background, background.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
