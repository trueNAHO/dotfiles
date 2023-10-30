-- Standard awesome library
-- @since 1.0
local awful_spawn_easy_async = require("awful").spawn.easy_async
local gears = require("gears")
local naughty_notify = require("naughty").notify
local wibox_widget_textbox = require("wibox").widget.textbox

-- Self-made library
-- @since 1.0
local require_table = require("require-table")

-- Self-made library
-- @since 1.0
local File_read = require(require_table.File).read
local Wibar_update = function() require(require_table.wibar).update() end
local config = require(require_table.config)

return setmetatable({}, {__call = function()

    -- Initialise maximum battery value for timer
    local battery_previous_capacity_notified = 100

    local widget_icon = wibox_widget_textbox("?")
    local widget_value = wibox_widget_textbox("BATTERY")

    local function callback()

        local capacity = tonumber(File_read(config.battery.file.capacity))
        local status = File_read(config.battery.file.status)

        widget_value.text = capacity
        widget_icon.text = status == "Discharging" and
            config.battery.icon.discharging or
            config.battery.icon.charging

        if capacity > battery_previous_capacity_notified then
            battery_previous_capacity_notified = capacity
        end

        if status == "Charging" then return end

        if capacity <= config.battery.status.critical then

            naughty_notify{
                title = "System information",
                text = (
                    "[BATTERY]: %s%%\nSuspending system in %d seconds. Charge device to abort."
                ):format(capacity, config.battery.timeout_charge_device)
            }

            local seconds_elapsed = 0
            gears.timer.start_new(
                1,
                function()

                    local battery_status = File_read(config.battery.file.status)

                    if seconds_elapsed < config.battery.timeout_charge_device
                        and battery_status == "Discharging"
                    then
                        seconds_elapsed = seconds_elapsed + 1
                        return true
                    end

                    -- Checking the battery value again in order to consider the
                    -- edge case where the device gets suspended during the
                    -- timer and was charged
                    if battery_status == "Discharging"
                        and tonumber(File_read(config.battery.file.capacity)) <=
                        config.battery.status.critical
                    then
                        awful_spawn_easy_async(
                            config.commands.systemctl_suspend, function() end
                        )
                    else
                        naughty_notify{
                            title = "System information",
                            text = "Device successfully charged. Device will not be suspended."
                        }
                    end

                    gears.timer.start_new(
                        config.systemctl_suspend.wait, Wibar_update()
                    )

                end
            )

        elseif capacity <= config.battery.status.low
            and battery_previous_capacity_notified - capacity >=
            config.battery.notify_interval
        then

            battery_previous_capacity_notified = capacity
            local time_left

            if status == "Discharging" then
                time_left = tonumber(File_read(
                    config.battery.file.charge_now
                    )) / tonumber(File_read(
                    config.battery.file.current_now
                ))
            else
                time_left = (tonumber(File_read(
                    config.battery.file.charge_full
                    )) - tonumber(File_read(
                    config.battery.file.charge_now
                    ))) / tonumber(File_read(
                    config.battery.file.current_now
                ))
            end

            local time_left_hrs = math.floor(time_left)
            local time_left_min = gears.math.round(
                ((time_left - time_left_hrs) % 60) * 60
            )
            local str_time_left = (
                time_left_hrs > 0 and time_left_hrs .. "h " or ""
            ) .. time_left_min .. "m"

            naughty_notify{
                title = "System information",
                text = (
                    "[BATTERY]: %d%%\n[STATUS]: %s\n[TIME LEFT]: %s"
                ):format(capacity, status, str_time_left)
            }

        end

    end

    gears.timer{
        autostart = true,
        call_now  = true,
        callback  = callback,
        timeout   = config.battery.update_time
    }

    return {callback = callback, icon = widget_icon, value = widget_value}

end})
