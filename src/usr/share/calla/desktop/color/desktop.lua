local calla="/usr/share/calla/"
local picom=calla.."compositor.conf"
local xresources=calla.."Xresources"
local xsettingsd=calla.."xsettingsd"

local function compositor(radius, x, y, opacity)
	local r = assert(io.open(picom, "r"))
	local file = r:read("*all")
	r:close()
	
	file = file:gsub("shadow%-radius = .-\n", "shadow-radius = "..radius..";\n")
	file = file:gsub("shadow%-offset%-x = .-\n", "shadow-offset-x = "..x..";\n")
	file = file:gsub("shadow%-offset%-y = .-\n", "shadow-offset-y = "..y..";\n")
	file = file:gsub("shadow%-opacity = .-\n", "shadow-opacity = "..opacity..";\n")

	local w = assert(io.open(picom, "w"))
	w:write(file)
	w:close()
end

local function terminal(bg, fg, bl, wh, r, g, y, b, m, c)
	local read = assert(io.open(xresources, "r"))
	local file = read:read("*all")
	read:close()

	file = file:gsub("%#define BG .-\n", "#define BG "..bg.."\n")
	file = file:gsub("%#define FG .-\n", "#define FG "..fg.."\n")
	file = file:gsub("%#define BL .-\n", "#define BL "..bl.."\n")
	file = file:gsub("%#define WH .-\n", "#define WH "..wh.."\n")
	file = file:gsub("%#define R .-\n", "#define R "..r.."\n")
	file = file:gsub("%#define G .-\n", "#define G "..g.."\n")
	file = file:gsub("%#define Y .-\n", "#define Y "..y.."\n")
	file = file:gsub("%#define B .-\n", "#define B "..b.."\n")
	file = file:gsub("%#define M .-\n", "#define M "..m.."\n")
	file = file:gsub("%#define C .-\n", "#define C "..c.."\n")

	local w = assert(io.open(xresources, "w"))
	w:write(file)
	w:close()

	os.execute("xrdb " .. xresources)
	require("awful").spawn.easy_async_with_shell(require("gears").filesystem.get_configuration_dir() .. "color/terminal.sh")
end

local function theme(theme, icon)
	local r = assert(io.open(xsettingsd, "r"))
	local file = r:read("*all")
	r:close()

	file = file:gsub("Net/ThemeName .-\n", "Net/ThemeName \""..theme.."\"\n")
	file = file:gsub("Net/IconThemeName .-\n", "Net/IconThemeName \""..icon.."\"\n")

	local w = assert(io.open(xsettingsd, "w"))
	w:write(file)
	w:close()

	os.execute("xsettingsd --config '/usr/share/calla/xsettingsd' &")
end

awesome.connect_signal("color::change", function(color)
	compositor(color.compradius, color.compoffset, color.compoffset, color.compopacity)

	terminal(color.bg, color.fg, color.black, color.white, color.red, color.green, color.yellow, color.blue, color.magenta, color.cyan)

	theme(color.gtk, color.icons)
end)
