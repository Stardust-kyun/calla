---------------------------------------------------------------------------
--- Allows to use the wibox widget system to draw the wallpaper.
--
-- Rather than simply having a function to set an image
-- (stretched, centered or tiled) like most wallpaper tools, this module
-- leverage the full widget system to draw the wallpaper. Note that the result
-- is **not** interactive. If you want an interactive wallpaper, better use
-- a `wibox` object with the `below` property set to `true` and maximized
-- using `awful.placement.maximized`.
--
-- It is possible to create an `awful.wallpaper` object from any places, but
-- it is recommanded to do it from the `request::wallpaper` signal handler.
-- That signal is called everytime something which could affect the wallpaper
-- rendering changes, such as new screens.
--
-- Single image
-- ============
--
-- This is the default `rc.lua` wallpaper format. It fills the whole screen
-- and stretches the image while keeping the aspect ratio.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_mazimized1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    awful.wallpaper {
--        screen = s,
--        widget = {
--            {
--                image  = beautiful.wallpaper,
--                resize = true,
--                widget = wibox.widget.imagebox,
--            },
--            valign = &#34center&#34,
--            halign = &#34center&#34,
--            tiled  = false,
--            widget = wibox.container.tile,
--        }
--    }
--
-- If the image aspect ratio doesn't match, the `bg` property can be used to
-- fill the empty area:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_mazimized2.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    awful.wallpaper {
--        screen = s,
--        bg     = &#34#0000ff&#34,
--        widget = {
--            {
--                image  = beautiful.wallpaper,
--                resize = true,
--                widget = wibox.widget.imagebox,
--            },
--            valign = &#34center&#34,
--            halign = &#34center&#34,
--            tiled  = false,
--            widget = wibox.container.tile,
--        }
--    }
--
-- It is also possible to stretch the image:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_mazimized3.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    awful.wallpaper {
--        screen = s,
--        widget = {
--             horizontal_fit_policy = &#34fit&#34,
--             vertical_fit_policy   = &#34fit&#34,
--             image                 = beautiful.wallpaper,
--             widget                = wibox.widget.imagebox,
--         },
--    }
--
-- To maintain the image's aspect ratio while filling the
-- screen, the image can be cropped using `gears.surface`:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_mazimized4.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    awful.wallpaper {
--        screen = s,
--        widget = {
--             image  = gears.surface.crop_surface {
--                 surface = gears.surface.load_uncached(beautiful.wallpaper),
--                 ratio = s.geometry.width/s.geometry.height,
--             },
--             widget = wibox.widget.imagebox,
--         },
--    }
--
-- Finally, it is also possible to use simpler "branding" in a corner using
-- `awful.placement`:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_corner1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    awful.wallpaper {
--        screen = s,
--        bg     = &#34#000000&#34,
--        widget = {
--            {
--                {
--                    image  = beautiful.awesome_icon,
--                    resize = false,
--                    point  = awful.placement.bottom_right,
--                    widget = wibox.widget.imagebox,
--                },
--                widget = wibox.layout.manual,
--            },
--            margins = 5,
--            widget  = wibox.container.margin
--        }
--    }
--
-- Tiled
-- =====
--
-- This example tiles an image:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_tiled1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    awful.wallpaper {
--        screen = s,
--        bg     = &#34#0000ff&#34,
--        widget = {
--            {
--                image  = beautiful.awesome_icon,
--                resize = false,
--                widget = wibox.widget.imagebox,
--            },
--            horizontal_spacing = 5,
--            vertical_spacing   = 5,
--            valign             = &#34top&#34,
--            halign             = &#34left&#34,
--            tiled              = true,
--            widget             = wibox.container.tile,
--        }
--    }
--
-- This one tiles a shape using the `wibox.widget.separator` widget:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_tiled2.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    awful.wallpaper {
--        screen = s,
--        bg     = &#34#0000ff&#34,
--        widget = {
--            {
--                shape         = gears.shape.star,
--                forced_width  = 30,
--                forced_height = 30,
--                widget        = wibox.widget.separator,
--            },
--            horizontal_spacing = 5,
--            vertical_spacing   = 5,
--            vertical_crop      = true,
--            horizontal_crop    = true,
--            valign             = &#34center&#34,
--            halign             = &#34center&#34,
--            tiled              = true,
--            widget             = wibox.container.tile,
--        }
--    }
--
-- See the `wibox.container.tile` for more advanced tiling configuration
-- options.
--
-- Solid colors and gradients
-- ==========================
--
-- Solid colors can be set using the `bg` property mentionned above. It
-- is also possible to set gradients:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_gradient1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    awful.wallpaper {
--        screen = s,
--        bg     = {
--            type  = &#34linear&#34 ,
--            from  = { 0, 0  },
--            to    = { 0, 240 },
--            stops = {
--                { 0, &#34#0000ff&#34 },
--                { 1, &#34#ff0000&#34 }
--            }
--         }
--    }
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_gradient2.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    awful.wallpaper {
--        screen = s,
--        bg     = {
--            type = &#34radial&#34,
--            from  = { 160, 98, 20  },
--            to    = { 160, 98, 120 },
--            stops = {
--                { 0  , &#34#ff0000&#34 },
--                { 0.5, &#34#00ff00&#34 },
--                { 1  , &#34#0000ff&#34 },
--            }
--        }
--    }
--
-- Widgets
-- =======
--
-- It is possible to create a wallpaper using any widgets. However, keep
-- in mind that the wallpaper surface is not interactive, so some widgets
-- like the sliders will render, but will not behave correctly. Also, it
    -- is not recommanded to update the wallpaper too often. This is very slow.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_widget2.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    local function binary()
--        local ret = {}
--        for _=1, 15 do
--            for _=1, 57 do
--                table.insert(ret, math.random() > 0.5 and 1 or 0)
--            end
--            table.insert(ret, &#34\n&#34)
--        end
--        return table.concat(ret)
--    end
--     
--    awful.wallpaper {
--        bg     = &#34#000000&#34,
--        fg     = &#34#55ff5577&#34,
--        widget = wibox.widget {
--            {
--                {
--                    markup = &#34<tt><b>[SYSTEM FAILURE]</b></tt>&#34,
--                    valign = &#34center&#34,
--                    halign = &#34center&#34,
--                    widget = wibox.widget.textbox
--                },
--                fg = &#34#00ff00&#34,
--                widget = wibox.container.background
--            },
--            {
--                wrap   = &#34word&#34,
--                text   = binary(),
--                widget = wibox.widget.textbox,
--            },
--            widget = wibox.layout.stack
--        },
--    }
--
-- Cairo graphics API
-- ==================
--
-- AwesomeWM widgets are backed by Cairo. So it is always possible to get
-- access to the Cairo context directly to do some vector art:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_widget1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    awful.wallpaper {
--        screen = s,
--        widget = wibox.widget {
--             fit = function(_, width, height)
--                 return width, height
--             end,
--             draw = function(_, _, cr, width, height)
--                 cr:set_source(gears.color {
--                     type  = 'linear',
--                     from  = { 0, 0      },
--                     to    = { 0, height },
--                     stops = {
--                         { 0   , '#030d27' },
--                         { 0.75, '#3a183f' },
--                         { 0.75, '#000000' },
--                         { 1   , '#222222' }
--                     }
--                 })
--                 cr:paint()
--                 -- Clip the first 33% of the screen
--                 cr:rectangle(0,0, width, height/3)
--                  
--                 -- Clip-out some increasingly large sections of add the sun &#34bars&#34
--                 for i=0, 6 do
--                     cr:rectangle(0, height*.28 + i*(height*.055 + i/2), width, height*.055)
--                 end
--                 cr:clip()
--                  
--                 -- Draw the sun
--                 cr:set_source(gears.color {
--                     type  = 'linear' ,
--                     from  = { 0, 0      },
--                     to    = { 0, height },
--                     stops = {
--                         { 0, '#f0d64f' },
--                         { 1, '#e484c6' }
--                     }
--                 })
--                 cr:arc(width/2, height/2, height*.35, 0, math.pi*2)
--                 cr:fill()
--                  
--                 -- Draw the grid
--                 local lines = width/8
--                 cr:reset_clip()
--                 cr:set_line_width(0.5)
--                 cr:set_source(gears.color(&#34#8922a3&#34))
--                  
--                 for i=1, lines do
--                     cr:move_to((-width) + i* math.sin(i * (math.pi/(lines*2)))*30, height)
--                     cr:line_to(width/4 + i*((width/2)/lines), height*0.75 + 2)
--                     cr:stroke()
--                 end
--                  
--                 for i=1, 5 do
--                     cr:move_to(0, height*0.75 + i*10 + i*2)
--                     cr:line_to(width, height*0.75 + i*10 + i*2)
--                     cr:stroke()
--                 end
--             end,
--        }
--    }
--
--
-- SVG vector images
-- =================
--
-- SVG are supported if `librsvg` is installed. Please note that `librsvg`
-- doesn't implement all filters you might find in the latest version of
-- your web browser. It is possible some advanced SVG will not look exactly
-- as they do in a web browser or even Inkscape. However, for most images,
-- it should look identical.
--
-- Our SVG support goes beyond simple rendering. It is possible to set a
-- custom CSS stylesheet (see `wibox.widget.imagebox.stylesheet`):
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_svg.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    local image = '<?xml version=&#341.0&#34 encoding=&#34UTF-8&#34 standalone=&#34no&#34?>'..
--        '<svg width=&#34190&#34 height=&#3460&#34>'..
--            '<rect x=&#3410&#34  y=&#3410&#34 width=&#3450&#34 height=&#3450&#34 />'..
--            '<rect x=&#3470&#34  y=&#3410&#34 width=&#3450&#34 height=&#3450&#34 class=&#34my_class&#34 />'..
--            '<rect x=&#34130&#34 y=&#3410&#34 width=&#3450&#34 height=&#3450&#34 id=&#34my_id&#34 />'..
--        '</svg>'
--     
--    local stylesheet = &#34&#34 ..
--         &#34rect { fill: #ffff00&#59 } &#34..
--         &#34.my_class { fill: #00ff00&#59 } &#34..
--         &#34#my_id { fill: #0000ff&#59 }&#34
--     
--    awful.wallpaper {
--        widget = wibox.widget {
--            stylesheet = stylesheet,
--            image      = image,
--            widget     = wibox.widget.imagebox
--        }
--    }
--
-- Note that in the example above, it is raw SVG code, but it is also possible
-- to use a file path. If you have a `.svgz`, you need to uncompress it first
-- using `gunzip` or a software like Inkscape.
--
-- Multiple screen
-- ===============
--
-- The default `rc.lua` creates a new wallpaper everytime `request::wallpaper`
-- is emitted. This is well suited for having a single wallpaper per screen.
-- It is also much simpler to implement slideshows and add/remove screens.
--
-- However, it isn't wall suited for wallpaper rendered across multiple screens.
-- For this case, it is better to capture the return value of `awful.wallpaper {}`
-- as a global variable. Then manually call `add_screen` and `remove_screen` when
-- needed. A shortcut can be to do:
--
-- 
--
--
-- 
--    local global_wallpaper = awful.wallpaper {
--        -- [...] your content
--    }
--  
--    screen.connect_signal(&#34request::wallpaper&#34, function()
--        -- `screen` is the global screen module. It is also a list of all screens.
--        global_wallpaper.screens = screen
--    end)
--
-- Slideshow
-- =========
--
-- Slideshows (changing the wallpaper after a few minutes) can be implemented
-- directly using a timer and callback, but it is more elegant to simply request
-- a new wallpaper, then get a random image from within the request handler. This
-- way, corner cases such as adding and removing screens are handled:
--
--
--
--
-- 
--    -- The &#34request::wallpaper&#34 section is already in the default
--    -- `rc.lua`, replace it with this.
--    screen.connect_signal(&#34request::wallpaper&#34, function(s)
--        awful.wallpaper {
--            screen = s,
--            bg     = &#34#0000ff&#34,
--            widget = {
--                {
--                    image  = gears.filesystem.get_random_file_from_dir(
--                        &#34path/to/dir&#34,
--                        {&#34.jpg&#34, &#34.png&#34, &#34.svg&#34},
--                        true
--                    ),
--                    resize = true,
--                    widget = wibox.widget.imagebox,
--                },
--                valign = &#34center&#34,
--                halign = &#34center&#34,
--                tiled  = false,
--                widget = wibox.container.tile,
--            }
--        }
--    end)
--     
--    -- **Somewhere else** in the code, **not** in the `request::wallpaper` handler.
--    gears.timer {
--        timeout   = 1800,
--        autostart = true,
--        callback  = function()
--            for s in screen do
--                s:emit_signal(&#34request::wallpaper&#34)
--            end
--        end,
--    }
--
-- @author Emmanuel Lepage Vallee &lt;elv1313@gmail.com&gt;
-- @copyright 2019 Emmanuel Lepage Vallee
-- @popupmod awful.wallpaper
---------------------------------------------------------------------------
require("awful._compat")
local gtable     = require( "gears.table"               )
local gobject    = require( "gears.object"              )
local gcolor     = require( "gears.color"               )
local gtimer     = require( "gears.timer"               )
local surface    = require( "gears.surface"             )
local base       = require( "wibox.widget.base"         )
local background = require( "wibox.container.background")
local beautiful  = require( "beautiful"                 )
local cairo      = require( "lgi" ).cairo
local draw       = require( "wibox.widget" ).draw_to_cairo_context
local grect      = require( "gears.geometry" ).rectangle

local capi = { screen = screen, root = root }

local module = {}

local function get_screen(s)
    return s and capi.screen[s]
end

-- Screen as key, wallpaper as values.
local pending_repaint = setmetatable({}, {__mode = 'k'})

local backgrounds = setmetatable({}, {__mode = 'k'})

local panning_modes = {}

-- Get a list of all screen areas.
local function get_rectangles(screens, honor_workarea, honor_padding)
    local ret = {}

    for _, s in ipairs(screens) do
        table.insert(ret, s:get_bounding_geometry {
            honor_padding  = honor_padding,
            honor_workarea = honor_workarea
        })
    end

    return ret
end

-- Outer perimeter of all rectangles.
function panning_modes.outer(self)
    local rectangles = get_rectangles(self.screens, self.honor_workarea, self.honor_padding)
    local p1, p2 = {x = math.huge, y = math.huge}, {x = 0, y = 0}

    for _, rect in ipairs(rectangles) do
        p1.x, p1.y = math.min(p1.x, rect.x),  math.min(p1.y, rect.y)
        p2.x, p2.y = math.max(p2.x, rect.x +  rect.width),  math.max(p2.y, rect.y + rect.height)
    end

    -- Never try to paint this, it would freeze the system.
    assert(p1.x ~= math.huge and p1.y ~= math.huge, "Setting wallpaper failed"..#self.screens)

    return {
        x      = p1.x,
        y      = p1.y,
        width  = p2.x - p1.x,
        height = p2.y - p1.y,
    }
end

-- Horizontal inner perimeter of all rectangles.
function panning_modes.inner_horizontal(self)
    local rectangles = get_rectangles(self.screens, self.honor_workarea, self.honor_padding)
    local p1, p2 = {x = math.huge, y = 0}, {x = 0, y = math.huge}

    for _, rect in ipairs(rectangles) do
        p1.x, p1.y = math.min(p1.x, rect.x),  math.max(p1.y, rect.y)
        p2.x, p2.y = math.max(p2.x, rect.x +  rect.width),  math.min(p2.y, rect.y + rect.height)
    end

    -- Never try to paint this, it would freeze the system.
    assert(p1.x ~= math.huge and p2.y ~= math.huge, "Setting wallpaper failed")

    return {
        x      = p1.x,
        y      = p1.y,
        width  = p2.x - p1.x,
        height = p2.y - p1.y,
    }
end

-- Vertical inner perimeter of all rectangles.
function panning_modes.inner_vertical(self)
    local rectangles = get_rectangles(self.screens, self.honor_workarea, self.honor_padding)
    local p1, p2 = {x = 0, y = math.huge}, {x = math.huge, y = 0}

    for _, rect in ipairs(rectangles) do
        p1.x, p1.y = math.max(p1.x, rect.x),  math.min(p1.y, rect.y)
        p2.x, p2.y = math.min(p2.x, rect.x +  rect.width),  math.max(p2.y, rect.y + rect.height)
    end

    -- Never try to paint this, it would freeze the system.
    assert(p1.y ~= math.huge and p2.a ~= math.huge, "Setting wallpaper failed")

    return {
        x      = p1.x,
        y      = p1.y,
        width  = p2.x - p1.x,
        height = p2.y - p1.y,
    }
end

-- Best or vertical and horizontal "inner" modes.
function panning_modes.inner(self)
    local vert = panning_modes.inner_vertical(self)
    local hori = panning_modes.inner_horizontal(self)

    if vert.width <= 0 or vert.height <= 0 then return hori end
    if hori.width <= 0 or hori.height <= 0 then return vert end

    if vert.width * vert.height > hori.width * hori.height then
        return vert
    else
        return hori
    end
end


local function paint()
    if not next(pending_repaint) then return end

    local root_width, root_height = capi.root.size()

    -- Get the current wallpaper content.
    local source = surface(root.wallpaper())

    local target, cr

    -- It's possible that a wallpaper for 1 screen is set using another tool, so make
    -- sure we copy the current content.
    if source then
        target = source:create_similar(cairo.Content.COLOR, root_width, root_height)
        cr     = cairo.Context(target)

        -- Copy the old wallpaper to the new one
        cr:save()
        cr.operator = cairo.Operator.SOURCE
        cr:set_source_surface(source, 0, 0)

        for s in screen do
            cr:rectangle(
                s.geometry.x,
                s.geometry.y,
                s.geometry.width,
                s.geometry.height
            )
        end

        cr:clip()

        cr:paint()
        cr:restore()
    else
        target = cairo.ImageSurface(cairo.Format.RGB32, root_width, root_height)
        cr     = cairo.Context(target)
    end

    local walls = {}

    for _, wall in pairs(backgrounds) do
        walls[wall] = true
    end

    -- Not supposed to happen, but there is enough API surface for
    -- it to be a side effect of some signals. Calling the panning
    -- mode callback with zero screen is not supported.
    if not next(walls) then
        return
    end

    for wall in pairs(walls) do

        local geo = type(wall._private.panning_area) == "function" and
            wall._private.panning_area(wall) or
            panning_modes[wall._private.panning_area](wall)

        -- If false, this panning area isn't well suited for the screen geometry.
        if geo.width > 0 or geo.height > 0 then
            local uncovered_areas = grect.area_remove(get_rectangles(wall.screens, false, false), geo)

            cr:save()

            -- Prevent overwrite then there is multiple non-continuous screens.
            for _, s in ipairs(wall.screens) do
                cr:rectangle(
                    s.geometry.x,
                    s.geometry.y,
                    s.geometry.width,
                    s.geometry.height
                )
            end

            cr:clip()

            -- The older surface might contain garbage, optionally clean it.
            if wall.uncovered_areas_color then
                cr:set_source(gcolor(wall.uncovered_areas_color))

                for _, area in ipairs(uncovered_areas) do
                    cr:rectangle(area.x, area.y, area.width, area.height)
                    cr:fill()
                end
            end

            if not wall._private.container then
                wall._private.container = background()
                wall._private.container.bg = wall._private.bg or beautiful.wallpaper_bg or "#000000"
                wall._private.container.fg = wall._private.fg or beautiful.wallpaper_fg or "#ffffff"
                wall._private.container.widget = wall.widget
            end

            local a_context = {
                dpi = wall._private.context.dpi
            }

            -- Pick the lowest DPI.
            if not a_context.dpi then
                a_context.dpi = math.huge
                for _, s in ipairs(wall.screens) do
                    a_context.dpi = math.min(
                        s.dpi and s.dpi or s.preferred_dpi, a_context.dpi
                    )
                end
            end

            -- Fallback.
            if not a_context.dpi then
                a_context.dpi = 96
            end

            cr:translate(geo.x, geo.y)
            draw(wall._private.container, cr, geo.width, geo.height, a_context)
            cr:restore()
        end
    end

    -- Set the wallpaper.
    local pattern = cairo.Pattern.create_for_surface(target)
    capi.root.wallpaper(pattern)

    -- Limit some potential GC induced increase in memory usage.
    -- But really, is someone is trying to apply wallpaper changes more
    -- often than the GC is executed, they are doing it wrong.
    target:finish()

end

local mutex = false

-- Uploading the surface to X11 is *very* resource intensive. Given the updates
-- will often happen in batch (like startup), make sure to only do one "real"
-- update.
local function update()
    if mutex then return end

    mutex = true

    gtimer.delayed_call(function()
        -- Remove the mutex first in case `paint()` raises an exception.
        mutex = false
        paint()
    end)
end

capi.screen.connect_signal("removed", function(s)
    if not backgrounds[s] then return end

    backgrounds[s]:remove_screen(s)

    update()
end)

capi.screen.connect_signal("property::geometry", function(s)
    if not backgrounds[s] then return end

    backgrounds[s]:repaint()
end)


--- The wallpaper widget.
--
-- When set, instead of using the `image_path` or `surface` properties, the
-- wallpaper will be defined as a normal `wibox` widget tree.
--
-- @property widget
-- @tparam[opt=nil] widget|nil widget
-- @see wibox.widget.imagebox
-- @see wibox.container.tile

--- The wallpaper DPI (dots per inch).
--
-- Each screen has a DPI. This value will be used by default, but sometime it
-- is useful to override the screen DPI and use a custom one. This makes
-- possible, for example, to draw the widgets bigger than they would otherwise
-- be.
--
-- If not DPI is defined, it will use the smallest DPI from any of the screen.
--
-- In this example, there is 3 screens with DPI of 100, 200 and 300. As you can
-- see, only the text size is affected. Many widgetds are DPI aware, but not all
-- of them. This is either because DPI isn't relevant to them or simply because it
-- isn't supported (like `wibox.widget.graph`).
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_dpi1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
--    for s in screen do
--        local dpi = s.index * 100
--          
--        awful.wallpaper {
--            screen = s,
--            dpi    = dpi,
--            widget = wibox.widget {
--                text   = &#34DPI: &#34 .. dpi,
--                valign = &#34center&#34,
--                halign = &#34center&#34,
--                widget = wibox.widget.textbox,
--         }
--    end
--
-- @property dpi
-- @tparam[opt=self.screen.dpi] number dpi
-- @propertyunit pixel\_per\_inch
-- @negativeallowed false
-- @see screen
-- @see screen.dpi

--- The wallpaper screen.
--
-- Note that there can only be one wallpaper per screen. If there is more, one
-- will be chosen and all other ignored.
--
-- @property screen
-- @tparam screen screen
-- @propertydefault Obtained from the constructor.
-- @see screens
-- @see add_screen
-- @see remove_screen

--- A list of screen for this wallpaper.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_screens1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
--    -- There is 3 screens. This will add the wallpaper to the last 2.
--    awful.wallpaper {
--        screens = {
--            screen[2],
--            screen[3],
--        },
--        bg      = &#34#222222&#34,
--        widget  = wibox.widget {
--            {
--                fit = function(_, width, height)
--                    return width, height
--                end,
--                draw = function(_, _, cr, width, height)
--                    cr:set_source(gears.color(&#34#0000ff&#34))
--                    cr:line_to(width, height)
--                    cr:line_to(width, 0)
--                    cr:line_to(0, 0)
--                    cr:close_path()
--                    cr:fill()
--                    cr:set_source(gears.color(&#34#ff00ff&#34))
--                    cr:move_to(0, 0)
--                    cr:line_to(0, height)
--                    cr:line_to(width, height)
--                    cr:close_path()
--                    cr:fill()
--                end,
--                widget = wibox.widget.base.make_widget()
--            },
--            {
--                text   = &#34Center&#34,
--                valign = &#34center&#34,
--                halign = &#34center&#34,
--                widget = wibox.widget.textbox,
--            },
--            widget = wibox.layout.stack
--        }
--    }
--
-- Some large wallpaper are made to span multiple screens.
-- @property screens
-- @tparam[opt={self.screen}] table screens
-- @tablerowtype A list of `screen` objects.
-- @see screen
-- @see add_screen
-- @see remove_screen
-- @see detach

--- The background color.
--
-- It will be used as the "fill" color if the `image` doesn't take all the
-- screen space. It will also be the default background for the `widget`.
--
-- As usual with colors in `AwesomeWM`, it can also be a gradient or a pattern.
--
-- @property bg
-- @tparam[opt=beautiful.wallpaper_bg] color bg
-- @usebeautiful beautiful.wallpaper_bg
-- @see gears.color

--- The foreground color.
--
-- This will be used by the `widget` (if any).
--
-- As usual with colors in `AwesomeWM`, it can also be a gradient or a pattern.
--
-- @property fg
-- @tparam[opt=beautiful.wallpaper_fg] color fg
-- @see gears.color

--- The default wallpaper background color.
-- @beautiful beautiful.wallpaper_bg
-- @tparam color wallpaper_bg
-- @usebeautiful beautiful.wallpaper_fg
-- @see bg

--- The default wallpaper foreground color.
--
-- This is useful when using widgets or text in the wallpaper. A wallpaper
-- created from a single image wont use this.
--
-- @beautiful beautiful.wallpaper_fg
-- @tparam gears.color wallpaper_fg
-- @see bg

--- Honor the workarea.
--
-- When set to `true`, the wallpaper will only fill the workarea space instead
-- of the entire screen. This means it wont be drawn below the `awful.wibar` or
-- docked clients. This is useful when using opaque bars. Note that it can cause
-- aspect ratio issues for the wallpaper `image` and add bars colored with the
-- `bg` color on the sides.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_workarea1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
--
-- @property honor_workarea
-- @tparam[opt=false] boolean honor_workarea
-- @see honor_padding
-- @see uncovered_areas

--- Honor the screen padding.
--
-- When set, this will look at the `screen.padding` property to restrict the
-- area where the wallpaper is rendered.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_padding1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
--**Usage example output**:
--
--    Uncovered area:	0	0	30	196
--    Uncovered area:	0	0	320	14
--    Uncovered area:	310	0	10	196
--
--
-- @usage
--    -- Add some padding to the first screen.
--    screen[1].padding = {
--        left  = 30,
--        right = 10,
--    }
--     
--    local wall = awful.wallpaper {
--        screen                = screen[1],
--        honor_workarea        = true,
--        honor_padding         = true,
--        bg                    = &#34#222222&#34,
--        uncovered_areas_color = &#34#ff0000&#34,
--        widget =  wibox.widget {
--            fit = function(_, width, height)
--                return width, height
--            end,
--            draw = function(_, _, cr, width, height)
--                local radius = math.min(width, height)/2
--                cr:arc(width/2, height/2, radius, 0, 2 * math.pi)
--                cr:set_source(gears.color {
--                    type = &#34radial&#34,
--                    from  = { width/2, radius, 20  },
--                    to    = { width/2, radius, 120 },
--                    stops = {
--                        { 0, &#34#0000ff&#34 },
--                        { 1, &#34#ff0000&#34 },
--                        { 1, &#34#000000&#34 },
--                    }
--                })
--                cr:fill()
--            end,
--            widget = wibox.widget.base.make_widget()
--        }
--    }
--  
--    -- Areas due to the padding and the wibar (workarea).
--    for _, area in ipairs(wall.uncovered_areas) do
--       print(&#34Uncovered area:&#34, area.x, area.y, area.width, area.height)
--    end
--
-- @property honor_padding
-- @tparam[opt=false] boolean honor_padding
-- @see honor_workarea
-- @see uncovered_areas

--- Returns the list of screen(s) area which won't be covered by the wallpaper.
--
-- When `honor_workarea`, `honor_padding` or panning are used, some section of
-- the screen won't have a wallpaper.
--
-- @property uncovered_areas
-- @tparam table uncovered_areas
-- @propertydefault This depends on the `honor_workarea` and `honor_padding` values.
-- @tablerowtype A list of area tables with the following keys:
-- @tablerowkey number x
-- @tablerowkey number y
-- @tablerowkey number width
-- @tablerowkey number height
-- @see honor_workarea
-- @see honor_padding
-- @see uncovered_areas_color

--- The color for the uncovered areas.
--
-- Some application rely on the wallpaper for "fake" transparency. Even if an
-- area is hidden under a wibar (or other clients), its background can still
-- become visible. If you use such application and change your screen geometry
-- often enough, it is possible some areas would become filled with the remains
-- of previous wallpapers. This property allows to clean those areas with a solid
-- color or a gradient.
--
-- @property uncovered_areas_color
-- @tparam[opt="transparent"] color uncovered_areas_color
-- @see uncovered_areas

--- Defines where the wallpaper is placed when there is multiple screens.
--
-- When there is more than 1 screen, it is possible they don't have the same
-- resolution, position or orientation. Panning the wallpaper over them may look
-- better if a continuous rectangle is used rather than creating a virtual rectangle
-- around all screens.
--
-- The default algorithms are:
--
-- **outer:** *(default)*
--
-- Draw an imaginary rectangle around all screens.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_panning_outer.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
--
-- **inner:**
--
-- Take the largest area or either `inner_horizontal` or `inner_vertical`.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_panning_inner.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
--
-- **inner_horizontal:**
--
-- Take the smallest `x` value, the largest `x+width`, the smallest `y`
-- and the smallest `y+height`.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_panning_inner_horizontal.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
--
-- **inner_vertical:**
--
-- Take the smallest `y` value, the largest `y+height`, the smallest `x`
-- and the smallest `x+width`.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_panning_inner_vertical.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
--
-- **Custom function:**
--
-- It is also possible to define a custom function.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_panning_custom.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
--**Usage example output**:
--
-- **Usage example:**
--
--
-- 
--    local function custom_panning_area(wallpaper)
--         return {
--             x      = wallpaper.screens[1].geometry.x + 50,
--             y      = wallpaper.screens[2].geometry.y + 50,
--             width  = 96,
--             height = 96,
--         }
--    end
--  
--    -- Areas due to the padding and the wibar (workarea).
--    for k, wall in ipairs(walls) do
--        for _, area in ipairs(wall.uncovered_areas) do
--             print(&#34Uncovered wallpaper #&#34.. k ..&#34 area:&#34, area.x, area.y, area.width, area.height)
--        end
--    end
--
-- @property panning_area
-- @tparam[opt="outer"] function|string panning_area
-- @propertytype string A panning algorithm
-- @propertyvalue "outer"
-- @propertyvalue "inner"
-- @propertyvalue "inner_horizontal"
-- @propertyvalue "inner_vertical"
-- @propertytype function Custom panning function.
-- @functionparam awful.wallpaper wallpaper The wallpaper object.
-- @functionreturn A table with `x`, `y`, `width` and `height` keys,
-- @see uncovered_areas

function module:set_panning_area(value)
    value = value or "outer"

    assert(type(value) == "function" or panning_modes[value], "Invalid panning mode: "..tostring(value))

    self._private.panning_area = value

    self:repaint()

    self:emit_signal("property::panning_area", value)
end

function module:set_widget(w)
    self._private.widget = base.make_widget_from_value(w)

    if self._private.container then
        self._private.container.widget = self._private.widget
    end

    self:repaint()
end

function module:get_widget()
    return self._private.widget
end

function module:set_dpi(dpi)
    self._private.context.dpi = dpi
    self:repaint()
end

function module:get_dpi()
    return self._private.context.dpi
end

function module:set_screen(s)
    if not s then return end

    self:_clear()
    self:add_screen(s)
end

for _, prop in ipairs {"bg", "fg"} do
    module["set_"..prop] = function(self, color)
        if self._private.container then
            self._private.container[prop] = color
        end

        self._private[prop] = color

        self:repaint()
    end
end

function module:get_uncovered_areas()
    local geo = type(self._private.panning_area) == "function" and
        self._private.panning_area(self) or
        panning_modes[self._private.panning_area](self)

    return grect.area_remove(get_rectangles(self.screens, false, false), geo)
end

function module:set_screens(screens)
    local to_rem = {}

    -- All screens.
    -- The copy is needed because it's a metatable, `ipairs` doesn't work
    -- correctly in all Lua versions.
    if screens == capi.screen then
        screens = {}

        for s in capi.screen do
            table.insert(screens, s)
        end
    end

    for _, s in ipairs(screens) do
        to_rem[get_screen(s)] = true
    end

    for _, s in ipairs(self.screens) do
        to_rem[get_screen(s)] = nil
    end

    for _, s in ipairs(screens) do
        s = get_screen(s)
        self:add_screen(s)
        to_rem[s] = nil
    end

    for s, remove in pairs(to_rem) do
        if remove then
            self:remove_screen(s)
        end
    end
end

function module:get_screens()
    return self._private.screens
end

--- Add another screen (enable panning).
--
-- **Before:**
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_add_screen1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
--
-- **After:**
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_add_screen2.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
--
-- Also note that adding a non-continuous screen might not work well,
-- but will not automatically add the screens in between:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_add_screen3.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
--
-- @method add_screen
-- @tparam screen screen The screen object.
-- @noreturn
-- @see remove_screen
function module:add_screen(s)
    s = get_screen(s)

    for _, s2 in ipairs(self._private.screens) do
        if s == s2 then return end
    end

    table.insert(self._private.screens, s)

    if backgrounds[s] and backgrounds[s] ~= self then
        backgrounds[s]:remove_screen(s)
    end

    backgrounds[s] = self

    self:repaint()
end

--- Detach the wallpaper from all screens.
--
-- Adding a new wallpaper to a screen will automatically
-- detach the older one. However there is some case when
-- it is useful to call this manually. For example, when
-- adding a new panned wallpaper, it is possible that 2
-- wallpaper will have an overlap.
--
-- @method detach
-- @noreturn
-- @see remove_screen
-- @see add_screen
function module:detach()
    local screens = gtable.clone(self.screens)

    for _, s in ipairs(screens) do
        self:remove_screen(s)
    end
end

function module:_clear()
    self._private.screens = setmetatable({}, {__mode = "v"})
    update()
end

--- Repaint the wallpaper.
--
-- By default, even if the widget changes, the wallpaper will **NOT** be
-- automatically repainted. Repainting the native X11 wallpaper is slow and
-- it would be too easy to accidentally cause a performance problem. If you
-- really need to repaint the wallpaper, call this method.
--
-- @method repaint
-- @noreturn
function module:repaint()
    for _, s in ipairs(self._private.screens) do
        pending_repaint[s] = true
    end

    update()
end

--- Remove a screen.
--
-- Calling this will remove a screen, but will **not** repaint its area.
-- In this example, the wallpaper was spanning all 3 screens and the
-- first screen was removed:
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_remove_screen1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    wall:remove_screen(screen[1])
--
-- As you can see, the content of screen 1 still looks like it is part of
-- the 3 screen wallpaper. The only use case for calling this method is if
-- you use a 3rd party tools to change the wallpaper.
--
-- If you wish to simply remove a screen and not have leftover content, it is
-- simpler to just create a new wallpaper for that screen:
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_awful_wallpaper_remove_screen2.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    awful.wallpaper {
--        screen = screen[1],
--        bg     = &#34#00ffff&#34,
--    }
--
-- @method remove_screen
-- @tparam screen screen The screen to remove.
-- @treturn boolean `true` if the screen was removed and `false` if the screen
--  wasn't found.
-- @see detach
-- @see add_screen
-- @see screens
function module:remove_screen(s)
    local ret =  false

    s = get_screen(s)

    for k, s2 in ipairs(self._private.screens) do
        if s == s2 then
            table.remove(self._private.screens, k)
            ret = true
        end
    end

    backgrounds[s] = nil

    self:repaint()

    return ret
end

--- Create a wallpaper.
--
-- Note that all parameters are not required. Please refer to the
-- module description and examples to understand parameters usages.
--
-- @constructorfct awful.wallpaper
-- @tparam table args
-- @tparam[opt] wibox.widget args.widget The wallpaper widget.
-- @tparam[opt] number args.dpi The wallpaper DPI (dots per inch).
-- @tparam[opt] screen args.screen The wallpaper screen.
-- @tparam[opt] table args.screens A list of screen for this wallpaper.
--  Use this parameter as a remplacement for `args.screen` to manage multiscreen wallpaper.
--  (Note: the expected table should be an array-like table `{screen1, screen2, ...}`)
-- @tparam[opt] gears.color args.bg The background color.
-- @tparam[opt] gears.color args.fg The foreground color.
-- @tparam[opt] gears.color args.uncovered_areas_color The color for the uncovered areas.
-- @tparam[opt] boolean args.honor_workarea Honor the workarea.
-- @tparam[opt] boolean args.honor_padding Honor the screen padding.
-- @tparam[opt] table args.uncovered_areas Returns the list of screen(s) area which won't be covered by the wallpaper.
-- @tparam[opt] function|string args.panning_area Defines where the wallpaper is placed when there is multiple screens.

local function new(_, args)
    args = args or {}
    local ret = gobject {
        enable_auto_signals = true,
        enable_properties   = true,
    }

    rawset(ret, "_private", {})
    ret._private.context      = {}
    ret._private.panning_area = "outer"

    gtable.crush(ret, module, true)

    ret:_clear()

    -- Set the screen or screens first to avoid a race condition
    -- with the other setters.
    local args_screen, args_screens = args.screen, args.screens
    if args_screen then
        ret.screen = args_screen
    elseif args_screens then
        ret.screens = args_screens
    end

    -- Avoid crushing `screen` and `screens` twice.
    args.screen, args.screens = nil, nil
    gtable.crush(ret, args, false)
    args.screen, args.screens = args_screen, args_screens

    return ret
end

return setmetatable(module, {__call = new})
