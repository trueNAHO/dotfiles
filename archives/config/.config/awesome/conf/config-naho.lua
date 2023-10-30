--[[
"Update intervals also play a big role, and you can save a lot of power with
a smart approach. Don’t use intervals like: 5, 10, 30, 60, etc. to avoid
harmonics. If you take the 60-second mark as an example, all of your widgets
would be executed at that point. Instead think about using only prime numbers,
in that case you will have only a few widgets executed at any given time
interval."

@url  https://vicious.readthedocs.io/en/latest/caching.html
--]]

-- Standard awesome library
-- @since 1.0
local awful_layout_suit = require("awful").layout.suit
local gears_filesystem_get_cache_dir = require(
    "gears").filesystem.get_cache_dir()

-- Self-made library
-- @since 1.0
local colors = require(require("require-table").colors)

local font_mono = "fira code"

local dmenu_options = (
    "-i -l %d -p '%s' -fn '%s' -nb '%s' -nf '%s' -sb '%s' -sf '%s'"
    ):format(
    17,
    "Run",
    font_mono,
    colors.black.normal,
    colors.white.normal,
    colors.blue.dim,
    colors.white.normal
)
local layouts = {
    awful_layout_suit.tile,
    awful_layout_suit.corner.nw,
    awful_layout_suit.max
}
local os_getenv_home = os.getenv("HOME")

return {
    audio_increment = 5,
    battery = {
        file = {
            capacity = "/sys/class/power_supply/BAT1/capacity",
            charge_full = "/sys/class/power_supply/BAT1/charge_full",
            charge_now = "/sys/class/power_supply/BAT1/charge_now",
            current_now = "/sys/class/power_supply/BAT1/current_now",
            status = "/sys/class/power_supply/BAT1/status",
        },
        icon = {
            charging = "",
            discharging = "",
        },
        notify_interval = 5,
        status = {
            critical = 40,
            low = 66
        },
        timeout_charge_device = 60,
        update_time = 67,
    },
    brightness = {
        file = "/sys/class/backlight/intel_backlight/device/intel_backlight/brightness",
        increment = 5,
        minimum = 1,
    },
    client_increment = {horizontal = 0.01, vertical = 0.03},
    ----collectgarbage = {update_time = 3607, wait = 10, wait_multiply = 2},
    collectgarbage = {update_time = 360007, wait = 10, wait_multiply = 2},
    commands = {
        capture =  os_getenv_home .. "/p/scripts/capture",
        capture_fullscreen = os_getenv_home .. "/p/scripts/capture -f",
        dmenu_run = "dmenu_run " .. dmenu_options,
        passmenu = "passmenu " .. dmenu_options,
        systemctl_suspend = "systemctl suspend",
        wallpaper = os_getenv_home .. "/p/scripts/feh-default-bg",
        xmouseless = "xmouseless"
    },
    commands_startup = {"picom"},
    date = {update_time = 61},
    editor = os.getenv("EDITOR") or "nvim",
    font = {mono = font_mono, size = 9},
    hotkeys_groups = {
        awesome = "awesome",
        clients = "Clients",
        layout = "Layout",
        run = "Run",
        system = "System",
        tags = "Tags"
    },
    key = {leader = "Mod4", mod1 = "Mod1", mod3 = "Mod3", shift = "Shift"},
    layouts = layouts,
    mouse = {wait = 1},
    mode = {
        concat = ", ",
        modes = {
            capture = {color = colors.green.normal, name = "capture"},
            mouse = {color = colors.blue.normal, name = "mouse"},
            passmenu = {color = colors.red.normal, name = "passmenu"}
        }
    },
    pid_full_path = ("%s%s.%s"):format(
        gears_filesystem_get_cache_dir, os.getenv("USER"), "pid"
    ),
    sharedtags_tags = {
        {name = 1, layout = layouts[1]},
        {name = 2, layout = layouts[1]},
        {name = 3, layout = layouts[1]},
        {name = 4, layout = layouts[1]},
        {name = 5, layout = layouts[1]},
        {name = 6, layout = layouts[1]},
        {name = 7, layout = layouts[1]},
        {name = 8, layout = layouts[1]},
        {name = 9, layout = layouts[1]}
    },
    systemctl_suspend = {wait = 5},
    terminal = "alacritty",
    wallpaper = {update_time = 601},
    wibar = {position = "top"}
}
