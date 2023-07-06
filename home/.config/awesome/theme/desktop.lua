local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local appicons = "/usr/share/icons/Papirus/64x64/"
local foldericons = "/usr/share/icons/" .. beautiful.icons .. "/64x64/places/"

local awmmenu = {
	{ "Config", user.config },
	{ "Restart", awesome.restart },
}

local rootmenu = require("awful").menu ({
	items = {
		{ "Awesome", awmmenu },
		{ "Terminal", user.terminal },
		{ "Browser", user.browser },
		{ "Files", user.files },
		{ "Editor", user.editorcmd }
	}
})

local entries = wibox.widget {
	forced_num_rows = 7,
	forced_num_cols = 15,
	orientation = "horizontal",
	spacing = dpi(25),
	layout = wibox.layout.grid
}

local desktopdisplay = wibox {
	visible = true,
	ontop = false,
	bgimage = beautiful.wallpaper,
	type = "desktop",
	screen = s,
	widget = {
		buttons = {
			awful.button({}, 1, function() rootmenu:hide() end),
			awful.button({}, 3, function() rootmenu:toggle() end)
		},
		entries,
		margins = dpi(30),
		widget = wibox.container.margin,
	}
}

awful.placement.maximize(desktopdisplay)

local function gen()
	local shortcuts = {}
	local folders = {}
	local files = {}
	local entries = {}

	for entry in io.popen([[ls ~/Desktop | sed '']]):lines() do
		local name = entry
		local exec = nil
		local icon = appicons .. "mimetypes/text-x-generic.svg"
		local ext = name:match("^.+(%..+)$")

		if ext == ".desktop" then
			for line in io.popen("cat ~/Desktop/'" .. entry .. "'"):lines() do
				if line:match("Name=") and name == entry then
					name = line:gsub("Name=", "")
				end
				if line:match("Exec=") and exec == nil then
					local cmd = line:gsub("Exec=", "")
					exec = function() awful.spawn.with_shell(cmd) end
				end
				if line:match("Icon=") then
					icon = appicons .. "apps/" .. line:gsub("Icon=", "") .. ".svg"
				end
			end
			table.insert(shortcuts, { name = name, icon = icon, exec = exec })
		elseif os.execute("cd ~/Desktop/" .. entry) then
			icon = foldericons .. "folder.svg"
			exec = function() awful.spawn.with_shell(files " Desktop/" .. entry) end
			table.insert(folders, { name = name, icon = icon, exec = exec })
		else
			exec = function() awful.spawn.with_shell("xdg-open " .. os.getenv("HOME") .. "/Desktop/" .. name) end
			table.insert(files, { name = name, icon = icon, exec = exec })
		end
	end

	for _, entry in ipairs(shortcuts) do
		table.insert(entries, entry)
	end
	for _, entry in ipairs(folders) do
		table.insert(entries, entry)
	end
	for _, entry in ipairs(files) do
		table.insert(entries, entry)
	end
	
	return entries
end


local function refresh()
	entries:reset()

	local dentries = gen()

	for _, entry in ipairs(dentries) do
		local widget = hovercursor(wibox.widget {
			{
				{
					image = entry.icon,
					halign = "center",
					widget = wibox.widget.imagebox
				},
				strategy = "exact",
				width = dpi(50),
				height = dpi(50),
				widget = wibox.container.constraint
			},
			{
				{
					{
						text = entry.name,
						valign = "top",
						align = "center",
						widget = wibox.widget.textbox
					},
					margins = dpi(5),
					widget = wibox.container.margin
				},
				strategy = "max",
				width = dpi(100),
				height = dpi(50),
				widget = wibox.container.constraint
			},
			buttons = {
				awful.button({}, 1, entry.exec)
			},
			spacing = dpi(5),
			layout = wibox.layout.fixed.vertical
		})
		entries:add(widget)
	end
end

refresh()

awesome.connect_signal("signal::desktop", function() 
	refresh() 
end)
