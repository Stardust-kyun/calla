local awful = require("awful")
local naughty = require("naughty")

local function screenshot(args)

	local tmp = "/tmp/" .. os.date("%F-%H%M%S") .. ".png"
	
	awful.spawn.easy_async_with_shell("sleep " .. args.time .. " && maim " .. args.args .. " " .. tmp, function()
		awful.spawn.easy_async_with_shell("[ -e '" .. tmp .. "' ] && echo exists", function(output)
			if output:match('%w+') then
				awful.spawn.easy_async_with_shell("convert -trim " .. tmp .. " " .. tmp, function()
					awful.spawn.with_shell("cat " .. tmp .. " | xclip -se c -t image/png -i")
					awful.spawn.with_shell("cp " .. tmp .. " " .. user.shotdir)
					awful.spawn.with_shell("rm " .. tmp)
				end)
				naughty.notification {
					title = "Screenshot",
					text = "Saved to " .. user.shotdir
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

awesome.connect_signal("util::screenshot", function(args)
	screenshot(args)
end)
