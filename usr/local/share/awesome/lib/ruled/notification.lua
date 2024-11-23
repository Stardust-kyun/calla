---------------------------------------------------------------------------
--- Apply properties to a new `naughty.notification` based on pre-determined rules.
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_nwidget_rules_urgency.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    ruled.notification.connect_signal(&#34request::rules&#34, function()
--        -- Add a red background for urgent notifications.
--        ruled.notification.append_rule {
--            rule       = { urgency = &#34critical&#34 },
--            properties = { bg = &#34#ff0000&#34, fg = &#34#ffffff&#34, timeout = 0 }
--        }
--         
--        -- Or green background for normal ones.
--        ruled.notification.append_rule {
--            rule       = { urgency = &#34normal&#34 },
--            properties = { bg      = &#34#00ff00&#34, fg = &#34#000000&#34}
--        }
--    end)
--  
--    -- Create a normal notification.
--    naughty.notification {
--        title   = &#34A notification 1&#34,
--        message = &#34This is very informative&#34,
--        icon    = beautiful.awesome_icon,
--        urgency = &#34normal&#34,
--    }
--  
--    -- Create a normal notification.
--    naughty.notification {
--        title   = &#34A notification 2&#34,
--        message = &#34This is very informative&#34,
--        icon    = beautiful.awesome_icon,
--        urgency = &#34critical&#34,
--    }
--
-- In this example, we setup a different widget template for some music
-- notifications:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_nwidget_rules_widget_template.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    ruled.notification.connect_signal(&#34request::rules&#34, function()
--        -- Add a red background for urgent notifications.
--        ruled.notification.append_rule {
--            rule       = { app_name = &#34mdp&#34 },
--            properties = {
--                widget_template = {
--                    {
--                        {
--                            {
--                                {
--                                    naughty.widget.icon,
--                                    forced_height = 48,
--                                    halign        = &#34center&#34,
--                                    valign        = &#34center&#34,
--                                    widget        = wibox.container.place
--                                },
--                                {
--                                    halign = &#34center&#34,
--                                    widget = naughty.widget.title,
--                                },
--                                {
--                                    halign = &#34center&#34,
--                                    widget = naughty.widget.message,
--                                },
--                                {
--                                    orientation   = &#34horizontal&#34,
--                                    widget        = wibox.widget.separator,
--                                    forced_height = 1,
--                                },
--                                {
--                                    nil,
--                                    {
--                                        wibox.widget.textbox &#34⏪&#34,
--                                        wibox.widget.textbox &#34⏸&#34,
--                                        wibox.widget.textbox &#34⏩&#34,
--                                        spacing = 20,
--                                        layout  = wibox.layout.fixed.horizontal,
--                                    },
--                                    expand = &#34outside&#34,
--                                    nil,
--                                    layout = wibox.layout.align.horizontal,
--                                },
--                                spacing = 10,
--                                layout  = wibox.layout.fixed.vertical,
--                            },
--                            margins = beautiful.notification_margin,
--                            widget  = wibox.container.margin,
--                        },
--                        id     = &#34background_role&#34,
--                        widget = naughty.container.background,
--                    },
--                    strategy = &#34max&#34,
--                    width    = 160,
--                    widget   = wibox.container.constraint,
--                }
--            }
--        }
--    end)
--    naughty.connect_signal(&#34request::display&#34, function(n)
--        naughty.layout.box { notification = n }
--    end)
--        icon      = beautiful.awesome_icon,
--
-- In this example, we add action to a notification that originally lacked
-- them:
--
--
--
--<object class=&#34img-object&#34 data=&#34../images/AUTOGEN_wibox_nwidget_rules_add_actions.svg&#34 alt=&#34Usage example&#34 type=&#34image/svg+xml&#34></object>
--
-- 
--    ruled.notification.connect_signal(&#34request::rules&#34, function()
--        -- Add a red background for urgent notifications.
--        ruled.notification.append_rule {
--            rule       = { }, -- Match everything.
--            properties = {
--                append_actions = {
--                   naughty.action {
--                       name = &#34Snooze (5m)&#34,
--                   },
--                   naughty.action {
--                       name = &#34Snooze (15m)&#34,
--                   },
--                   naughty.action {
--                       name = &#34Snooze (1h)&#34,
--                   },
--                },
--            }
--        }
--    end)
--  
--    -- Create a normal notification.
--    naughty.notification {
--        title   = &#34A notification&#34,
--        message = &#34This is very informative&#34,
--        icon    = beautiful.awesome_icon,
--        actions = {
--            naughty.action { name = &#34Existing 1&#34 },
--            naughty.action { name = &#34Existing 2&#34 },
--        }
--    }
--
-- Here is a list of all properties available in the `properties` section of
-- a rule:
--
----<table class='widget_list' border=1>
-- <tr>
--  <th align='center'>Name</th>
--  <th align='center'>Description</th>
-- </tr>
--   <tr><td><a href='../core_components/naughty.notification.html#title'>title</a></td><td>Title of the notification</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#timeout'>timeout</a></td><td>Time in seconds after which popup expires</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#urgency'>urgency</a></td><td>The notification urgency level</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#category'>category</a></td><td>The notification category</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#resident'>resident</a></td><td>True if the notification should be kept when an action is pressed</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#hover_timeout'>hover_timeout</a></td><td>Delay in seconds after which hovered popup disappears</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#screen'>screen</a></td><td>Target screen for the notification</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#position'>position</a></td><td>Corner of the workarea displaying the popups</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#ontop'>ontop</a></td><td>Boolean forcing popups to display on top</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#height'>height</a></td><td>Popup height</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#width'>width</a></td><td>Popup width</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#font'>font</a></td><td>Notification font</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#icon'>icon</a></td><td>\"All in one\" way to access the default image or icon</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#icon_size'>icon_size</a></td><td>Desired icon size in px</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#app_icon'>app_icon</a></td><td>The icon provided in the `app_icon` field of the DBus notification</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#image'>image</a></td><td>The notification image</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#images'>images</a></td><td>The notification (animated) images</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#fg'>fg</a></td><td>Foreground color</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#bg'>bg</a></td><td>Background color</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#border_width'>border_width</a></td><td>Border width</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#border_color'>border_color</a></td><td>Border color</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#shape'>shape</a></td><td>Widget shape</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#opacity'>opacity</a></td><td>Widget opacity</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#margin'>margin</a></td><td>Widget margin</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#preset'>preset</a></td><td>Table with any of the above parameters</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#callback'>callback</a></td><td>Function that will be called with all arguments</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#actions'>actions</a></td><td>A table containing strings that represents actions to buttons</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#ignore'>ignore</a></td><td>Ignore this notification, do not display</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#suspended'>suspended</a></td><td>Tell if the notification is currently suspended (read only)</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#is_expired'>is_expired</a></td><td>If the notification is expired</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#auto_reset_timeout'>auto_reset_timeout</a></td><td>If the timeout needs to be reset when a property changes</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#clients'>clients</a></td><td>A list of clients associated with this notification</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#max_width'>max_width</a></td><td>The maximum popup width</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#app_name'>app_name</a></td><td>The application name specified by the notification</td></tr>
--   <tr><td><a href='../core_components/naughty.notification.html#widget_template'>widget_template</a></td><td>The widget template used to represent the notification</td></tr>
-- </table>
--
-- @author Emmanuel Lepage Vallee &lt;elv1313@gmail.com&gt;
-- @copyright 2017-2019 Emmanuel Lepage Vallee
-- @ruleslib ruled.notifications
---------------------------------------------------------------------------

local capi = {screen = screen, client = client, awesome = awesome}
local matcher = require("gears.matcher")
local gtable  = require("gears.table")
local gobject = require("gears.object")

--- The notification is attached to the focused client.
--
-- This is useful, along with other matching properties and the `ignore`
-- notification property, to prevent focused application from spamming with
-- useless notifications.
--
--
--
--
-- @usage
--    -- Note that the the message is matched as a pattern.
--    ruled.notification.append_rule {
--        rule       = { message = &#34I am SPAM&#34, has_focus = true },
--        properties = { ignore  = true}
--    }
--
-- @matchingproperty has_focus
-- @param boolean

--- The notification is attached to a client with this class.
--
--
--
--
-- @usage
--    ruled.notification.append_rule {
--        rule       = { has_class = &#34amarok&#34 },
--        properties = {
--            widget_template = my_music_widget_template,
--            actions         = get_mpris_actions(),
--        }
--    }
--
-- @matchingproperty has_class
-- @param string
-- @see has_instance

--- The notification is attached to a client with this instance name.
--
--
--
--
-- @usage
--    ruled.notification.append_rule {
--        rule       = { has_instance = &#34amarok&#34 },
--        properties = {
--            widget_template = my_music_widget_template,
--            actions         = get_mpris_actions(),
--        }
--    }
--
-- @matchingproperty has_instance
-- @param string
-- @see has_class

--- Append some actions to a notification.
--
-- Using `actions` directly is destructive since it will override existing
-- actions.
--
-- @clientruleproperty append_actions
-- @param table

--- Set a fallback timeout when the notification doesn't have an explicit timeout.
--
-- The value is in seconds. If none is specified, the default is 5 seconds. If
-- the notification specifies its own timeout, this property will be skipped.
--
-- @clientruleproperty implicit_timeout
-- @param number

--- Do not let this notification timeout, even if it asks for it.
-- @clientruleproperty never_timeout
-- @param boolean

local nrules = matcher()

local function client_match_common(n, prop, value)
    local clients = n.clients

    if #clients == 0 then return false end

    for _, c in ipairs(clients) do
        if c[prop] == value then
            return true
        end
    end

    return false
end

nrules:add_property_matcher("has_class", function(n, value)
    return client_match_common(n, "class", value)
end)

nrules:add_property_matcher("has_instance", function(n, value)
    return client_match_common(n, "instance", value)
end)

nrules:add_property_matcher("has_focus", function(n)
    local clients = n.clients

    if #clients == 0 then return false end

    for _, c in ipairs(clients) do
        if c == capi.client.focus then
            return true
        end
    end

    return false
end)

nrules:add_property_setter("append_actions", function(n, value)
    local new_actions = gtable.clone(n.actions or {}, false)
    n.actions = gtable.merge(new_actions, value)
end)

nrules:add_property_setter("implicit_timeout", function(n, value)
    -- Check if there is an explicit timeout.
    if (not n._private.timeout) and (not n._private.never_timeout) then
        n.timeout = value
    end
end)

nrules:add_property_setter("never_timeout", function(n, value)
    if value then
        n.timeout = 0
    end
end)

nrules:add_property_setter("timeout", function(n, value)
    -- `never_timeout` has an higher priority than `timeout`.
    if not n._private.never_timeout then
        n.timeout = value
    end
end)

local module = {}

gobject._setup_class_signals(module)

--- Remove a source.
-- @tparam string name The source name.
-- @treturn boolean If the source was removed.
-- @staticfct ruled.notification.remove_rule_source
function module.remove_rule_source(name)
    return nrules:remove_matching_source(name)
end

--- Apply the tag rules to a client.
--
-- This is useful when it is necessary to apply rules after a tag has been
-- created. Many workflows can make use of "blank" tags which wont match any
-- rules until later.
--
-- @tparam naughty.notification n The notification.
-- @staticfct ruled.notification.apply
-- @noreturn
function module.apply(n)
    local callbacks, props = {}, {}

    if n.preset then
        for k, v in pairs(n.preset) do
            if not n._private[v] then
                props[k] = v
            end
        end
    end

    for _, v in ipairs(nrules._matching_source) do
        v.callback(nrules, n, props, callbacks)
    end

    nrules:_execute(n, props, callbacks)
end

--- Add a new rule to the default set.
-- @tparam table rule A valid rule.
-- @staticfct ruled.notification.append_rule
-- @noreturn
function module.append_rule(rule)
    nrules:append_rule("ruled.notifications", rule)
end

--- Add a new rules to the default set.
-- @tparam table rule A table with rules.
-- @staticfct ruled.notification.append_rules
-- @noreturn
function module.append_rules(rules)
    nrules:append_rules("ruled.notifications", rules)
end

--- Remove a new rule to the default set.
-- @tparam table rule A valid rule.
-- @treturn boolean `true` if the rule was removed.
-- @staticfct ruled.notification.remove_rule
function module.remove_rule(rule)
    local ret = nrules:remove_rule("ruled.notifications", rule)
    module.emit_signal("rule::removed", rule)

    return ret
end

--- Add a new rule source.
--
-- A rule source is a provider called when a client initially request tags. It
-- allows to configure, select or create a tag (or many) to be attached to the
-- client.
--
-- @tparam string name The provider name. It must be unique.
-- @tparam function callback The callback that is called to produce properties.
-- @tparam client callback.c The client
-- @tparam table callback.properties The current properties. The callback should
--  add to and overwrite properties in this table
-- @tparam table callback.callbacks A table of all callbacks scheduled to be
--  executed after the main properties are applied.
-- @tparam[opt={}] table depends_on A list of names of sources this source depends on
--  (sources that must be executed *before* `name`.
-- @tparam[opt={}] table precede A list of names of sources this source have a
--  priority over.
-- @treturn boolean Returns false if a dependency conflict was found.
-- @staticfct ruled.notifications.add_rule_source

function module.add_rule_source(name, cb, ...)
    return nrules:add_matching_function(name, cb, ...)
end

-- Allow to clear the rules for testing purpose only.
-- Because multiple modules might set their rules, it is a bad idea to let
-- them be purged under their feet.
function module._clear()
    for k in pairs(nrules._matching_rules["ruled.notifications"]) do
        nrules._matching_rules["ruled.notifications"][k] = nil
    end
end

-- Add signals.
local conns = gobject._setup_class_signals(module)

-- First time getting a notification? Request some rules.
capi.awesome.connect_signal("startup", function()
    if conns["request::rules"] and #conns["request::rules"] > 0 then
        module.emit_signal("request::rules")

        -- This will disable the legacy preset support.
        require("naughty").connect_signal("request::preset", function(n)
            module.apply(n)
        end)
    end
end)

-----

--- A table whose content will be used to set the target object properties.
--
-- @rulecomponent properties
-- @param table
-- @see callback

--TODO add ^
-- @DOC_text_gears_matcher_properties_EXAMPLE@

--- A callback function to call *before* the `properties` have been applied.
--
-- The callback is called with the current client as first argument.
--
-- @rulecomponent callback
-- @param function

--- A table whose content will be compared to the target object current properties.
--
-- @rulecomponent rule
-- @param table
-- @see rule_any
-- @see except

--- Similar to `rule`, but each entry is a table with multiple values.
--
--
-- @rulecomponent rule_any
-- @param table
-- @see rule
-- @see except_any

--- The negative equivalent of `rule`.
--
-- @rulecomponent except
-- @param table
-- @see rule
-- @see except_any

--- The negative equivalent of `rule_any`.
--
-- @rulecomponent except_any
-- @param table
-- @see rule
-- @see except

--- Matches when one of every \"category\" of components match.
--
-- @rulecomponent rule_every
-- @param table
-- @see rule
-- @see except

--- A table whose content will be compared to the target object current properties.
--
-- The comparison will be made using the lesser (`<`) operator.
--
-- @rulecomponent rule_lesser
-- @param table
-- @see rule
-- @see except

--- A table whose content will be compared to the target object current properties.
--
-- The comparison will be made using the greater (`>`) operator.
--
-- @rulecomponent rule_greater
-- @param table
-- @see rule
-- @see except

--- An identifier for this rule.
--
-- It can be anything. It will be compared with the `==` operator. Strings are
-- highly recommended.
--
-- Setting an `id` is useful to be able to remove the rule by using its id
-- instead of a table reference. Modules can also listen to `rule::appended` and
-- modify or disable a rule.
--
-- @rulecomponent id
-- @tparam table|string|number|function id

return module
