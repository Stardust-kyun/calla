--[[ L O C K ]]

local awful       = require("awful")
local beautiful   = require("beautiful")
local dpi         = beautiful.xresources.apply_dpi
local gears       = require("gears")
local helpers     = require("helpers")
local lock_screen = require("layout.lockscreen")
local wibox       = require("wibox")

-- MISC / VARS
local lock_screen_symbol = ""
local lock_screen_fail_symbol = ""

-- Widgets
local profile_image = wibox.widget {
  {
    image   = beautiful.images.profile,
    upscale = true,
    forced_width  = dpi(160),
    forced_height = dpi(160),
    clip_shape    = gears.shape.circle,
    widget = wibox.widget.imagebox,
    halign = "center",
  },
  widget = wibox.container.background,
  border_width = dpi(2),
  shape = gears.shape.circle,
  border_color = beautiful.fg
}

local username = wibox.widget{
  widget = wibox.widget.textbox,
  markup = c.username,
  font   = "BitStream 15",
  align  = "center",
  valign = "center"
}

local myself = wibox.widget{
  profile_image,
  username,
  spacing = dpi(15),
  layout  = wibox.layout.fixed.vertical
}

-- Dummy text
local some_textbox = wibox.widget.textbox()

-- lock icon
local icon = wibox.widget{
  widget = wibox.widget.textbox,
  markup = lock_screen_symbol,
  font   = "Hack 14",
  align  = "center",
  valign = "center"
}

-- Clock
local clock = wibox.widget{
  helpers.vertical_pad(dpi(40)),
  {
    font   = "BitStream Medium 42",
    format = helpers.colorize_text("%I:%M", beautiful.fg),
    widget = wibox.widget.textclock,
    align  = "center",
    valign = "center"
  },
  {
    font   = "Hack Regular 18",
    format = helpers.colorize_text("%A, %B", beautiful.fg),
    widget = wibox.widget.textclock,
    align  = "center",
    valign = "center"
  },
  spacing = dpi(10),
  layout = wibox.layout.fixed.vertical
}

-- Password prompt
local promptbox = wibox.widget{
  widget = wibox.widget.textbox,
  markup = "",
  font   = "BitStream 13",
  align  = "center"
}

local promptboxfinal = wibox.widget{
    {
        {
            {
                promptbox,
                margins = {left = dpi(10)},
                widget = wibox.container.margin
            },
            nil,
            {
                icon,
                margins = {right = dpi(10)},
                widget = wibox.container.margin
            },
            layout = wibox.layout.align.horizontal,
            expand = "none"
        },
        widget = wibox.container.margin,
        margins = dpi(10)
    },
    widget = wibox.container.background,
    bg = beautiful.fg .. "1A",
    forced_width = dpi(300),
    forced_height = dpi(40),
    shape = gears.shape.rounded_bar
}

-- Create the lock screen wibox
local lock_screen_box = wibox({
  ontop = true,
  type  = "splash",
  bg = beautiful.bg .. "99",
  fg = beautiful.fg,
  visible = false,
  screen  = screen.primary
})

-- Create the lock screen wibox (extra)
local function create_extender(s)

  local lock_screen_box_ext wibox({
    ontop = true,
    type  = "splash",
    bg = beautiful.bg .. "E6",
    fg = beautiful.fg,
    visible = false,
    screen  = s
  })

  awful.placement.maximize(lock_screen_box_ext)

  return lock_screen_box_ext

end

awful.placement.maximize(lock_screen_box)

-- Add lockscreen to each screen
awful.screen.connect_for_each_screen(function(s)
  if s.index == 2 then
    s.mylockscreenext = create_extender(2)
    s.mylockscreen = lock_screen_box
  else
    s.mylockscreen = lock_screen_box
  end
end)

local function set_visibility(v)
  for s in screen do
    s.mylockscreen.visible = v
    if s.mylockscreenext then
      s.mylockscreenext.visible = v
    end
  end
end

-- Lock helper functions
local characters_entered = 0

-- Reset function
local function reset()
  characters_entered = 0;
  promptbox.markup = helpers.colorize_text("", beautiful.urgent)
  icon.markup = lock_screen_symbol
end

-- Fail function
local function fail()
  characters_entered = 0;
  promptbox.markup = helpers.colorize_text("Incorrect", beautiful.urgent)
  icon.markup = lock_screen_fail_symbol
end

-- User input
local function grab_password()
  awful.prompt.run {
    hooks = {
      {{ }, 'Escape', function(_)
        reset()
        grab_password()
      end
      },
      {{ 'Control' }, 'Delete', function()
        reset()
        grab_password()
      end}
    },
    keypressed_callback  = function(mod, key, cmd)
      if #key == 1 then
        characters_entered = characters_entered + 1
        promptbox.markup = helpers.colorize_text(string.rep("", characters_entered), beautiful.fg)
      elseif key == "BackSpace" then
        if characters_entered > 0 then
          characters_entered = characters_entered - 1
        end
        promptbox.markup = helpers.colorize_text(string.rep("", characters_entered), beautiful.fg)
      end
    end,

    exe_callback = function(input)
      -- compare input
      if lock_screen.authenticate(input) then
        -- YAY 
        reset()
        set_visibility(false)
      else
        -- NAH, JIT TRIPPIN
        fail()
        grab_password()
      end
    end,
    textbox = some_textbox,
    }
end

-- Show lockscreen func
function lock_screen_show()
  set_visibility(true)
  grab_password()
end

-- INIT
lock_screen_box:setup {
  {
    clock,
    {
      myself,
      {
        {
          promptboxfinal,
          layout = wibox.layout.fixed.horizontal,
        },
        layout = wibox.container.place
      },
      layout = wibox.layout.fixed.vertical,
      spacing = dpi(50)
    },
    layout = wibox.layout.align.vertical,
    expand = "none"
  },
  layout = wibox.layout.stack
}
