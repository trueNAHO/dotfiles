-- Standard awesome library
-- @since 1.0
local awful_spawn = require("awful").spawn
local wibox_widget_textbox = require("wibox").widget.textbox

-- Self-made library
-- @since 1.0
local Pid_manage = require(require("require-table").Pid).manage

return setmetatable({}, {__call = function()

    local widget_volume = wibox_widget_textbox("VOLUME")

    -- Initialise widget's value
    awful_spawn.easy_async(
        "amixer get Master",
        function(stdout) widget_volume.text = stdout:match("(%d+)%%") end
    )

    -- Widget's watcher
    Pid_manage(awful_spawn.with_line_callback(
        "pactl subscribe",
        {
            stdout = function(pactl)
                if pactl:find(" sink ", 1, true) then
                    awful_spawn.with_line_callback(
                        "amixer get Master",
                        {
                            stdout = function(amixer)
                                widget_volume.text = amixer:match("(%d+)%%")
                            end
                        }
                    )
                end
            end
        }
    ))

    return widget_volume

end})
