-- Global variables
-- @since 1.0
local awesome = awesome
local client = client
local mouse = mouse
local root = root

-- Standard awesome library
-- @since 1.0
local awful = require("awful")
local gears = require("gears")
local hotkeys_popup_show_help = require("awful.hotkeys_popup").show_help
local naughty = require("naughty")

-- Self-made library
-- @since 1.0
local require_table = require("require-table")

-- Self-made library
-- @since 1.0
local Mode_add = require(require_table.Mode).add
local Sharedtags = require(require_table.Sharedtags)
local Wallpaper = require(require_table.wallpaper)
local Wibar = require(require_table.wibar)
local config = require(require_table.config)
local menu_main = require(require_table.menu_main)

local awful_key = awful.key
local key_leader = config.key.leader

local keys = gears.table.join(

    --{{{ 'awesome'

    awful_key(
        {key_leader, config.key.mod3, config.key.shift}, "h",
        hotkeys_popup_show_help,
        {
            group = config.hotkeys_groups.awesome,
            description = "Open help menu"
        }
    ),

    awful_key(
        {key_leader, config.key.mod3, config.key.shift}, "m",
        function() menu_main:toggle() end,
        {
            group = config.hotkeys_groups.awesome,
            description = "Open main menu"
        }
    ),

    awful_key(
        {key_leader, config.key.mod3, config.key.shift}, "q",
        awesome.quit,
        {
            group = config.hotkeys_groups.awesome,
            description = "Quit 'awesome'"
        }
    ),

    awful_key(
        {key_leader, config.key.mod3, config.key.shift}, "r",
        awesome.restart,
        {
            group = config.hotkeys_groups.awesome,
            description = "Reload 'awesome'"
        }
    ),

    --}}}

    --{{{ Layout

    awful_key(
        {key_leader, config.key.mod1}, "l",
        function() awful.tag.incnmaster(1, nil, true) end,
        {
            group = config.hotkeys_groups.layout,
            description = "Increase number of master windows"
        }
    ),

    awful_key(
        {key_leader, config.key.mod1}, "h",
        function() awful.tag.incnmaster(-1, nil, true) end,
        {
            group = config.hotkeys_groups.layout,
            description = "Decrease number of master windows"
        }
    ),

    awful_key(
        {key_leader, config.key.mod1}, "j",
        function() awful.tag.incncol(1, nil, true) end,
        {
            group = config.hotkeys_groups.layout,
            description = "Increase number of slave windows"
        }
    ),

    awful_key(
        {key_leader, config.key.mod1}, "k",
        function() awful.tag.incncol(-1, nil, true) end,
        {
            group = config.hotkeys_groups.layout,
            description = "Decrease number of slave windows"
        }
    ),

    awful_key(
        {key_leader, config.key.mod1}, "n",
        function() awful.layout.inc(1) end,
        {
            group = config.hotkeys_groups.layout,
            description = "Cycle to next layout"
        }
    ),

    awful_key(
        {key_leader, config.key.mod1}, "p",
        function() awful.layout.inc(-1) end,
        {
            group = config.hotkeys_groups.layout,
            description = "Cycle to previous layout"
        }
    ),

    awful_key(
        {key_leader, config.key.mod1}, "b",
        function()
            local screen_focused = awful.screen.focused()
            screen_focused.wibar.visible = not screen_focused.wibar.visible
        end,
        {
            group = config.hotkeys_groups.layout,
            description = "Toggle visibility for widget bar on focused screen"
        }
    ),

    awful_key(
        {key_leader, config.key.mod1, config.key.shift}, "b",
        function()
            local wibar_visible = not awful.screen.focused().wibar.visible
            awful.screen.connect_for_each_screen(
                function(s) s.wibar.visible = wibar_visible end
            )
        end,
        {
            group = config.hotkeys_groups.layout,
            description = "Toggle visibility for widget bar on all screens"
        }
    ),

    awful_key(
        {key_leader, config.key.mod1}, "c",
        naughty.destroy_all_notifications,
        {
            group = config.hotkeys_groups.layout,
            description = "Clear all notifications"
        }
    ),

    awful_key(
        {key_leader, config.key.mod1}, "w",
        Wallpaper,
        {
            group = config.hotkeys_groups.layout,
            description = "Change wallpapers"
        }
    ),

    --}}}

    --{{{ Run

    awful_key(
        {key_leader}, "Return",
        function()
            awful.spawn.easy_async(config.terminal, function() end)
        end,
        {
            group = config.hotkeys_groups.run,
            description = ("Open terminal ('%s')"):format(config.terminal)
        }
    ),

    awful_key(
        {key_leader}, "r",
        function()
            awful.spawn.easy_async(config.commands.dmenu_run, function() end)
        end,
        {
            group = config.hotkeys_groups.run,
            description = "Run 'dmenu_run'"
        }
    ),

    awful_key(
        {key_leader}, "p",
        function() Mode_add(Wibar.widgets.modes, "passmenu") end,
        {
            group = config.hotkeys_groups.run,
            description = "Run 'passmenu'"
        }
    ),

    awful_key(
        {key_leader}, "c",
        function() Mode_add(Wibar.widgets.modes, "capture") end,
        {
            group = config.hotkeys_groups.run,
            description = "Screenshot selected area"
        }
    ),

    awful_key(
        {key_leader, config.key.shift}, "c",
        function()
            local function notification(str)
                naughty.notify{title = "Capture", text = str}
            end
            awful.spawn.with_line_callback(
                config.commands.capture_fullscreen,
                {
                    stdout = function(stdout) notification(stdout) end,
                    stderr = function(stderr) notification(stderr) end,
                }
            )
        end,
        {
            group = config.hotkeys_groups.run,
            description = "Screenshot entire screen"
        }
    ),

    --}}}

    --{{{ System

    awful_key(
        {key_leader}, "m",
        function() Mode_add(Wibar.widgets.modes, "mouse") end,
        {
            group = config.hotkeys_groups.system,
            description = "Control the mouse with your keyboard"
        }
    ),

    awful_key(
        {key_leader, config.key.shift}, "m",
        function()
            local screen_geo = awful.screen.focused().geometry
            mouse.coords(
                {
                    x = screen_geo.x + screen_geo.width,
                    y = screen_geo.y + screen_geo.height
                },
                true
            )
        end,
        {
            group = config.hotkeys_groups.system,
            description = "Move mouse to bottom right corner of focused screen"
        }
    ),

    awful_key(
        {key_leader}, "s",
        function()
            awful.spawn.easy_async(
                config.commands.systemctl_suspend,
                function()
                    gears.timer.start_new(
                        config.systemctl_suspend.wait, Wibar.update
                    )
                end
            )
        end,
        {
            group = config.hotkeys_groups.system,
            description = "Suspend system"
        }
    ),

    awful_key(
        {key_leader}, "Up",
        function()
            awful.spawn.easy_async(
                "xbacklight -inc " .. config.brightness.increment,
                function() end
            )
        end,
        {
            group = config.hotkeys_groups.system,
            description = ("Increase hardware brightness by %d%%"):format(
                config.brightness.increment
            )
        }
    ),

    awful_key(
        {key_leader}, "Down",
        function()
            awful.spawn.easy_async(
                "xbacklight -dec " .. config.brightness.increment,
                function() end
            )
        end,
        {
            group = config.hotkeys_groups.system,
            description = ("Decrease hardware brightness by %d%%"):format(
                config.brightness.increment
            )
        }
    ),

    awful_key(
        {key_leader}, "Right",
        function()
            awful.spawn.easy_async(
                ("amixer -q sset Master %d%%+"):format(
                    config.audio_increment
                ),
                function() end
            )
        end,
        {
            group = config.hotkeys_groups.system,
            description = ("Increase master volume by %d%%"):format(
                config.audio_increment
            )
        }
    ),

    awful_key(
        {key_leader}, "Left",
        function()
            awful.spawn.easy_async(
                ("amixer -q sset Master %d%%-"):format(
                    config.audio_increment
                ),
                function() end
            )
        end,
        {
            group = config.hotkeys_groups.system,
            description = ("Decrease master volume by %d%%"):format(
                config.audio_increment
            )
        }
    ),

    --}}}

    --{{{ Clients

    awful_key(
        {key_leader}, "h",
        function() awful.client.focus.global_bydirection("left") end,
        {
            group = config.hotkeys_groups.clients,
            description = "Move focus to client at the left"
        }
    ),

    awful_key(
        {key_leader}, "j",
        function() awful.client.focus.global_bydirection("down") end,
        {
            group = config.hotkeys_groups.clients,
            description = "Move focus to client below"
        }
    ),

    awful_key(
        {key_leader}, "k",
        function() awful.client.focus.global_bydirection("up") end,
        {
            group = config.hotkeys_groups.clients,
            description = "Move focus to client above"
        }
    ),

    awful_key(
        {key_leader}, "l",
        function() awful.client.focus.global_bydirection("right") end,
        {
            group = config.hotkeys_groups.clients,
            description = "Move focus to client at the right"
        }
    ),

    awful_key(
        {key_leader, config.key.shift}, "h",
        function() awful.client.swap.global_bydirection("left") end,
        {
            group = config.hotkeys_groups.clients,
            description = "Move focussed client to the left"
        }
    ),

    awful_key(
        {key_leader, config.key.shift}, "j",
        function() awful.client.swap.global_bydirection("down") end,
        {
            group = config.hotkeys_groups.clients,
            description = "Move focussed client down"
        }
    ),

    awful_key(
        {key_leader, config.key.shift}, "k",
        function() awful.client.swap.global_bydirection("up") end,
        {
            group = config.hotkeys_groups.clients,
            description = "Move focussed client up"
        }
    ),

    awful_key(
        {key_leader, config.key.shift}, "l",
        function() awful.client.swap.global_bydirection("right") end,
        {
            group = config.hotkeys_groups.clients,
            description = "Move focussed client to the right"
        }
    ),

    awful_key(
        {key_leader, config.key.mod3}, "l",
        function()
            awful.tag.incmwfact(config.client_increment.horizontal)
        end,
        {
            group = config.hotkeys_groups.clients,
            description = "Increase master client size"
        }
    ),

    awful_key(
        {key_leader, config.key.mod3}, "h",
        function()
            awful.tag.incmwfact(-config.client_increment.horizontal)
        end,
        {
            group = config.hotkeys_groups.clients,
            description = "Decrease master client size"
        }
    ),

    awful_key(
        {key_leader, config.key.mod3}, "j",
        function()
            awful.client.incwfact(config.client_increment.vertical)
        end,
        {
            group = config.hotkeys_groups.clients,
            description = "Increase slave client size"
        }
    ),

    awful_key(
        {key_leader, config.key.mod3}, "k",
        function()
            awful.client.incwfact(-config.client_increment.vertical)
        end,
        {
            group = config.hotkeys_groups.clients,
            description = "Decrease slave client size"
        }
    )

    --}}}

)

