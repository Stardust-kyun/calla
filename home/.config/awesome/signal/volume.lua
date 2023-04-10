local awful = require("awful")

local volume_old = -1
local muted_old = -1
local function emit()
	awful.spawn.easy_async_with_shell("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(out)
		local volume = tonumber(string.match(out:match('(%d%.%d+)')*100, '(%d+)'))
		local muted = out:match('MUTED')

		if volume ~= volume_old or muted ~= muted_old then
			awesome.emit_signal('signal::volume', volume, muted)
			volume_old = volume
			muted_old = muted
		end
	end)
end

emit()

local subscribe = [[ bash -c "LANG=C pactl subscribe 2> /dev/null | grep --line-buffered \"Event 'change' on sink\"" ]]

awful.spawn.easy_async({ 'pkill', '--full', '--uid', os.getenv('USER'), '^pactl subscribe' }, function()
	awful.spawn.with_line_callback(subscribe, {
		stdout = function() emit() end
	})
end)
