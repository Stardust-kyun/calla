local config=".config"
local picom=config.."/picom.conf"
local xresources=".Xresources"
local xsettingsd=".xsettingsd"
local gtk=config.."/gtk-3.0/settings.ini"

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

	os.execute("xrdb ~/" .. xresources)
	os.execute("pidof st | xargs kill -s USR1")
end

local function theme(theme, icon)
	local r = assert(io.open(gtk, "r"))
	local file = r:read("*all")
	r:close()

	file = file:gsub("gtk%-theme%-name=.-\n", "gtk-theme-name="..theme.."\n")
	file = file:gsub("gtk%-icon%-theme%-name=.-\n", "gtk-icon-theme-name="..icon.."\n")

	local w = assert(io.open(gtk, "w"))
	w:write(file)
	w:close()

	local r = assert(io.open(xsettingsd, "r"))
	local file = r:read("*all")
	r:close()

	file = file:gsub("Net/ThemeName .-\n", "Net/ThemeName \""..theme.."\"\n")
	file = file:gsub("Net/IconThemeName .-\n", "Net/IconThemeName \""..icon.."\"\n")

	local w = assert(io.open(xsettingsd, "w"))
	w:write(file)
	w:close()

	os.execute("xsettingsd &")
end

awesome.connect_signal("color::change", function(color)
	compositor(color.compradius, color.compoffset, color.compoffset, color.compopacity)

	terminal(color.bg, color.fg, color.black, color.white, color.red, color.green, color.yellow, color.blue, color.magenta, color.cyan)

	theme(color.gtk, color.icons)
end)
