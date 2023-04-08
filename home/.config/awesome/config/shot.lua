local awful = require("awful")
local naughty = require("naughty")

local function screenshot(args, time)
	local tmp = "/tmp/" .. os.date("%F-%H%M%S") .. ".png"
	
	awful.spawn.easy_async_with_shell("sleep " .. time .. " && maim " .. args .. " " .. tmp, function()
		awful.spawn.easy_async_with_shell("[ -e '" .. tmp .. "' ] && echo exists", function(output)
			if output:match('%w+') then
				awful.spawn.easy_async_with_shell("cat " .. tmp .. " | xclip -se c -t image/png -i")
				awful.spawn.easy_async_with_shell("cp " .. tmp .. " " .. shotdir)
				awful.spawn.easy_async_with_shell("rm " .. tmp)

				naughty.notification {
					title = "Screenshot",
					text = "Saved to " .. shotdir
				}
			else
				naughty.notification {
					title = "Screenshot",
					text = "Cancelled"
				}
			end
		end)
	end)
end

awesome.connect_signal("screenshot::full", function()
	screenshot("-u", "0")
end)

awesome.connect_signal("screenshot::fullwait", function()
	screenshot("-u", "5")
end)

awesome.connect_signal("screenshot::part", function()
	screenshot("-s -u", "0")
end)