--{{{ Tags

-- Bind keybindings to tags. Note that we use key codes to make it work on
-- any keyboard layout. This should map on the top row of your keyboard,
-- usually '1' to '9'.
for i, _ in ipairs(Sharedtags.tags) do

    keys = gears.table.join(

        keys,

        awful_key(
            {key_leader}, "#" .. i + 9,
            function()
                local tag = Sharedtags.tags[i]
                if tag then Sharedtags.view(tag) end
            end,
            {
                group = config.hotkeys_groups.tags,
                description = "View tag"
            }
        ),

        awful_key(
            {key_leader, config.key.mod1}, "#" .. i + 9,
            function()
                local tag = Sharedtags.tags[i]
                if tag then Sharedtags.view(tag, nil, true) end
            end,
            {
                group = config.hotkeys_groups.tags,
                description = "View tag (always on current screen)"
            }
        ),

        awful_key(
            {key_leader, config.key.mod1, config.key.mod3}, "#" .. i + 9,
            function()
                local tag = Sharedtags.tags[i]
                if tag then Sharedtags.toggle(tag) end
            end,
            {
                group = config.hotkeys_groups.tags,
                description = "Toggle visibility for tag"
            }
        ),

        awful_key(
            {key_leader, config.key.shift}, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = Sharedtags.tags[i]
                    if tag then client.focus:move_to_tag(tag) end
                end
            end,
            {
                group = config.hotkeys_groups.tags,
                description = "Move focussed window to tag"
            }
        ),

        awful_key(
            {key_leader, config.key.mod1, config.key.shift}, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = Sharedtags.tags[i]
                    if tag then client.focus:toggle_tag(tag) end
                end
            end,
            {
                group = config.hotkeys_groups.tags,
                description = "Clone focussed window to tag"
            }
        )

    )

end

--}}}

root.keys(keys)
