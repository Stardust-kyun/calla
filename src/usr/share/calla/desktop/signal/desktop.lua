local awful = require("awful")

local emit = function(type)
	awesome.emit_signal("signal::desktop", type) 
end

emit()

local addsubscribe = [[
   bash -c "
   while inotifywait -e create -e moved_to $HOME/Desktop/ -qq; do echo; done
"]]

local removesubscribe = [[
   bash -c "
   while inotifywait -e delete -e moved_from $HOME/Desktop/ -qq; do echo; done
"]]

awful.spawn.easy_async_with_shell("ps x | grep \"inotifywait -e create -e moved_to $HOME/Desktop/\" | grep -v grep | awk '{print $1}' | xargs kill", function ()
    awful.spawn.with_line_callback(addsubscribe, {
        stdout = function() emit("add") end
    })
end)

awful.spawn.easy_async_with_shell("ps x | grep \"inotifywait -e delete -e moved_from $HOME/Desktop/\" | grep -v grep | awk '{print $1}' | xargs kill", function ()
    awful.spawn.with_line_callback(removesubscribe, {
        stdout = function() emit("remove") end
    })
end)
