local config="$HOME/.config"
local xresources="$HOME/.Xresources"
local xsettingsd="$HOME/.xsettingsd"
local gtk=config.."/gtk-3.0/settings.ini"
local librewolf="$HOME/.librewolf/*.default-default/chrome"
local firefox="$HOME/.mozilla/firefox/*.default-release/chrome"
local picom=config.."/picom.conf"
local awesomewm=config.."/awesome"

local function compositor(radius, x, y, opacity)
	awful.spawn.easy_async_with_shell(
		"sed -i -e \"s/shadow-radius = .*/shadow-radius = "..radius..";/g\" \\
				-e \"s/shadow-offset-x = .*/shadow-offset-x = "..x..";/g\" \\
				-e \"s/shadow-offset-y = .*/shadow-offset-y = "..y..";/g\" \\
				-e \"s/shadow-opacity = .*/shadow-opacity = "..opacity..";/g\" "..picom
	)
end

local function terminal(fg, bg, bl, wh, r, g, y, b, m, c)
	awful.spawn.easy_async_with_shell(
		"sed -i -e \"s/#define FG .*/#define FG "..fg.."/g\" \\
				-e \"s/#define BG .*/#define BG "..bg.."/g\" \\
				-e \"s/#define BL .*/#define BL "..bl.."/g\" \\
				-e \"s/#define WH .*/#define WH "..wh.."/g\" \\
				-e \"s/#define R .*/#define R "..r.."/g\" \\
				-e \"s/#define G .*/#define G "..g.."/g\" \\
				-e \"s/#define Y .*/#define Y "..y.."/g\" \\
				-e \"s/#define B .*/#define B "..b.."/g\" \\
				-e \"s/#define M .*/#define M "..m.."/g\" \\
				-e \"s/#define C .*/#define C "..c.."/g\" "..xresources
	)
	awful.spawn.easy_async_with_shell("xrdb "..xresources)
	awful.spawn.easy_async_with_shell("pidof st | xargs kill -s USR1")
end

local function gtk(gtk, icon)
	awful.spawn.easy_async_with_shell(
		"sed -i -e \"s/gtk-theme-name=.*/gtk-theme-name="..gtk.."/g\" \
				-e \"s/gtk-icon-theme-name=.*/gtk-icon-theme-name="..icon.."/g\" "..gtk
	)
	awful.spawn.easy_async_with_shell(
		"sed -i -e \"s/Net\/ThemeName .*/Net\/ThemeName \""..gtk.."\"/g\" \
				-e \"s/Net\/IconThemeName .*/Net\/IconThemeName \""..icon.."\"/g\" "..xsettingsd
	)
	awful.spawn.easy_async_with_shell(xsettingsd &)
end

local function browser(bg, altbg, fg, altfg)
	awful.spawn.easy_async_with_shell(
		"sed -i -e \"s/--bg: .*/--bg: "..bg..";/g\" \
				-e \"s/--bg-alt: .*/--bg-alt: "..altbg..";/g\" \
				-e \"s/--fg: .*/--fg: "..fg..";/g\" \
				-e \"s/--fg-alt: .*/--fg-alt: "..altfg..";/g\" "..librewolf.."/userChrome.css"
	)
	awful.spawn.easy_async_with_shell(
		"sed -i -e \"s/--bg: .*/--bg: "..bg..";/g\" \
				-e \"s/--bg-alt: .*/--bg-alt: "..altbg..";/g\" \
				-e \"s/--fg: .*/--fg: "..fg..";/g\" \
				-e \"s/--fg-alt: .*/--fg-alt: "..altfg..";/g\" "..firefox.."/userChrome.css"
	)
end

local function css(bg, bg2, bg3, fg)
	awful.spawn.easy_async_with_shell(
		"sed -i -e \"s/--bg: .*/--bg: "..bg.." !important;/g\" \
				-e \"s/--bg2: .*/--bg2: "..bg2.." !important;/g\" \
				-e \"s/--bg3: .*/--bg3: "..bg3.." !important;/g\" \
				-e \"s/--fg: .*/--fg: "..fg.." !important;/g\" "..librewolf.."/userContent.css"
	)
	awful.spawn.easy_async_with_shell(
		"sed -i -e \"s/--bg: .*/--bg: "..bg.." !important;/g\" \
				-e \"s/--bg2: .*/--bg2: "..bg2.." !important;/g\" \
				-e \"s/--bg3: .*/--bg3: "..bg3.." !important;/g\" \
				-e \"s/--fg: .*/--fg: "..fg.." !important;/g\" "..firefox.."/userContent.css"
	)
end

local function awesomewm(color)
	awful.spawn.easy_async_with_shell(
		"sed -i \"s/require(\"color\..*/require(\"color\."..color.."\")/g\" $awesomewm/theme/theme.lua"
	)
	awesome.restart()
end
