local awful = require("awful")

local function emit()
	awful.spawn.easy_async_with_shell("playerctl --player=%any,firefox,chromium metadata --format 'title_{{title}}album_{{album}}artist_{{artist}}cover_{{mpris:artUrl}}elapsed_{{duration(position)}}total_{{duration(mpris:length)}}' & playerctl status", function(out)
		local title, album, artist, status

		title = out:match("title_(.*)album_") or "Not Playing"
		album = out:match("album_(.*)artist_") or "No Album"
		artist = out:match("artist_(.*)cover_") or "No Artist"
		cover = out:match("cover_file://(.*)elapsed_") or "None"
		elapsed = out:match("elapsed_(.*)total_") or "0:00"
		total = out:match("total_(.-)\n") or "0:00"

		if out:match("Playing") then
			status = true
		else
			status = false
		end

		awesome.emit_signal('signal::playerctl', title, album, artist, cover, elapsed, total, status)
	end)
end

emit()

local subscribe = [[ bash -c "playerctl metadata --format 'title_{{title}}album_{{album}}artist_{{artist}}cover_{{mpris:artUrl}}elapsed_{{duration(position)}}total_{{duration(mpris:length)}}' -F & playerctl status -F" ]]

awful.spawn.easy_async({ 'pkill', '--full', '--uid', os.getenv('USER'), '^playerctl' }, function()
    awful.spawn.with_line_callback(subscribe, {
        stdout = function() emit() end
    })
end)
