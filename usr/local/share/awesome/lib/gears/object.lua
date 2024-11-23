---------------------------------------------------------------------------
-- The object oriented programming base class used by various Awesome
-- widgets and components.
--
-- It provide basic observer pattern, signaling and dynamic properties.
--
-- @author Uli Schlachter
-- @copyright 2010 Uli Schlachter
-- @utillib gears.object
---------------------------------------------------------------------------

local setmetatable = setmetatable
local pairs = pairs
local type = type
local error = error
local properties = require("gears.object.properties")

local object = { properties = properties, mt = {} }

--- Verify that obj is indeed a valid object as returned by new()
local function check(obj)
    if type(obj) ~= "table" or type(obj._signals) ~= "table" then
        error("called on non-object")
    end
end

--- Find a given signal
-- @tparam table obj The object to search in
-- @tparam string name The signal to find
-- @treturn table The signal table
local function find_signal(obj, name)
    check(obj)
    if not obj._signals[name] then
        assert(type(name) == "string", "name must be a string, got: " .. type(name))
        obj._signals[name] = {
            strong = {},
            weak = setmetatable({}, { __mode = "kv" })
        }
    end
    return obj._signals[name]
end

function object.add_signal()
    require("gears.debug").deprecate("Use signals without explicitly adding them. This is now done implicitly.",
                                     {deprecated_in=4})
end

