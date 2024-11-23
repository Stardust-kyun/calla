local awful = require("awful")

local function emit()
	awful.spawn.easy_async_with_shell("playerctl metadata --format 'title_{{title}}album_{{album}}artist_{{artist}}' && playerctl status", function(out)
		local title, album, artist, status

		title = out:match("title_(.*)album_") or "Not Playing"
		album = out:match("album_(.*)artist_") or "No Album"
		artist = out:match("artist_(.*)") or "No Artist"

		if out:match("Playing") then
			status = true
		else
			status = false
		end

		awesome.emit_signal('signal::playerctl', title, album, artist, status)
	end)
end

emit()

local subscribe = [[ bash -c "playerctl metadata --format 'title_{{title}}album_{{album}}artist_{{artist}}' -F & playerctl status -F" ]]

awful.spawn.easy_async({ 'pkill', '--full', '--uid', os.getenv('USER'), '^playerctl' }, function()
    awful.spawn.with_line_callback(subscribe, {
        stdout = function() emit() end
    })
end)
