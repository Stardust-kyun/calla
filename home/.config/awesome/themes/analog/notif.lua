local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local naughty = require "naughty"
local wibox = require "wibox"

rrect = function(radius)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, radius)
  end
end

naughty.config.defaults.ontop = true
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 10
naughty.config.defaults.title = "Notification"
naughty.config.defaults.position = "top_right"

naughty.config.presets.normal = {
  font = beautiful.font,
  fg = beautiful.fg_normal,
  bg = beautiful.bg_normal,
}

naughty.config.presets.low = {
  font = beautiful.font,
  fg = beautiful.fg_normal,
  bg = beautiful.bg_normal,
}

naughty.config.presets.ok = naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical

naughty.connect_signal("request::display", function(n)
  local appicon = n.app_icon
  if not appicon then
    appicon = beautiful.layout_floating
  end
  local time = os.date "%H:%M"

  local action_widget = {
    {
      {
        id = "text_role",
        align = "center",
        valign = "center",
        font = beautiful.font,
        widget = wibox.widget.textbox,
      },
      left = 6,
      right = 6,
      widget = wibox.container.margin,
    },
    bg = beautiful.bg_normal,
    forced_height = 25,
    forced_width = 20,
    shape = rrect(9),
    widget = wibox.container.background,
  }

  local actions = wibox.widget {
    notification = n,
    base_layout = wibox.widget {
      spacing = 8,
      layout = wibox.layout.flex.horizontal,
    },
    widget_template = action_widget,
    style = { underline_normal = false, underline_selected = true },
    widget = naughty.list.actions,
  }

  naughty.layout.box {
    notification = n,
    type = "notification",
    bg = "#ffffff00",
    widget_template = {
      {
        {
          {
            {
              {
                {
                  {
                    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                    speed = 50,
                    {
                      markup = "<span weight='bold'>" .. n.title .. "</span>",
                      font = beautiful.font,
                      align = "left",
                      widget = wibox.widget.textbox,
                    },
                    -- forced_width = dpi(204),
                    widget = wibox.container.scroll.horizontal,
                  },
                  {
                    markup = n.message,
                    align = "left",
                    font = beautiful.font,
                    widget = wibox.widget.textbox,
                  },
                  spacing = 5,
                  layout = wibox.layout.flex.vertical,
                },
                layout = wibox.layout.align.vertical,
              },
              {
                { actions, layout = wibox.layout.fixed.vertical },
                margins = 10,
                visible = n.actions and #n.actions > 0,
                widget = wibox.container.margin,
              },
              layout = wibox.layout.fixed.vertical,
            },
            expand = "none",
            layout = wibox.layout.align.vertical,
          },
          top = 20,
          bottom = 20,
          left = 25,
          right = 25,
          widget = wibox.container.margin,
        },
        strategy = "max",
        width = 1000,
        height = 240,
        widget = wibox.container.constraint,
      },
      border_width = 2,
      border_color = beautiful.border_color_normal,
      widget = wibox.container.background,
      bg = beautiful.bg_normal,
      margins = 10,
    },
  }
end)
