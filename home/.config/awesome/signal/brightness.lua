local awful = require("awful")

local function emit()
	awful.spawn.easy_async_with_shell("brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}'", function(out)
		local brightness = math.floor(tonumber(out))

		awesome.emit_signal("signal::brightness", brightness)
	end)
end

emit()

local subscribe = [[ bash -c "while (inotifywait -e modify /sys/class/backlight/?*/brightness -qq) do echo; done" ]]

awful.spawn.easy_async_with_shell("ps x | grep \"inotifywait -e modify /sys/class/backlight\" | grep -v grep | awk '{print $1}' | xargs kill", function ()
	awful.spawn.with_line_callback(subscribe, {
		stdout = function() emit() end
	})
end)
