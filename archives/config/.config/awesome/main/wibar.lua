-- Global variables
-- @since 1.0
local mouse = mouse

-- Standard awesome library
-- @since 1.0
local awful = require("awful")
local beautiful_useless_gap = require("beautiful").useless_gap
local gears = require("gears")
local gears_timer_start_new = gears.timer.start_new
local naughty_notify = require("naughty").notify
local wibox = require("wibox")

-- Self-made library
-- @since 1.0
local require_table = require("require-table")

-- Self-made library
-- @since 1.0
local Mode = require(require_table.Mode)
local Sharedtags_tags = require(require_table.Sharedtags).tags
local Wibar_widgets = function() return require(require_table.wibar).widgets end
local Widget_battery = require(require_table.widget_battery)
local Widget_brightness = require(require_table.widget_brightness)
local Widget_date = require(require_table.widget_date)
local Widget_volume = require(require_table.widget_volume)
local colors = require(require_table.colors)
local config = require(require_table.config)
local config_wibar_position = require(require_table.config).wibar.position

--{{{ Variable: widgets_modes_html

local widgets_modes_html = "<span foreground='%s'><b>%%s</b></span>"

--}}}

--{{{ Variable: widgets

local widgets = {
    battery = Widget_battery(),
    brightness_icon = wibox.widget.textbox("盛"),
    brightness_value = Widget_brightness(),
    date = Widget_date(),
    modes = Mode{

        capture = {
            name = config.mode.modes.capture.name,
            html = (widgets_modes_html):format(config.mode.modes.capture.color),
            callback = function()
                local screen_geo = awful.screen.focused().geometry
                local function notification(message)
                    naughty_notify{
                        title = config.mode.modes.capture.name, text = message
                    }
                end
                mouse.coords{
                    x = screen_geo.x + screen_geo.width / 2,
                    y = screen_geo.y + screen_geo.height / 2
                }
                awful.spawn.with_line_callback(
                    config.commands.capture,
                    {
                        stdout = function(stdout) notification(stdout) end,
                        stderr = function(stderr) notification(stderr) end,
                        exit = function()
                            Mode.remove(Wibar_widgets().modes, "capture")
                        end
                    }
                )
            end,
            exit = function()
                -- Wait before hiding mouse for convenience reasons
                gears.timer.start_new(
                    config.mouse.wait,
                    function()
                        local screen_geo = awful.screen.focused().geometry
                        mouse.coords(
                            {
                                x = screen_geo.x + screen_geo.width,
                                y = screen_geo.y + screen_geo.height
                            },
                            true
                        )
                    end
                )
            end
        },

        mouse = {
            name = config.mode.modes.mouse.name,
            html = (widgets_modes_html):format(config.mode.modes.mouse.color),
            callback = function()
                local screen_geo = awful.screen.focused().geometry
                mouse.coords{
                    x = screen_geo.x + screen_geo.width / 2,
                    y = screen_geo.y + screen_geo.height / 2
                }
                awful.spawn.easy_async(
                    config.commands.xmouseless,
                    function()
                        local screen_geo = awful.screen.focused().geometry
                        mouse.coords(
                            {
                                x = screen_geo.x + screen_geo.width,
                                y = screen_geo.y + screen_geo.height
                            },
                            true
                        )
                        Mode.remove(Wibar_widgets().modes, "mouse")
                    end
                )
            end
        },

        passmenu = {
            name = config.mode.modes.passmenu.name,
            html = (widgets_modes_html):format(config.mode.modes.passmenu.color),
            callback = function()
                awful.spawn.easy_async(
                    config.commands.passmenu,
                    function()
                        Mode.remove(Wibar_widgets().modes, "passmenu")
                    end
                )
            end
        },
    },

    percent_sign = wibox.widget.textbox("%"),
    volume_icon = wibox.widget.textbox("墳"),
    volume_value = Widget_volume()
}

--}}}

--{{{ Variable: seperators

local seperators = {
    screen_edge = {
        layout = wibox.container.constraint,
        strategy = "min",
        width = beautiful_useless_gap * 2
    },
    small = {
        layout = wibox.container.constraint,
        strategy = "min",
        width = 4
    },
    tiny = {
        layout = wibox.container.constraint,
        strategy = "min",
        width = 2
    },
    widget = {
        layout = wibox.container.constraint,
        strategy = "min",
        width = 30
    }
}

--}}}

--{{{ Wibar

awful.screen.connect_for_each_screen(function(s)

    s.wibar = awful.wibar{
        position = config_wibar_position,
        screen = s
    }

    s.wibar:setup{

        layout = wibox.layout.align.horizontal,

        -- Left widgets
        {
            layout = wibox.layout.fixed.horizontal,
            seperators.screen_edge,
            awful.widget.taglist{
                filter  = awful.widget.taglist.filter.all,
                screen  = s,
                source = function() return Sharedtags_tags end
            },
            seperators.widget,
            widgets.modes
        },

        -- Middle widgets
        nil,

        -- Right widgets
        {
            layout = wibox.layout.fixed.horizontal,
            ----wibox.widget.systray(),
            ----seperators.widget,
            widgets.brightness_icon,
            seperators.small,
            widgets.brightness_value,
            seperators.tiny,
            widgets.percent_sign,
            seperators.widget,
            widgets.volume_icon,
            seperators.small,
            widgets.volume_value,
            seperators.tiny,
            widgets.percent_sign,
            seperators.widget,
            widgets.battery.icon,
            seperators.small,
            widgets.battery.value,
            seperators.tiny,
            widgets.percent_sign,
            seperators.widget,
            widgets.date.day,
            seperators.widget,
            widgets.date.time,
            seperators.widget,
            awful.widget.layoutbox(s),
            seperators.screen_edge
        },

    }

end)

--}}}

return {
    update = function() widgets.battery.callback() widgets.date.callback() end,
    widgets = widgets
}
