local awful = require("awful")

local emit = function()
	awesome.emit_signal("signal::desktop") 
end

emit()

local subscribe = [[
   bash -c "
   while (inotifywait -e close_write -e delete -e create -e moved_from $HOME/Desktop/ -qq) do echo; done
"]]

awful.spawn.easy_async_with_shell("ps x | grep \"inotifywait -e close_write -e delete -e create -e moved_from $HOME/Desktop/\" | grep -v grep | awk '{print $1}' | xargs kill", function ()
    awful.spawn.with_line_callback(subscribe, {
        stdout = function() emit() end
    })
end)