--- Connect to a signal.
--
--
--
--
--**Usage example output**:
--
--    In slot	[obj]	nil	nil	nil
--    In slot	[obj]	foo	bar	42
--
--
-- @usage
-- local o = gears.object{}
-- -- Function can be attached to signals
-- local function slot(obj, a, b, c)
--     print(&#34In slot&#34, obj, a, b, c)
-- end
-- o:connect_signal(&#34my_signal&#34, slot)
-- -- Emitting can be done without arguments. In that case, the object will be
-- -- implicitly added as an argument.
-- o:emit_signal &#34my_signal&#34
-- -- It is also possible to add as many random arguments are required.
-- o:emit_signal(&#34my_signal&#34, &#34foo&#34, &#34bar&#34, 42)
-- -- Finally, to allow the object to be garbage collected (the memory freed), it
-- -- is necessary to disconnect the signal or use `weak_connect_signal`
-- o:disconnect_signal(&#34my_signal&#34, slot)
-- -- This time, the `slot` wont be called as it is no longer connected.
-- o:emit_signal &#34my_signal&#34
--
-- @tparam string name The name of the signal.
-- @tparam function func The callback to call when the signal is emitted.
-- @method connect_signal
-- @noreturn
function object:connect_signal(name, func)
    assert(type(func) == "function", "callback must be a function, got: " .. type(func))
    local sig = find_signal(self, name)
    assert(sig.weak[func] == nil, "Trying to connect a strong callback which is already connected weakly")
    sig.strong[func] = true
end

-- Register a global signal receiver.
function object:_connect_everything(callback)
    table.insert(self._global_receivers, callback)
end

local function make_the_gc_obey(func)
    if _VERSION <= "Lua 5.1" then
        -- Lua 5.1 only has the behaviour we want if a userdata is used as the
        -- value in a weak table. Thus, do some magic so that we get a userdata.

        -- luacheck: globals newproxy getfenv setfenv
        local userdata = newproxy(true)
        getmetatable(userdata).__gc = function() end
        -- Now bind the lifetime of userdata to the lifetime of func. For this,
        -- we mess with the function's environment and add a table for all the
        -- various userdata that it should keep alive.
        local key = "_secret_key_used_by_gears_object_in_Lua51"
        local old_env = getfenv(func)
        if old_env[key] then
            -- Assume the code in the else branch added this and the function
            -- already has its own, private environment
            table.insert(old_env[key], userdata)
        else
            -- No table yet, add it
            local new_env = { [key] = { userdata } }
            setmetatable(new_env, { __index = old_env, __newindex = old_env })
            setfenv(func, new_env)
        end
        assert(_G[key] == nil, "Something broke, things escaped to _G")
        return userdata
    end
    -- Lua 5.2+ already behaves the way we want with functions directly, no magic
    return func
end

--- Connect to a signal weakly.
--
-- This allows the callback function to be garbage collected and
-- automatically disconnects the signal when that happens.
-- **Warning:**
-- Only use this function if you really, really, really know what you
-- are doing.
--
-- @tparam string name The name of the signal.
-- @tparam function func The callback to call when the signal is emitted.
-- @method weak_connect_signal
-- @noreturn
function object:weak_connect_signal(name, func)
    assert(type(func) == "function", "callback must be a function, got: " .. type(func))
    local sig = find_signal(self, name)
    assert(sig.strong[func] == nil, "Trying to connect a weak callback which is already connected strongly")
    sig.weak[func] = make_the_gc_obey(func)
end

--- Disconnect from a signal.
-- @tparam string name The name of the signal.
-- @tparam function func The callback that should be disconnected.
-- @method disconnect_signal
-- @noreturn
function object:disconnect_signal(name, func)
    local sig = find_signal(self, name)
    sig.weak[func] = nil
    sig.strong[func] = nil
end

--- Emit a signal.
--
-- @tparam string name The name of the signal
-- @param ... Extra arguments for the callback functions. Each connected
--   function receives the object as first argument and then any extra
--   arguments that are given to emit_signal()
-- @method emit_signal
-- @noreturn
function object:emit_signal(name, ...)
    local sig = find_signal(self, name)
    for func in pairs(sig.strong) do
        func(self, ...)
    end
    for func in pairs(sig.weak) do
        func(self, ...)
    end
    for _, func in ipairs(self._global_receivers) do
        func(name, self, ...)
    end
end

function object._setup_class_signals(t, args)
    args = args or {}
    local conns = {}

    function t.connect_signal(name, func)
        assert(name)
        conns[name] = conns[name] or {}
        table.insert(conns[name], func)
    end

    -- A variant of emit_signal which stops once a condition is met.
    if args.allow_chain_of_responsibility then
        function t._emit_signal_if(name, condition, ...)
            assert(name)
            for _, func in pairs(conns[name] or {}) do
                if condition(...) then return end
                func(...)
            end
        end
    end


    --- Emit a notification signal.
    -- @tparam string name The signal name.
    -- @param ... The signal callback arguments
    function t.emit_signal(name, ...)
        assert(name)
        for _, func in pairs(conns[name] or {}) do
            func(...)
        end
    end

    --- Disconnect a signal from a source.
    -- @tparam string name The name of the signal
    -- @tparam function func The attached function
    -- @treturn boolean If the disconnection was successful
    function t.disconnect_signal(name, func)
        for k, v in ipairs(conns[name] or {}) do
            if v == func then
                table.remove(conns[name], k)
                return true
            end
        end
        return false
    end

    return conns
end

local function get_miss(self, key)
    local class = rawget(self, "_class")

    if rawget(self, "get_"..key) then
        return rawget(self, "get_"..key)(self)
    elseif class and class["get_"..key] then
        return class["get_"..key](self)
    elseif class then
        return class[key]
    end

end

local function set_miss(self, key, value)
    local class = rawget(self, "_class")

    if rawget(self, "set_"..key) then
        return rawget(self, "set_"..key)(self, value)
    elseif class and class["set_"..key] then
        return class["set_"..key](self, value)
    elseif rawget(self, "_enable_auto_signals") then
        local changed = class[key] ~= value
        class[key] = value

        if changed then
            self:emit_signal("property::"..key, value)
        end
    elseif (not rawget(self, "get_"..key))
        and not (class and class["get_"..key]) then
        return rawset(self, key, value)
    else
        error("Cannot set '" .. tostring(key) .. "' on " .. tostring(self)
                .. " because it is read-only")
    end
end

--- Returns a new object. You can call `:emit_signal()`, `:disconnect_signal()`
--  and `:connect_signal()` on the resulting object.
--
-- Note that `args.enable_auto_signals` is only supported when
-- `args.enable_properties` is true.
--
--
--
--
--**Usage example output**:
--
--    In get foo	bar
--    bar
--    In set foo	42
--    In get foo	42
--    42
--    In a method	1	2	3
--    nil
--    In the connection handler!	a cow
--    a cow
--
--
-- @usage
-- -- Create a class for this object. It will be used as a backup source for
-- -- methods and accessors. It is also possible to set them directly on the
-- -- object.
-- local class = {}
-- function class:get_foo()
--     print(&#34In get foo&#34, self._foo or &#34bar&#34)
--     return self._foo or &#34bar&#34
-- end
-- function class:set_foo(value)
--     print(&#34In set foo&#34, value)
--     -- In case it is necessary to bypass the object property system, use
--     -- `rawset`
--     rawset(self, &#34_foo&#34, value)
--     -- When using custom accessors, the signals need to be handled manually
--     self:emit_signal(&#34property::foo&#34, value)
-- end
-- function class:method(a, b, c)
--     print(&#34In a method&#34, a, b, c)
-- end
-- local o = gears.object {
--     class               = class,
--     enable_properties   = true,
--     enable_auto_signals = true,
-- }
-- print(o.foo)
-- o.foo = 42
-- print(o.foo)
-- o:method(1, 2, 3)
-- -- Random properties can also be added, the signal will be emitted automatically.
-- o:connect_signal(&#34property::something&#34, function(obj, value)
--     assert(obj == o)
--     print(&#34In the connection handler!&#34, value)
-- end)
-- print(o.something)
-- o.something = &#34a cow&#34
-- print(o.something)
-- @tparam[opt={}] table args The arguments
-- @tparam[opt=false] boolean args.enable_properties Automatically call getters and setters
-- @tparam[opt=false] boolean args.enable_auto_signals Generate "property::xxxx" signals
--   when an unknown property is set.
-- @tparam[opt=nil] table args.class
-- @treturn table A new object
-- @constructorfct gears.object

local function new(args)
    args = args or {}
    local ret = {}

    -- Automatic signals cannot work without both miss handlers.
    assert(not (args.enable_auto_signals and args.enable_properties ~= true))

    -- Copy all our global functions to our new object
    for k, v in pairs(object) do
        if type(v) == "function" then
            ret[k] = v
        end
    end

    ret._signals = {}

    ret._global_receivers = {}

    local mt = {}

    -- Look for methods in another table
    ret._class               = args.class
    ret._enable_auto_signals = args.enable_auto_signals

    -- To catch all changes, a proxy is required
    if args.enable_auto_signals then
        ret._class = ret._class and setmetatable({}, {__index = args.class}) or {}
    end

    if args.enable_properties then
        -- Check got existing get_xxxx and set_xxxx
        mt.__index    = get_miss
        mt.__newindex = set_miss
    elseif args.class then
        -- Use the class table a miss handler
        mt.__index = ret._class
    end

    return setmetatable(ret, mt)
end

function object.mt.__call(_, ...)
    return new(...)
end

--- Helper function to get the module name out of `debug.getinfo`.
-- @usage
--  local mt = {}
--  mt.__tostring = function(o)
--      return require("gears.object").modulename(2)
--  end
--  return setmetatable(ret, mt)
--
-- @tparam[opt=2] integer level Level for `debug.getinfo(level, "S")`.
--   Typically 2 or 3.
-- @treturn string The module name, e.g. "wibox.container.background".
-- @staticfct gears.object.modulename
function object.modulename(level)
    return debug.getinfo(level, "S").source:gsub(".*/lib/", ""):gsub("/", "."):gsub("%.lua", "")
end

return setmetatable(object, object.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
