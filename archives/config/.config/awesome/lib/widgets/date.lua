-- Standard awesome library
-- @since 1.0
local gears = require("gears")
local wibox_widget_textbox = require("wibox").widget.textbox

-- Self-made library
-- @since 1.0
local config_date_update_time = require(
    require("require-table").config).date.update_time

return setmetatable({}, {__call = function()

    local widget_day = wibox_widget_textbox("DAY")
    local widget_time = wibox_widget_textbox("TIME")

    local function callback()
        local date = gears.string.split(os.date("%A, %d-%m-%Y %H:%M"), " ")
        widget_day.text = date[1] .. " " .. date[2]
        widget_time.text = date[3]
    end

    gears.timer{
        autostart = true,
        call_now  = true,
        callback  = callback,
        timeout   = config_date_update_time
    }

    return {callback = callback, day = widget_day, time = widget_time}

end})
