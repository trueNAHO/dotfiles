-- Standard awesome library
-- @since 1.0
local awful_spawn = require("awful").spawn
local gears_math_round = require("gears").math.round
local wibox_widget_textbox = require("wibox").widget.textbox

-- Self-made library
-- @since 1.0
local require_table = require("require-table")

-- Self-made library
-- @since 1.0
local File_read = require(require_table.File).read
local Pid_manage = require(require_table.Pid).manage
local config_brightness = require(require_table.config).brightness

return setmetatable({}, {__call = function()

    local widget_brightness = wibox_widget_textbox(
        gears_math_round(tonumber(File_read(config_brightness.file)) / 10)
    )

    -- Widget's watcher
    Pid_manage(awful_spawn.with_line_callback(
        "inotifywait -mqe modify " .. config_brightness.file,
        {
            stdout = function()
                local brightness = gears_math_round(
                    tonumber(File_read(config_brightness.file)) / 10
                )
                if brightness < config_brightness.minimum then
                    awful_spawn.easy_async(
                        "xbacklight -set " .. config_brightness.minimum,
                        function() end
                    )
                else
                    widget_brightness.text = brightness
                end
            end
        }
    ))

    return widget_brightness

end})
