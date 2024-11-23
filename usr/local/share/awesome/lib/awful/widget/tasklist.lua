---------------------------------------------------------------------------
--- Tasklist widget module for awful.
--
-- <a name="status_icons"></a>
-- **Status icons:**
--
-- By default, the tasklist prepends some symbols in front of the client name.
-- This is used to notify that the client has some specific properties that are
-- currently enabled. This can be disabled using
-- `beautiful.tasklist_plain_task_name`=true in the theme.
--
-- <table class='widget_list' border=1>
-- <tr style='font-weight: bold;'>
--  <th align='center'>Icon</th>
--  <th align='center'>Client property</th>
-- </tr>
-- <tr><td>▪</td><td><a href="../core_components/client.html#sticky">sticky</a></td></tr>
-- <tr><td>⌃</td><td><a href="../core_components/client.html#ontop">ontop</a></td></tr>
-- <tr><td>▴</td><td><a href="../core_components/client.html#above">above</a></td></tr>
-- <tr><td>▾</td><td><a href="../core_components/client.html#below">below</a></td></tr>
-- <tr><td>✈</td><td><a href="../core_components/client.html#floating">floating</a></td></tr>
-- <tr><td>+</td><td><a href="../core_components/client.html#maximized">maximized</a></td></tr>
-- <tr><td>⬌</td><td><a href="../core_components/client.html#maximized_horizontal">maximized_horizontal</a></td></tr>
-- <tr><td>⬍</td><td><a href="../core_components/client.html#maximized_vertical">maximized_vertical</a></td></tr>
-- </table>
--
-- **Customizing the tasklist:**
--
-- The `tasklist` created by `rc.lua` uses the default values for almost
-- everything. However, it is possible to override each aspect to create a
-- very different widget. Here's an example that creates a tasklist similar to
-- the default one, but with an explicit layout and some spacing widgets:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_rounded.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     s.mytasklist = awful.widget.tasklist {
--         screen   = s,
--         filter   = awful.widget.tasklist.filter.currenttags,
--         buttons  = tasklist_buttons,
--         style    = {
--             border_width = 1,
--             border_color = &#34#777777&#34,
--             shape        = gears.shape.rounded_bar,
--         },
--         layout   = {
--             spacing = 10,
--             spacing_widget = {
--                 {
--                     forced_width = 5,
--                     shape        = gears.shape.circle,
--                     widget       = wibox.widget.separator
--                 },
--                 valign = &#34center&#34,
--                 halign = &#34center&#34,
--                 widget = wibox.container.place,
--             },
--             layout  = wibox.layout.flex.horizontal
--         },
--         -- Notice that there is *NO* `wibox.wibox` prefix, it is a template,
--         -- not a widget instance.
--         widget_template = {
--             {
--                 {
--                     {
--                         {
--                             id     = &#34icon_role&#34,
--                             widget = wibox.widget.imagebox,
--                         },
--                         margins = 2,
--                         widget  = wibox.container.margin,
--                     },
--                     {
--                         id     = &#34text_role&#34,
--                         widget = wibox.widget.textbox,
--                     },
--                     layout = wibox.layout.fixed.horizontal,
--                 },
--                 left  = 10,
--                 right = 10,
--                 widget = wibox.container.margin
--             },
--             id     = &#34background_role&#34,
--             widget = wibox.container.background,
--         },
--     }
--
-- As demonstrated in the example above, there are a few "shortcuts" to avoid
-- re-inventing the wheel. By setting the predefined roles as widget `id`s,
-- `awful.widget.common` will do most of the work to update the values
-- automatically. All of them are optional. The supported roles are:
--
-- * `icon_role`: A `wibox.widget.imagebox`
-- * `text_role`: A `wibox.widget.textbox`
-- * `background_role`: A `wibox.container.background`
-- * `text_margin_role`: A `wibox.container.margin`
-- * `icon_margin_role`: A `wibox.container.margin`
--
-- `awful.widget.common` also has 2 callbacks to give more control over the widget:
--
-- * `create_callback`: Called once after the widget instance is created
-- * `update_callback`: Called every time the data is refreshed
--
-- Both callback have the same parameters:
--
-- * `self`: The widget instance (*widget*).
-- * `c`: The client (*client*)
-- * `index`: The widget position in the list (*number*)
-- * `clients`: The list of client, in order (*table*)
--
-- It is also possible to omit some roles and create an icon only tasklist.
-- Notice that this example use the `awful.widget.clienticon` widget instead
-- of an `imagebox`. This allows higher resolution icons to be loaded. This
-- example reproduces the Windows 10 tasklist look and feel:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_windows10.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     s.mytasklist = awful.widget.tasklist {
--         screen   = s,
--         filter   = awful.widget.tasklist.filter.currenttags,
--         buttons  = tasklist_buttons,
--         layout   = {
--             spacing_widget = {
--                 {
--                     forced_width  = 5,
--                     forced_height = 24,
--                     thickness     = 1,
--                     color         = &#34#777777&#34,
--                     widget        = wibox.widget.separator
--                 },
--                 valign = &#34center&#34,
--                 halign = &#34center&#34,
--                 widget = wibox.container.place,
--             },
--             spacing = 1,
--             layout  = wibox.layout.fixed.horizontal
--         },
--         -- Notice that there is *NO* `wibox.wibox` prefix, it is a template,
--         -- not a widget instance.
--         widget_template = {
--             {
--                 wibox.widget.base.make_widget(),
--                 forced_height = 5,
--                 id            = &#34background_role&#34,
--                 widget        = wibox.container.background,
--             },
--             {
--                 awful.widget.clienticon,
--                 margins = 5,
--                 widget  = wibox.container.margin
--             },
--             nil,
--             layout = wibox.layout.align.vertical,
--         },
--     }
--
-- The tasklist can also be created in an `awful.popup` in case there is no
-- permanent `awful.wibar`:
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
-- @author Julien Danjou &lt;julien@danjou.info&gt;
-- @copyright 2008-2009 Julien Danjou
-- @widgetmod awful.widget.tasklist
-- @supermodule wibox.widget.base
---------------------------------------------------------------------------

-- Grab environment we need
local capi = { screen = screen,
               client = client }
local ipairs = ipairs
local setmetatable = setmetatable
local table = table
local common = require("awful.widget.common")
local beautiful = require("beautiful")
local tag = require("awful.tag")
local flex = require("wibox.layout.flex")
local timer = require("gears.timer")
local gcolor = require("gears.color")
local gstring = require("gears.string")
local gdebug = require("gears.debug")
local dpi = require("beautiful").xresources.apply_dpi
local base = require("wibox.widget.base")
local wfixed = require("wibox.layout.fixed")
local wmargin = require("wibox.container.margin")
local wtextbox = require("wibox.widget.textbox")
local clienticon = require("awful.widget.clienticon")
local wbackground = require("wibox.container.background")
local gtable = require("gears.table")

local function get_screen(s)
    return s and screen[s]
end

local tasklist = { mt = {} }

local instances

