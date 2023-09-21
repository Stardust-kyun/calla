local awful = require("awful")

local batteryold = -1

local function emit_battery_info()
    awful.spawn.easy_async_with_shell("cat /sys/class/power_supply/" .. user.batt .. "/capacity", function(out)
		local battery = tonumber(out)

		if battery ~= batteryold then
			awesome.emit_signal("signal::battery", battery)
			batteryold = battery
		end
	end)
end

emit_battery_info()

local battery_subscribe_script = "bash -c 'while (inotifywait -e modify /sys/class/power_supply/" .. user.batt .. "/capacity -qq) do echo; done'"

awful.spawn.easy_async_with_shell("ps x | grep \"inotifywait -e modify /sys/class/power_supply\" | grep -v grep | awk '{print $1}' | xargs kill", function()
    awful.spawn.with_line_callback(battery_subscribe_script, {
        stdout = function(_)
            emit_battery_info()
        end
    })
end)
