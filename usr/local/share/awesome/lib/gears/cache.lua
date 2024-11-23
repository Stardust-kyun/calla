---------------------------------------------------------------------------
--- Cache object with data that can be garbage-collected.
--
-- Here is an example with a basic cache:
--
--
--
--
--**Usage example output**:
--
--    new entry created with value 0
--    0
--    new entry created with value 1
--    42
--    new entry created with value 2
--    84
--    0
--
--
-- @usage
-- local test_cache = cache.new(function(test)
--     -- let's just print about what we created
--     print(&#34new entry created with value &#34 .. test)
--     -- Pretend this is some expensive computation
--     return test * 42
-- end)
-- -- Populate the cache
-- print(test_cache:get(0))
-- print(test_cache:get(1))
-- print(test_cache:get(2))
-- -- no message since it exists
-- print(test_cache:get(0))
--
-- The example below demonstrates how the garbage collector will clear the
-- cache:
--
--
--
--
--**Usage example output**:
--
--    cache object #0 for first
--    cache object #1 for second
--    cache object #0 for first
--    forcing a garbage collect
--    cache object #2 for first
--    cache object #3 for second
--
--
-- @usage
-- local function tostring_for_cache(obj)
--     return obj[1]
-- end
-- local counter = 0
-- local wrapper_cache = gears.cache.new(function(arg)
--     local kind = &#34cache object #&#34 .. tostring(counter) .. &#34 for &#34 .. tostring(arg)
--     counter = counter + 1
--     return setmetatable({ kind }, { __tostring = tostring_for_cache })
-- end)
-- print(wrapper_cache:get(&#34first&#34))
-- print(wrapper_cache:get(&#34second&#34))
-- -- No new object since it already exists
-- print(wrapper_cache:get(&#34first&#34))
-- print(&#34forcing a garbage collect&#34)
-- -- The GC can *always* clear the cache
-- collectgarbage(&#34collect&#34)
-- print(wrapper_cache:get(&#34first&#34))
-- print(wrapper_cache:get(&#34second&#34))
--
--
-- @author Uli Schlachter
-- @copyright 2015 Uli Schlachter
-- @classmod gears.cache
---------------------------------------------------------------------------

local select = select
local setmetatable = setmetatable
local unpack = unpack or table.unpack -- luacheck: globals unpack (compatibility with Lua 5.1)

local cache = {}

--- Get an entry from the cache, creating it if it's missing.
-- @param ... Arguments for the creation callback. These are checked against the
--   cache contents for equality.
-- @return The entry from the cache
function cache:get(...)
    local result = self._cache
    for i = 1, select("#", ...) do
        local arg = select(i, ...)
        local next = result[arg]
        if not next then
            next = {}
            result[arg] = next
        end
        result = next
    end
    local ret = result._entry
    if not ret then
        ret = { self._creation_cb(...) }
        result._entry = ret
    end
    return unpack(ret)
end

--- Create a new cache object. A cache keeps some data that can be
-- garbage-collected at any time, but might be useful to keep.
-- @param creation_cb Callback that is used for creating missing cache entries.
-- @return A new cache object.
-- @constructorfct gears.cache
function cache.new(creation_cb)
    return setmetatable({
        _cache = setmetatable({}, { __mode = "v" }),
        _creation_cb = creation_cb
    }, {
        __index = cache
    })
end

return setmetatable(cache, { __call = function(_, ...) return cache.new(...) end })

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