--- The default foreground (text) color.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_fg_normal.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, col in ipairs { &#34#ff0000&#34, &#34#00ff00&#34, &#34#0000ff&#34 } do
--     beautiful.tasklist_fg_normal = col
-- end
--
-- @beautiful beautiful.tasklist_fg_normal
-- @tparam[opt=nil] string|pattern fg_normal
-- @see gears.color

--- The default background color.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_bg_normal.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- local grad = gears.color {
--     type  = &#34linear&#34,
--     from  = { 0, 0 },
--     to    = { 0, 22 },
--     stops = {
--         { 0, &#34#ff0000&#34 },
--         { 1, &#34#0000ff&#34 },
--     }
-- }
--  
-- for _, col in ipairs { &#34#ff0000&#34, &#34#00ff00&#34, &#34#0000ff&#34, grad } do
--     beautiful.tasklist_bg_normal = col
-- end
--
-- @beautiful beautiful.tasklist_bg_normal
-- @tparam[opt=nil] string|pattern bg_normal
-- @see gears.color

--- The focused client foreground (text) color.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_fg_focus.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, col in ipairs { &#34#ff0000&#34, &#34#00ff00&#34, &#34#0000ff&#34 } do
--     beautiful.tasklist_fg_focus = col
-- end
--
-- @beautiful beautiful.tasklist_fg_focus
-- @tparam[opt=nil] string|pattern fg_focus
-- @see gears.color

--- The focused client background color.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_bg_focus.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- local grad = gears.color {
--     type  = &#34linear&#34,
--     from  = { 0, 0 },
--     to    = { 0, 22 },
--     stops = {
--         { 0, &#34#ff0000&#34 },
--         { 1, &#34#0000ff&#34 },
--     }
-- }
--  
-- for _, col in ipairs { &#34#ff0000&#34, &#34#00ff00&#34, &#34#0000ff&#34, grad } do
--     beautiful.tasklist_bg_focus = col
-- end
--
-- @beautiful beautiful.tasklist_bg_focus
-- @tparam[opt=nil] string|pattern bg_focus
-- @see gears.color

--- The urgent clients foreground (text) color.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_fg_urgent.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, col in ipairs { &#34#ff0000&#34, &#34#00ff00&#34, &#34#0000ff&#34 } do
--     beautiful.tasklist_fg_urgent = col
-- end
--
-- @beautiful beautiful.tasklist_fg_urgent
-- @tparam[opt=nil] string|pattern fg_urgent
-- @see gears.color

--- The urgent clients background color.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_bg_urgent.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- local grad = gears.color {
--     type  = &#34linear&#34,
--     from  = { 0, 0 },
--     to    = { 0, 22 },
--     stops = {
--         { 0, &#34#ff0000&#34 },
--         { 1, &#34#0000ff&#34 },
--     }
-- }
--  
-- for _, col in ipairs { &#34#ff0000&#34, &#34#00ff00&#34, &#34#0000ff&#34, grad } do
--     beautiful.tasklist_bg_urgent = col
-- end
--
-- @beautiful beautiful.tasklist_bg_urgent
-- @tparam[opt=nil] string|pattern bg_urgent
-- @see gears.color

--- The minimized clients foreground (text) color.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_fg_minimize.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, col in ipairs { &#34#ff0000&#34, &#34#00ff00&#34, &#34#0000ff&#34 } do
--     beautiful.tasklist_fg_minimize = col
-- end
--
-- @beautiful beautiful.tasklist_fg_minimize
-- @tparam[opt=nil] string|pattern fg_minimize
-- @see gears.color

--- The minimized clients background color.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_bg_minimize.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- local grad = gears.color {
--     type  = &#34linear&#34,
--     from  = { 0, 0 },
--     to    = { 0, 22 },
--     stops = {
--         { 0, &#34#ff0000&#34 },
--         { 1, &#34#0000ff&#34 },
--     }
-- }
--  
-- for _, col in ipairs { &#34#ff0000&#34, &#34#00ff00&#34, &#34#0000ff&#34, grad } do
--     beautiful.tasklist_bg_minimize = col
-- end
--
-- @beautiful beautiful.tasklist_bg_minimize
-- @tparam[opt=nil] string|pattern bg_minimize
-- @see gears.color

--- The elements default background image.
-- @beautiful beautiful.tasklist_bg_image_normal
-- @tparam[opt=nil] string bg_image_normal

--- The focused client background image.
-- @beautiful beautiful.tasklist_bg_image_focus
-- @tparam[opt=nil] string bg_image_focus

--- The urgent clients background image.
-- @beautiful beautiful.tasklist_bg_image_urgent
-- @tparam[opt=nil] string bg_image_urgent

--- The minimized clients background image.
-- @beautiful beautiful.tasklist_bg_image_minimize
-- @tparam[opt=nil] string bg_image_minimize

--- Disable the tasklist client icons.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_disable_icon.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, value in ipairs { true, false } do
--     beautiful.tasklist_disable_icon = value
-- end
--
-- @beautiful beautiful.tasklist_disable_icon
-- @tparam[opt=false] boolean tasklist_disable_icon

--- Disable the tasklist client titles.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_disable_task_name.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, value in ipairs { true, false } do
--     beautiful.tasklist_disable_task_name = value
-- end
--
-- @beautiful beautiful.tasklist_disable_task_name
-- @tparam[opt=false] boolean tasklist_disable_task_name

--- Disable the extra tasklist client property notification icons.
--
-- See the <a href="#status_icons">Status icons</a> section for more details.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_plain_task_name.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, value in ipairs { true, false } do
--     beautiful.tasklist_plain_task_name = value
-- end
--
-- @beautiful beautiful.tasklist_plain_task_name
-- @tparam[opt=false] boolean tasklist_plain_task_name

--- Extra tasklist client property notification icon for clients with the sticky property set.
-- @beautiful beautiful.tasklist_sticky
-- @tparam[opt=nil] string tasklist_sticky

--- Extra tasklist client property notification icon for clients with the ontop property set.
-- @beautiful beautiful.tasklist_ontop
-- @tparam[opt=nil] string tasklist_ontop

--- Extra tasklist client property notification icon for clients with the above property set.
-- @beautiful beautiful.tasklist_above
-- @tparam[opt=nil] string tasklist_above

--- Extra tasklist client property notification icon for clients with the below property set.
-- @beautiful beautiful.tasklist_below
-- @tparam[opt=nil] string tasklist_below

--- Extra tasklist client property notification icon for clients with the floating property set.
-- @beautiful beautiful.tasklist_floating
-- @tparam[opt=nil] string tasklist_floating

--- Extra tasklist client property notification icon for clients with the maximized property set.
-- @beautiful beautiful.tasklist_maximized
-- @tparam[opt=nil] string tasklist_maximized

--- Extra tasklist client property notification icon for clients with the maximized_horizontal property set.
-- @beautiful beautiful.tasklist_maximized_horizontal
-- @tparam[opt=nil] string maximized_horizontal

--- Extra tasklist client property notification icon for clients with the maximized_vertical property set.
-- @beautiful beautiful.tasklist_maximized_vertical
-- @tparam[opt=nil] string maximized_vertical

--- Extra tasklist client property notification icon for clients with the minimized property set.
-- @beautiful beautiful.tasklist_minimized
-- @tparam[opt=nil] string minimized

--- The focused client alignment.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_align.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, value in ipairs { &#34left&#34, &#34center&#34, &#34right&#34 } do
--     beautiful.tasklist_align = value
-- end
--
-- @beautiful beautiful.tasklist_align
-- @tparam[opt="left"] string align *left*, *right* or *center*

--- The tasklist font.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_font.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, font in ipairs { &#34sans 8&#34, &#34sans 10 bold&#34, &#34sans 12 italic&#34 } do
--     beautiful.tasklist_font = font
-- end
--
-- @beautiful beautiful.tasklist_font
-- @tparam[opt=nil] string font
-- @see wibox.widget.textbox.font

--- The focused client title alignment.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_font_focus.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, font in ipairs { &#34sans 8&#34, &#34sans 10 bold&#34, &#34sans 12 italic&#34 } do
--     beautiful.tasklist_font_focus = font
-- end
--
-- @beautiful beautiful.tasklist_font_focus
-- @tparam[opt=nil] string font_focus
-- @see wibox.widget.textbox.font

--- The minimized clients font.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_font_minimized.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, font in ipairs { &#34sans 8&#34, &#34sans 10 bold&#34, &#34sans 12 italic&#34 } do
--     beautiful.tasklist_font_minimized = font
-- end
--
-- @beautiful beautiful.tasklist_font_minimized
-- @tparam[opt=nil] string font_minimized
-- @see wibox.widget.textbox.font

--- The urgent clients font.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_font_urgent.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, font in ipairs { &#34sans 8&#34, &#34sans 10 bold&#34, &#34sans 12 italic&#34 } do
--     beautiful.tasklist_font_urgent = font
-- end
--
-- @beautiful beautiful.tasklist_font_urgent
-- @tparam[opt=nil] string font_urgent
-- @see wibox.widget.textbox.font

--- The space between the tasklist elements.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_spacing.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- for _, spacing in ipairs { 0, 4, 8, 12 } do
--     beautiful.tasklist_spacing = spacing
-- end
--
-- @beautiful beautiful.tasklist_spacing
-- @tparam[opt=0] number spacing The spacing between tasks.

--- The default tasklist elements shape.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_shape.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- beautiful.tasklist_spacing = 5
--  
-- local function customized(cr, width, height)
--     return gears.shape.parallelogram(cr, width, height, width - height)
-- end
--  
-- for _, shape in ipairs { gears.shape.rounded_rect, gears.shape.octogon, gears.shape.hexagon, customized } do
--     beautiful.tasklist_shape = shape
-- end
--
-- @beautiful beautiful.tasklist_shape
-- @tparam[opt=nil] gears.shape shape

--- The default tasklist elements border width.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_shape_border_width.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- beautiful.tasklist_spacing = 5
-- beautiful.tasklist_shape = gears.shape.rounded_rect
--  
-- for _, bw in ipairs { 0, 2, 4, 6 } do
--     beautiful.tasklist_shape_border_width = bw
-- end
--
-- @beautiful beautiful.tasklist_shape_border_width
-- @tparam[opt=0] number shape_border_width

--- The default tasklist elements border color.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_shape_border_color.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- beautiful.tasklist_spacing = 5
-- beautiful.tasklist_shape = gears.shape.rounded_rect
-- beautiful.tasklist_shape_border_width = 2
--  
-- local grad = gears.color {
--     type  = &#34linear&#34,
--     from  = { 0, 0 },
--     to    = { 0, 22 },
--     stops = {
--         { 0, &#34#ff0000&#34 },
--         { 1, &#34#0000ff&#34 },
--     }
-- }
--  
-- for _, col in ipairs { &#34#ff0000&#34, &#34#00ff00&#34, &#34#0000ff&#34, grad } do
--     beautiful.tasklist_shape_border_color = col
-- end
--
-- @beautiful beautiful.tasklist_shape_border_color
-- @tparam[opt=nil] string|color shape_border_color
-- @see gears.color

--- The focused client shape.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_shape_focus.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- beautiful.tasklist_spacing = 5
--  
-- local function customized(cr, width, height)
--     return gears.shape.parallelogram(cr, width, height, width - height)
-- end
--  
-- for _, shape in ipairs { gears.shape.rounded_rect, gears.shape.octogon, gears.shape.hexagon, customized } do
--     beautiful.tasklist_shape_focus = shape
-- end
--
-- @beautiful beautiful.tasklist_shape_focus
-- @tparam[opt=nil] gears.shape shape_focus

--- The focused client border width.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_shape_focus_border_width.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- beautiful.tasklist_spacing = 5
-- beautiful.tasklist_shape = gears.shape.rounded_rect
--  
-- for _, bw in ipairs { 0, 2, 4, 6 } do
--     beautiful.tasklist_shape_border_width_focus = bw
-- end
--
-- @beautiful beautiful.tasklist_shape_border_width_focus
-- @tparam[opt=0] number shape_border_width_focus

--- The focused client border color.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_shape_focus_border_width_focus.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- beautiful.tasklist_spacing = 5
-- beautiful.tasklist_shape = gears.shape.rounded_rect
-- beautiful.tasklist_shape_border_width = 2
--  
-- local grad = gears.color {
--     type  = &#34linear&#34,
--     from  = { 0, 0 },
--     to    = { 0, 22 },
--     stops = {
--         { 0, &#34#ff0000&#34 },
--         { 1, &#34#0000ff&#34 },
--     }
-- }
--  
-- for _, col in ipairs { &#34#ff0000&#34, &#34#00ff00&#34, &#34#0000ff&#34, grad } do
--     beautiful.tasklist_shape_border_color_focus = col
-- end
--
-- @beautiful beautiful.tasklist_shape_border_color_focus
-- @tparam[opt=nil] string|color shape_border_color_focus
-- @see gears.color

--- The minimized clients shape.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_shape_minimized.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- beautiful.tasklist_spacing = 5
--  
-- local function customized(cr, width, height)
--     return gears.shape.parallelogram(cr, width, height, width - height)
-- end
--  
-- for _, shape in ipairs { gears.shape.rounded_rect, gears.shape.octogon, gears.shape.hexagon, customized } do
--     beautiful.tasklist_shape_minimized = shape
-- end
--
-- @beautiful beautiful.tasklist_shape_minimized
-- @tparam[opt=nil] gears.shape shape_minimized

--- The minimized clients border width.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_shape_border_width_minimized.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- beautiful.tasklist_spacing = 5
-- beautiful.tasklist_shape = gears.shape.rounded_rect
--  
-- for _, bw in ipairs { 0, 2, 4, 6 } do
--     beautiful.tasklist_shape_border_width_minimized = bw
-- end
--
-- @beautiful beautiful.tasklist_shape_border_width_minimized
-- @tparam[opt=0] number shape_border_width_minimized

--- The minimized clients border color.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_shape_border_color_minimized.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- beautiful.tasklist_spacing = 5
-- beautiful.tasklist_shape = gears.shape.rounded_rect
-- beautiful.tasklist_shape_border_width = 2
--  
-- local grad = gears.color {
--     type  = &#34linear&#34,
--     from  = { 0, 0 },
--     to    = { 0, 22 },
--     stops = {
--         { 0, &#34#ff0000&#34 },
--         { 1, &#34#0000ff&#34 },
--     }
-- }
--  
-- for _, col in ipairs { &#34#ff0000&#34, &#34#00ff00&#34, &#34#0000ff&#34, grad } do
--     beautiful.tasklist_shape_border_color_minimized = col
-- end
--
-- @beautiful beautiful.tasklist_shape_border_color_minimized
-- @tparam[opt=nil] string|color shape_border_color_minimized
-- @see gears.color

--- The urgent clients shape.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_shape_urgent.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- beautiful.tasklist_spacing = 5
--  
-- local function customized(cr, width, height)
--     return gears.shape.parallelogram(cr, width, height, width - height)
-- end
--  
-- for _, shape in ipairs { gears.shape.rounded_rect, gears.shape.octogon, gears.shape.hexagon, customized } do
--     beautiful.tasklist_shape_focus = shape
-- end
--
-- @beautiful beautiful.tasklist_shape_urgent
-- @tparam[opt=nil] gears.shape shape_urgent

--- The urgent clients border width.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_shape_border_width_urgent.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- beautiful.tasklist_spacing = 5
-- beautiful.tasklist_shape = gears.shape.rounded_rect
--  
-- for _, bw in ipairs { 0, 2, 4, 6 } do
--     beautiful.tasklist_shape_border_width_urgent = bw
-- end
--
-- @beautiful beautiful.tasklist_shape_border_width_urgent
-- @tparam[opt=0] number shape_border_width_urgent

--- The urgent clients border color.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_awidget_tasklist_style_shape_border_color_urgent.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- @usage
-- beautiful.tasklist_spacing = 5
-- beautiful.tasklist_shape = gears.shape.rounded_rect
-- beautiful.tasklist_shape_border_width = 2
--  
-- local grad = gears.color {
--     type  = &#34linear&#34,
--     from  = { 0, 0 },
--     to    = { 0, 22 },
--     stops = {
--         { 0, &#34#ff0000&#34 },
--         { 1, &#34#0000ff&#34 },
--     }
-- }
--  
-- for _, col in ipairs { &#34#ff0000&#34, &#34#00ff00&#34, &#34#0000ff&#34, grad } do
--     beautiful.tasklist_shape_border_color_urgent = col
-- end
--
-- @beautiful beautiful.tasklist_shape_border_color_urgent
-- @tparam[opt=nil] string|color shape_border_color_urgent
-- @see gears.color

--- The icon size.
-- @beautiful beautiful.tasklist_icon_size
-- @tparam[opt=nil] integer tasklist_icon_size

-- Public structures
tasklist.filter, tasklist.source = {}, {}

-- This is the same template as awful.widget.common, but with an clienticon widget
local function default_template(self)
    local has_no_icon = self._private.style.disable_icon
        or self._private.style.tasklist_disable_icon
        or beautiful.tasklist_disable_icon

    return {
        {
            (not has_no_icon) and {
                clienticon,
                id     = "icon_margin_role",
                left   = dpi(4),
                widget = wmargin
            } or nil,
            {
                {
                    id     = "text_role",
                    widget = wtextbox,
                },
                id     = "text_margin_role",
                left   = dpi(4),
                right  = dpi(4),
                widget = wmargin
            },
            fill_space = true,
            layout     = wfixed.horizontal
        },
        id     = "background_role",
        widget = wbackground
    }
end

local function tasklist_label(c, args, tb)
    if not args then args = {} end
    local theme = beautiful.get()
    local align = args.align or theme.tasklist_align or "left"
    local fg_normal = gcolor.ensure_pango_color(args.fg_normal or theme.tasklist_fg_normal or theme.fg_normal, "white")
    local bg_normal = args.bg_normal or theme.tasklist_bg_normal or theme.bg_normal or "#000000"
    local fg_focus = gcolor.ensure_pango_color(args.fg_focus or theme.tasklist_fg_focus or theme.fg_focus, fg_normal)
    local bg_focus = args.bg_focus or theme.tasklist_bg_focus or theme.bg_focus or bg_normal
    local fg_urgent = gcolor.ensure_pango_color(args.fg_urgent or theme.tasklist_fg_urgent or theme.fg_urgent,
                                                fg_normal)
    local bg_urgent = args.bg_urgent or theme.tasklist_bg_urgent or theme.bg_urgent or bg_normal
    local fg_minimize = gcolor.ensure_pango_color(args.fg_minimize or theme.tasklist_fg_minimize or theme.fg_minimize,
                                                  fg_normal)
    local bg_minimize = args.bg_minimize or theme.tasklist_bg_minimize or theme.bg_minimize or bg_normal
    -- FIXME v5, remove the fallback theme.bg_image_* variables, see GH#1403
    local bg_image_normal = args.bg_image_normal or theme.tasklist_bg_image_normal or theme.bg_image_normal
    local bg_image_focus = args.bg_image_focus or theme.tasklist_bg_image_focus or theme.bg_image_focus
    local bg_image_urgent = args.bg_image_urgent or theme.tasklist_bg_image_urgent or theme.bg_image_urgent
    local bg_image_minimize = args.bg_image_minimize or theme.tasklist_bg_image_minimize or theme.bg_image_minimize
    local tasklist_disable_icon = args.disable_icon or args.tasklist_disable_icon
        or theme.tasklist_disable_icon or false
    local disable_task_name = args.disable_task_name or theme.tasklist_disable_task_name or false
    local font = args.font or theme.tasklist_font or theme.font
    local font_focus = args.font_focus or theme.tasklist_font_focus or theme.font_focus or font
    local font_minimized = args.font_minimized or theme.tasklist_font_minimized or theme.font_minimized or font
    local font_urgent = args.font_urgent or theme.tasklist_font_urgent or theme.font_urgent or font
    local text = ""
    local name = ""
    local bg
    local bg_image
    local shape              = args.shape or theme.tasklist_shape
    local shape_border_width = args.shape_border_width or theme.tasklist_shape_border_width
    local shape_border_color = args.shape_border_color or theme.tasklist_shape_border_color
    local icon_size = args.icon_size or theme.tasklist_icon_size

    -- symbol to use to indicate certain client properties
    local sticky = args.sticky or theme.tasklist_sticky or "▪"
    local ontop = args.ontop or theme.tasklist_ontop or '⌃'
    local above = args.above or theme.tasklist_above or '▴'
    local below = args.below or theme.tasklist_below or '▾'
    local floating = args.floating or theme.tasklist_floating or '✈'
    local maximized = args.maximized or theme.tasklist_maximized or '<b>+</b>'
    local maximized_horizontal = args.maximized_horizontal or theme.tasklist_maximized_horizontal or '⬌'
    local maximized_vertical = args.maximized_vertical or theme.tasklist_maximized_vertical or '⬍'
    local minimized = args.minimized or theme.tasklist_minimized or '<b>_</b>'

    if tb then
        tb:set_halign(align)
    end

    if not theme.tasklist_plain_task_name then
        if c.sticky then name = name .. sticky end

        if c.ontop then name = name .. ontop
        elseif c.above then name = name .. above
        elseif c.below then name = name .. below end

        if c.maximized then
            name = name .. maximized
        else
            if c.maximized_horizontal then name = name .. maximized_horizontal end
            if c.maximized_vertical then name = name .. maximized_vertical end
            if c.floating then name = name .. floating end
        end
        if c.minimized then name = name .. minimized end
    end

    if not disable_task_name then
        if c.minimized then
            name = name .. (gstring.xml_escape(c.icon_name) or gstring.xml_escape(c.name) or
                            gstring.xml_escape("<untitled>"))
        else
            name = name .. (gstring.xml_escape(c.name) or gstring.xml_escape("<untitled>"))
        end
    end

    local focused = c.active
    -- Handle transient_for: the first parent that does not skip the taskbar
    -- is considered to be focused, if the real client has skip_taskbar.
    if not focused and capi.client.focus and capi.client.focus.skip_taskbar
        and capi.client.focus:get_transient_for_matching(function(cl)
                                                             return not cl.skip_taskbar
                                                         end) == c then
        focused = true
    end

    if focused then
        bg = bg_focus
        text = text .. "<span color='"..fg_focus.."'>"..name.."</span>"
        bg_image = bg_image_focus
        font = font_focus

        if args.shape_focus or theme.tasklist_shape_focus then
            shape = args.shape_focus or theme.tasklist_shape_focus
        end

        if args.shape_border_width_focus or theme.tasklist_shape_border_width_focus then
            shape_border_width = args.shape_border_width_focus or theme.tasklist_shape_border_width_focus
        end

        if args.shape_border_color_focus or theme.tasklist_shape_border_color_focus then
            shape_border_color = args.shape_border_color_focus or theme.tasklist_shape_border_color_focus
        end
    elseif c.urgent then
        bg = bg_urgent
        text = text .. "<span color='"..fg_urgent.."'>"..name.."</span>"
        bg_image = bg_image_urgent
        font = font_urgent

        if args.shape_urgent or theme.tasklist_shape_urgent then
            shape = args.shape_urgent or theme.tasklist_shape_urgent
        end

        if args.shape_border_width_urgent or theme.tasklist_shape_border_width_urgent then
            shape_border_width = args.shape_border_width_urgent or theme.tasklist_shape_border_width_urgent
        end

        if args.shape_border_color_urgent or theme.tasklist_shape_border_color_urgent then
            shape_border_color = args.shape_border_color_urgent or theme.tasklist_shape_border_color_urgent
        end
    elseif c.minimized then
        bg = bg_minimize
        text = text .. "<span color='"..fg_minimize.."'>"..name.."</span>"
        bg_image = bg_image_minimize
        font = font_minimized

        if args.shape_minimized or theme.tasklist_shape_minimized then
            shape = args.shape_minimized or theme.tasklist_shape_minimized
        end

        if args.shape_border_width_minimized or theme.tasklist_shape_border_width_minimized then
            shape_border_width = args.shape_border_width_minimized or theme.tasklist_shape_border_width_minimized
        end

        if args.shape_border_color_minimized or theme.tasklist_shape_border_color_minimized then
            shape_border_color = args.shape_border_color_minimized or theme.tasklist_shape_border_color_minimized
        end
    else
        bg = bg_normal
        text = text .. "<span color='"..fg_normal.."'>"..name.."</span>"
        bg_image = bg_image_normal
    end

    if tb then
        tb:set_font(font)
    end

    local other_args = {
        shape              = shape,
        shape_border_width = shape_border_width,
        shape_border_color = shape_border_color,
        icon_size          = icon_size,
    }

    return text, bg, bg_image, not tasklist_disable_icon and c.icon or nil, other_args
end

-- Remove some callback boilerplate from the user provided templates.
local function create_callback(w, t)
    common._set_common_property(w, "client", t)
end

local function tasklist_update(s, self, buttons, filter, data, style, update_function, args)
    local clients = {}

    local source = self.source or tasklist.source.all_clients or nil
    local list   = source and source(s, args) or capi.client.get()

    for _, c in ipairs(list) do
        if not (c.skip_taskbar or c.hidden
            or c.type == "splash" or c.type == "dock" or c.type == "desktop")
            and filter(c, s) then
            table.insert(clients, c)
        end
    end

    if self._private.last_count ~= #clients then
        local old = self._private.last_count
        self._private.last_count = #clients
        self:emit_signal("property::count", #clients, old)
    end

    local function label(c, tb) return tasklist_label(c, style, tb) end

    update_function(self._private.base_layout, buttons, label, data, clients, {
        widget_template = self._private.widget_template or default_template(self),
        create_callback = create_callback,
    })
end

--- The current number of clients.
--
-- Note that the `tasklist` is usually lazy-loaded. Reading this property
-- may cause the widgets to be created. Depending on where the property is called
-- from, it might, in theory, cause an infinite loop.
--
-- @property count
-- @readonly
-- @tparam number count
-- @propertydefault The current number of client.
-- @negativeallowed false
-- @propemits true false

--- Set the tasklist layout.
--
-- This can be used to change the layout based on the number of clients:
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_sequences_client_tasklist_layout1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local tasklist = awful.widget.tasklist {
--         screen      = s,
--         filter      = awful.widget.tasklist.filter.currenttags,
--         base_layout = wibox.widget {
--             spacing = 2,
--             layout  = wibox.layout.fixed.horizontal,
--         },
--         buttons     = {
--             awful.button({ }, 1, function (c)
--                 c:activate {
--                     context = &#34tasklist&#34,
--                     action  = &#34toggle_minimization&#34
--                 }
--             end),
--             awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
--             awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
--             awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
--         },
--     }
--      
--     tasklist:connect_signal(&#34property::count&#34, function(self)
--         local count = self.count
--          
--         if count > 5 and not self.is_grid then
--             self.base_layout = wibox.widget {
--                 row_count   = 2,
--                 homogeneous = true,
--                 expand      = true,
--                 spacing     = 2,
--                 layout      = wibox.layout.grid.horizontal
--             }
--              
--             self.is_grid = true
--         elseif count <= 5 and self.is_grid then
--             self.base_layout = wibox.widget {
--                 spacing = 2,
--                 layout  = wibox.layout.fixed.horizontal
--             }
--              
--             self.is_grid = false
--         end
--     end)
--      
--     -- Spawn 5 clients.
--     for i=1, 5 do
--         awful.spawn(&#34Client #&#34..i)
--     end
--      
--     -- Spawn another client.
--     awful.spawn(&#34Client #6&#34)
--      
--     -- Kill 3 clients.
--     for _=1, 3 do
--         client.get()[1]:kill()
--     end
--
-- @property base_layout
-- @tparam[opt=wibox.layout.flex.horizontal] wibox.layout base_layout
-- @propemits true false
-- @see wibox.layout.flex.horizontal

--- The tasklist screen.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_sequences_client_tasklist_screen1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local tasklist = awful.widget.tasklist {
--         screen      = screen[1],
--         filter      = awful.widget.tasklist.filter.currenttags,
--         buttons     = {
--             awful.button({ }, 1, function (c)
--                 c:activate {
--                     context = &#34tasklist&#34,
--                     action  = &#34toggle_minimization&#34
--                 }
--             end),
--             awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
--             awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
--             awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
--         },
--     }
--      
--     -- Spawn 5 clients on screen 1.
--     for i= 1, 5 do
--         awful.spawn(&#34Client #&#34..i, {screen = screen[1]})
--     end
--      
--     -- Spawn 3 clients on screen 2.
--     for i=1, 3 do
--         awful.spawn(&#34Client #&#34..(5+i), {screen = screen[2]})
--     end
--      
--     -- Change the tastlist screen.
--     tasklist.screen = screen[2]
--      
--
-- @property screen
-- @tparam screen screen
-- @propertydefault Obtained from the constructor.
-- @propemits true false

--- A function to narrow down the list of clients.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_sequences_client_tasklist_custom_filter1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local tasklist = awful.widget.tasklist {
--         screen      = s,
--         filter      = awful.widget.tasklist.filter.currenttags,
--         base_layout = wibox.widget {
--             spacing = 2,
--             layout  = wibox.layout.fixed.horizontal,
--         },
--     }
--      
--     -- Spawn 5 clients on screen 1.
--     for i= 1, 5 do
--         awful.spawn(&#34Client #&#34..i, {screen = screen[1]})
--     end
--      
--     -- Spawn 3 clients on screen 2.
--     for i=1, 3 do
--         awful.spawn(&#34Client #&#34..(5+i), {screen = screen[2]})
--     end
--      
--     -- Set the filter to allscreen.
--     tasklist.filter = awful.widget.tasklist.filter.allscreen
--      
--     -- Create a pointless demo filter to only have clients
--     -- with off numbers in the name. Because... example!
--     tasklist.filter = function(c, screen) -- luacheck: no unused args
--         return c.name:match(&#34[13579]&#34) and c or nil
--     end
--
-- @property filter
-- @tparam[opt=awful.widget.tasklist.filter.alltags] function filter
-- @functionparam client c The client to accept or reject.
-- @functionparam screen s The value of the tasklist `screen` property.
-- @functionreturn boolean `true` if the client is accepter or `false` if it is rejected.
-- @propemits true false
-- @see awful.widget.tasklist.filter.allscreen
-- @see awful.widget.tasklist.filter.alltags
-- @see awful.widget.tasklist.filter.currenttags
-- @see awful.widget.tasklist.filter.minimizedcurrenttags
-- @see awful.widget.tasklist.filter.focused

--- A function called when the tasklist is refreshed.
--
-- This is a very low level API, prefer `widget_template` whenever
-- you can.
--
-- @property update_function
-- @tparam function|nil update_function
-- @propertydefault The default function delegate everything to the `widget_template`.
-- @functionparam widget layout The base layout object.
-- @functionparam table buttons The buttons for this client entry (see below).
-- @functionparam string label The client name.
-- @functionparam table data Arbitrary metadate.
-- @functionparam table clients The list of clients (ordered).
-- @functionparam table metadata Other values.
-- @functionnoreturn
-- @propemits true false

--- A template for creating the client widgets.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_sequences_client_tasklist_widget_template1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local tasklist = awful.widget.tasklist {
--         screen      = s,
--         filter      = awful.widget.tasklist.filter.currenttags,
--         base_layout = wibox.widget {
--             spacing = 2,
--             layout  = wibox.layout.fixed.horizontal,
--         },
--     }
--      
--     -- Change the widget template.
--     tasklist.widget_template = {
--         {
--             {
--                 {
--                     {
--                         id     = &#34icon_role&#34,
--                         widget = wibox.widget.imagebox,
--                     },
--                     margins = 2,
--                     widget  = wibox.container.margin,
--                 },
--                 {
--                     id     = &#34text_role&#34,
--                     widget = wibox.widget.textbox,
--                 },
--                 layout = wibox.layout.fixed.horizontal,
--             },
--             left  = 10,
--             right = 10,
--             widget = wibox.container.margin
--         },
--         id     = &#34background_role&#34,
--         widget = wibox.container.background,
--     }
--      
--
-- @property widget_template
-- @tparam[opt=nil] template|nil widget_template
-- @propemits true false

--- A function to gather the clients to display.
--
-- 
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_sequences_client_tasklist_custom_source1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local tasklist = awful.widget.tasklist {
--         screen      = s,
--         filter      = awful.widget.tasklist.filter.currenttags,
--         base_layout = wibox.widget {
--             spacing = 2,
--             layout  = wibox.layout.fixed.horizontal,
--         },
--     }
--      
--     -- Spawn 5 clients on screen 1.
--     for i= 1, 5 do
--         awful.spawn(&#34Client #&#34..i, {screen = screen[1]})
--     end
--      
--     -- Make 2 clients floating.
--     client.get()[2].floating = true
--     client.get()[4].floating = true
--      
--     -- Only select the floating clients for the tasklist screen.
--     tasklist.source = function(screen)
--         local ret = {}
--          
--         for _, c in ipairs(screen.clients) do
--             if c.floating then
--                 table.insert(ret, c)
--             end
--         end
--          
--         return ret
--     end
--
-- @property source
-- @tparam[opt=awful.widget.tasklist.source.all_clients] function source
-- @functionparam screen s The tasklist screen.
-- @functionparam table metadata Various metadata.
-- @functionreturn table The list of clients.
-- @propemits true false
-- @see awful.widget.tasklist.source.all_clients

function tasklist:set_base_layout(layout)
    self._private.base_layout = base.make_widget_from_value(
        layout or flex.horizontal
    )

    local spacing = self._private.style.spacing or beautiful.tasklist_spacing

    if self._private.base_layout.set_spacing and spacing then
        self._private.base_layout:set_spacing(spacing)
    end

    assert(self._private.base_layout.is_widget)

    self._do_tasklist_update()

    self:emit_signal("widget::layout_changed")
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::base_layout", layout)
end

function tasklist:get_count()
    if not self._private.last_count then
        self._do_tasklist_update_now()
    end

    return self._private.last_count
end

function tasklist:layout(_, width, height)
    if self._private.base_layout then
        return { base.place_widget_at(self._private.base_layout, 0, 0, width, height) }
    end
end

function tasklist:fit(context, width, height)
    if not self._private.base_layout then
        return 0, 0
    end

    return base.fit_widget(self, context, self._private.base_layout, width, height)
end

for _, prop in ipairs { "screen", "filter", "update_function", "widget_template", "source"} do
    tasklist["set_"..prop] = function(self, value)
        if value == self._private[prop] then return end

        self._private[prop] = value

        self._do_tasklist_update()

        self:emit_signal("widget::layout_changed")
        self:emit_signal("widget::redraw_needed")
        self:emit_signal("property::"..prop, value)
    end

    tasklist["get_"..prop] = function(self)
        return self._private[prop]
    end
end

local function update_screen(self, screen, old)
    if not instances then return end

    if old and instances[old] then
        for k, w in ipairs(instances[old]) do
            if w == self then
                table.remove(instances[old], k)
                break
            end
        end
    end

    local list = instances[screen]

    if not list then
        list = setmetatable({}, { __mode = "v" })
        instances[screen] = list
    end

    table.insert(list, self)
end

function tasklist:set_screen(value)
    value = get_screen(value)

    if value == self._private.screen then return end

    local old = self._private.screen

    self._private.screen = value

    update_screen(self, screen, old)

    self._do_tasklist_update()

    self:emit_signal("widget::layout_changed")
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::screen", value)
end

function tasklist:set_widget_template(widget_template)
    self._private.widget_template = widget_template

    -- Remove the existing instances
    self._private.data = setmetatable({}, { __mode = 'k' })

    self._do_tasklist_update()

    self:emit_signal("widget::layout_changed")
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::widget_template", widget_template)
end

--- Create a new tasklist widget.
-- The last two arguments (update_function
-- and layout) serve to customize the layout of the tasklist (eg. to
-- make it vertical). For that, you will need to copy the
-- awful.widget.common.list_update function, make your changes to it
-- and pass it as update_function here. Also change the layout if the
-- default is not what you want.
--
-- @tparam table args
-- @tparam screen args.screen The screen to draw tasklist for.
-- @tparam function args.filter Filter function to define what clients will be listed.
-- @tparam table args.buttons A table with buttons binding to set.
-- @tparam[opt] function args.update_function Function to create a tag widget on each
--   update. See `awful.widget.common.list_update`.
-- @tparam[opt] table args.layout Container widget for tag widgets. Default
--   is `wibox.layout.flex.horizontal`.
-- @tparam[opt=awful.widget.tasklist.source.all_clients] function args.source The
--  function used to generate the list of client.
-- @tparam[opt] table args.widget_template A custom widget to be used for each client
-- @tparam[opt={}] table args.style The style overrides default theme.
-- @tparam[opt=beautiful.tasklist_fg_normal] string|pattern args.style.fg_normal
-- @tparam[opt=beautiful.tasklist_bg_normal] string|pattern args.style.bg_normal
-- @tparam[opt=beautiful.tasklist_fg_focus or beautiful.fg_focus] string|pattern args.style.fg_focus
-- @tparam[opt=beautiful.tasklist_bg_focus or beautiful.bg_focus] string|pattern args.style.bg_focus
-- @tparam[opt=beautiful.tasklist_fg_urgent or beautiful.fg_urgent] string|pattern args.style.fg_urgent
-- @tparam[opt=beautiful.tasklist_bg_urgent or beautiful.bg_urgent] string|pattern args.style.bg_urgent
-- @tparam[opt=beautiful.tasklist_fg_minimize or beautiful.fg_minimize] string|pattern args.style.fg_minimize
-- @tparam[opt=beautiful.tasklist_bg_minimize or beautiful.bg_minimize] string|pattern args.style.bg_minimize
-- @tparam[opt=beautiful.tasklist_bg_image_normal] string args.style.bg_image_normal
-- @tparam[opt=beautiful.tasklist_bg_image_focus] string args.style.bg_image_focus
-- @tparam[opt=beautiful.tasklist_bg_image_urgent] string args.style.bg_image_urgent
-- @tparam[opt=beautiful.tasklist_bg_image_minimize] string args.style.bg_image_minimize
-- @tparam[opt=beautiful.tasklist_disable_icon] boolean args.style.disable_icon
-- @tparam[opt=beautiful.tasklist_icon_size] number args.style.icon_size The size of the icon
-- @tparam[opt=beautiful.tasklist_sticky or '▪'] string args.style.sticky Extra icon when client is sticky
-- @tparam[opt=beautiful.tasklist_ontop or '⌃'] string args.style.ontop Extra icon when client is ontop
-- @tparam[opt=beautiful.tasklist_above or '▴'] string args.style.above Extra icon when client is above
-- @tparam[opt=beautiful.tasklist_below or '▾'] string args.style.below Extra icon when client is below
-- @tparam[opt=beautiful.tasklist_floating or '✈'] string args.style.floating Extra icon when client is floating
-- @tparam[opt=beautiful.tasklist_maximized or '<b>+</b>'] string args.style.maximized Extra
--   icon when client is maximized
-- @tparam[opt=beautiful.tasklist_maximized_horizontal or '⬌'] string args.style.maximized_horizontal Extra
--   icon when client is maximized_horizontal
-- @tparam[opt=beautiful.tasklist_maximized_vertical or '⬍'] string args.style.maximized_vertical Extra
--   icon when client is maximized_vertical
-- @tparam[opt=beautiful.tasklist_disable_task_name or false] boolean args.style.disable_task_name
-- @tparam[opt=beautiful.tasklist_font] string args.style.font
-- @tparam[opt=beautiful.tasklist_align or "left"] string args.style.align *left*, *right* or *center*
-- @tparam[opt=beautiful.tasklist_font_focus] string args.style.font_focus
-- @tparam[opt=beautiful.tasklist_font_minimized] string args.style.font_minimized
-- @tparam[opt=beautiful.tasklist_font_urgent] string args.style.font_urgent
-- @tparam[opt=beautiful.tasklist_spacing] number args.style.spacing The spacing between tags.
-- @tparam[opt=beautiful.tasklist_shape] gears.shape args.style.shape
-- @tparam[opt=beautiful.tasklist_shape_border_width] number args.style.shape_border_width
-- @tparam[opt=beautiful.tasklist_shape_border_color] string|color args.style.shape_border_color
-- @tparam[opt=beautiful.tasklist_shape_focus] gears.shape args.style.shape_focus
-- @tparam[opt=beautiful.tasklist_shape_border_width_focus] number args.style.shape_border_width_focus
-- @tparam[opt=beautiful.tasklist_shape_border_color_focus] string|color args.style.shape_border_color_focus
-- @tparam[opt=beautiful.tasklist_shape_minimized] gears.shape args.style.shape_minimized
-- @tparam[opt=beautiful.tasklist_shape_border_width_minimized] number args.style.shape_border_width_minimized
-- @tparam[opt=beautiful.tasklist_shape_border_color_minimized] string|color args.style.shape_border_color_minimized
-- @tparam[opt=beautiful.tasklist_shape_urgent] gears.shape args.style.shape_urgent
-- @tparam[opt=beautiful.tasklist_shape_border_width_urgent] number args.style.shape_border_width_urgent
-- @tparam[opt=beautiful.tasklist_shape_border_color_urgent] string|color args.style.shape_border_color_urgent
-- @tparam[opt=beautiful.tasklist_minimized ] string|color args.style.minimized
-- @param filter **DEPRECATED** use args.filter
-- @param buttons **DEPRECATED** use args.buttons
-- @param style **DEPRECATED** use args.style
-- @param update_function **DEPRECATED** use args.update_function
-- @param base_widget **DEPRECATED** use args.base_layout
-- @constructorfct awful.widget.tasklist
-- @usebeautiful beautiful.tasklist_plain_task_name
function tasklist.new(args, filter, buttons, style, update_function, base_widget)
    local screen = nil

    local argstype = type(args)

    -- Detect the old function signature
    if argstype == "number" or argstype == "screen" or
      (argstype == "table" and args.index and args == capi.screen[args.index]) then
        gdebug.deprecate("The `screen` parameter is deprecated, use `args.screen`.",
            {deprecated_in=5})

        screen = get_screen(args)
        args = {}
    end

    assert(type(args) == "table")

    for k, v in pairs { filter          = filter,
                        buttons         = buttons,
                        style           = style,
                        update_function = update_function,
                        layout          = base_widget
    } do
        gdebug.deprecate("The `awful.widget.tasklist()` `"..k
            .."` parameter is deprecated, use `args."..k.."`.",
        {deprecated_in=5})
        args[k] = v
    end

    screen = screen or get_screen(args.screen)
    local uf = args.update_function or common.list_update

    local w = base.make_widget(nil, nil, {
        enable_properties = true,
    })

    gtable.crush(w._private, {
        disable_task_name = args.disable_task_name,
        disable_icon      = args.disable_icon,
        update_function   = args.update_function,
        filter            = args.filter,
        buttons           = args.buttons,
        style             = args.style or {},
        screen            = screen,
        widget_template   = args.widget_template,
        source            = args.source,
        data              = setmetatable({}, { __mode = 'k' })
    })

    gtable.crush(w, tasklist, true)
    rawset(w, "filter", nil)
    rawset(w, "source", nil)

    local queued_update = false

    -- For the tests
    function w._do_tasklist_update_now()
        queued_update = false
        if w._private.screen.valid then
            tasklist_update(
                w._private.screen, w, w._private.buttons, w._private.filter, w._private.data, args.style, uf, args
            )
        end
    end

    function w._do_tasklist_update()
        -- Add a delayed callback for the first update.
        if not queued_update then
            timer.delayed_call(w._do_tasklist_update_now)
            queued_update = true
        end
    end
    function w._unmanage(c)
        w._private.data[c] = nil
    end
    if instances == nil then
        instances = setmetatable({}, { __mode = "k" })
        local function us(s)
            local i = instances[get_screen(s)]
            if i then
                for _, tlist in pairs(i) do
                    tlist._do_tasklist_update()
                end
            end
        end
        local function u()
            for s in pairs(instances) do
                if s.valid then
                    us(s)
                end
            end
        end

        tag.attached_connect_signal(nil, "property::selected", u)
        tag.attached_connect_signal(nil, "property::activated", u)
        capi.client.connect_signal("property::urgent", u)
        capi.client.connect_signal("property::sticky", u)
        capi.client.connect_signal("property::ontop", u)
        capi.client.connect_signal("property::above", u)
        capi.client.connect_signal("property::below", u)
        capi.client.connect_signal("property::floating", u)
        capi.client.connect_signal("property::maximized_horizontal", u)
        capi.client.connect_signal("property::maximized_vertical", u)
        capi.client.connect_signal("property::maximized", u)
        capi.client.connect_signal("property::minimized", u)
        capi.client.connect_signal("property::name", u)
        capi.client.connect_signal("property::icon_name", u)
        capi.client.connect_signal("property::icon", u)
        capi.client.connect_signal("property::skip_taskbar", u)
        capi.client.connect_signal("property::screen", function(c, old_screen)
            us(c.screen)
            us(old_screen)
        end)
        capi.client.connect_signal("property::hidden", u)
        capi.client.connect_signal("tagged", u)
        capi.client.connect_signal("untagged", u)
        capi.client.connect_signal("request::unmanage", function(c)
            u(c)
            for _, i in pairs(instances) do
                for _, tlist in pairs(i) do
                    tlist._unmanage(c)
                end
            end
        end)
        capi.client.connect_signal("list", u)
        capi.client.connect_signal("property::active", u)
        capi.screen.connect_signal("removed", function(s)
            instances[get_screen(s)] = nil
        end)
    end

    tasklist.set_base_layout(w, args.layout or args.base_layout)

    w._do_tasklist_update()

    update_screen(w, screen)

    return w
end

--- Filtering function to include all clients.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_sequences_client_tasklist_filter_allscreen1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local tasklist = awful.widget.tasklist {
--         screen      = s,
--         filter      = awful.widget.tasklist.filter.currenttags,
--         base_layout = wibox.widget {
--             spacing = 2,
--             layout  = wibox.layout.fixed.horizontal,
--         },
--     }
--      
--     -- Spawn 5 clients on screen 1.
--     for i= 1, 5 do
--         awful.spawn(&#34Client #&#34..i, {screen = screen[1]})
--     end
--      
--     -- Spawn 3 clients on screen 2.
--     for i=1, 3 do
--         awful.spawn(&#34Client #&#34..(5+i), {screen = screen[2]})
--     end
--      
--     -- Set the filter to allscreen.
--     tasklist.filter = awful.widget.tasklist.filter.allscreen
--      
--
-- @return true
-- @filterfunction awful.widget.tasklist.filter.allscreen
function tasklist.filter.allscreen()
    return true
end

--- Filtering function to include the clients from all tags on the screen.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_sequences_client_tasklist_filter_alltags1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local tasklist = awful.widget.tasklist {
--         screen      = s,
--         filter      = awful.widget.tasklist.filter.currenttags,
--         base_layout = wibox.widget {
--             spacing = 2,
--             layout  = wibox.layout.fixed.horizontal,
--         },
--     }
--      
--     -- Spawn 5 clients on screen 1.
--     for i= 1, 5 do
--         awful.spawn(&#34Client #&#34..i, {tags = {screen[1].tags[1]}})
--     end
--      
--     -- Spawn 3 clients on screen 2.
--     for i=1, 3 do
--         awful.spawn(&#34Client #&#34..(5+i), {tags = {screen[1].tags[2]}})
--     end
--      
--     -- Set the filter to alltags.
--     tasklist.filter = awful.widget.tasklist.filter.alltags
--      
--
-- @tparam client c The client.
-- @tparam screen screen The screen we are drawing on.
-- @return true if c is on screen, false otherwise
-- @filterfunction awful.widget.tasklist.filter.alltags
function tasklist.filter.alltags(c, screen)
    -- Only print client on the same screen as this widget
    return get_screen(c.screen) == get_screen(screen)
end

--- Filtering function to include only the clients from currently selected tags.
--
-- This is the filter used in the default `rc.lua`.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_sequences_client_tasklist_filter_currenttags1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local tasklist = awful.widget.tasklist {
--         screen      = s,
--         filter      = awful.widget.tasklist.filter.currenttags,
--         base_layout = wibox.widget {
--             spacing = 2,
--             layout  = wibox.layout.fixed.horizontal,
--         },
--     }
--      
--     -- Spawn 5 clients on screen 1.
--     for k, t in ipairs(screen[1].tags) do
--         for i= 1, 2 do
--             awful.spawn(&#34Client #&#34..(k-1)*2 + i, {tags = {t}})
--         end
--     end
--      
--     -- Selected some tags.
--     screen[1].tags[3].selected = true
--     screen[1].tags[5].selected = true
--      
--     -- Set the filter to currenttags.
--     tasklist.filter = awful.widget.tasklist.filter.currenttags
--      
--
-- @tparam client c The client.
-- @tparam screen screen The screen we are drawing on.
-- @return true if c is in a selected tag on screen, false otherwise
-- @filterfunction awful.widget.tasklist.filter.currenttags
function tasklist.filter.currenttags(c, screen)
    screen = get_screen(screen)
    -- Only print client on the same screen as this widget
    if get_screen(c.screen) ~= screen then return false end
    -- Include sticky client too
    if c.sticky then return true end
    local tags = screen.tags
    for _, t in ipairs(tags) do
        if t.selected then
            local ctags = c:tags()
            for _, v in ipairs(ctags) do
                if v == t then
                    return true
                end
            end
        end
    end
    return false
end

--- Filtering function to include only the minimized clients from currently selected tags.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_sequences_client_tasklist_filter_minimizedcurrenttags1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local tasklist = awful.widget.tasklist {
--         screen      = s,
--         filter      = awful.widget.tasklist.filter.currenttags,
--         base_layout = wibox.widget {
--             spacing = 2,
--             layout  = wibox.layout.fixed.horizontal,
--         },
--     }
--      
--     -- Spawn 5 clients on screen 1.
--     for k, t in ipairs(screen[1].tags) do
--         for i= 1, 2 do
--             awful.spawn(&#34Client #&#34..(k-1)*2 + i, {tags = {t}, minimized = i == 1})
--         end
--     end
--      
--     -- Selected some tags.
--     screen[1].tags[3].selected = true
--     screen[1].tags[5].selected = true
--      
--     -- Set the filter to minimizedcurrenttags.
--     tasklist.filter = awful.widget.tasklist.filter.minimizedcurrenttags
--      
--
-- @tparam client c The client.
-- @tparam screen screen The screen we are drawing on.
-- @return true if c is in a selected tag on screen and is minimized, false otherwise
-- @filterfunction awful.widget.tasklist.filter.minimizedcurrenttags
function tasklist.filter.minimizedcurrenttags(c, screen)
    screen = get_screen(screen)
    -- Only print client on the same screen as this widget
    if get_screen(c.screen) ~= screen then return false end
    -- Check client is minimized
    if not c.minimized then return false end
    -- Include sticky client
    if c.sticky then return true end
    local tags = screen.tags
    for _, t in ipairs(tags) do
        -- Select only minimized clients
        if t.selected then
            local ctags = c:tags()
            for _, v in ipairs(ctags) do
                if v == t then
                    return true
                end
            end
        end
    end
    return false
end

--- Filtering function to include only the currently focused client.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_sequences_client_tasklist_filter_focused1.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--     local tasklist = awful.widget.tasklist {
--         screen      = s,
--         filter      = awful.widget.tasklist.filter.currenttags,
--         base_layout = wibox.widget {
--             spacing = 2,
--             layout  = wibox.layout.fixed.horizontal,
--         },
--     }
--      
--     -- Spawn 5 clients on screen 1.
--     for i= 1, 5 do
--         awful.spawn(&#34Client #&#34..i, {screen = screen[1]})
--     end
--      
--     -- Set the filter to focused.
--     tasklist.filter = awful.widget.tasklist.filter.focused
--      
--
-- @tparam client c The client.
-- @tparam screen screen The screen we are drawing on.
-- @return true if c is focused on screen, false otherwise
-- @filterfunction awful.widget.tasklist.filter.focused
function tasklist.filter.focused(c, screen)
    -- Only print client on the same screen as this widget
    return get_screen(c.screen) == get_screen(screen) and c.active
end

--- Get all the clients in an undefined order.
--
-- This is the default source.
--
-- @sourcefunction awful.widget.tasklist.source.all_clients
function tasklist.source.all_clients()
    return capi.client.get()
end

function tasklist.mt:__call(...)
    return tasklist.new(...)
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

return setmetatable(tasklist, tasklist.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
