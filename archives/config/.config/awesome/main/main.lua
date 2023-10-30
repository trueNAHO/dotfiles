-- TODO: XXX To be reconsidered if this should realy be implemented XXX replace
-- the 'require_table' by exanding the require.path it looks for stuff to
-- require. this will make importing stuff far more readable and much easier,
-- since every entry in 'require_table' is anyway not creating collisions among
-- themselves. Therefore is the only collisions we have to account for those
-- with the standard awesome library (and those of the standard 'awesome'
-- library if there are any).

-- TODO: change name conventions in config file. use sub tables instead of very
-- long names. The default awesome library does that too.

-- TODO: battery import problem with infinite recurse proble. Solve it by
-- running the neccessary importing inside a function. but the function will be
-- stated at the beginning. That way imports will all be stated at beginning of
-- file. Do this for every in-code import. I also remember one with the Mode
-- module

-- TODO: chenage order of imports. put global variables on top of everything.

-- TODO: fix library name ocnvention. Put every self-made library with Capital
-- Letter as its fist one. Also, remove the Widgets library and use instead
-- simply the different widgets and import them ass necessray. This
-- destinguishes them better from awesome's stuff. This will probably only be in
-- the Wibar function (or library later on).

-- TODO: awesome exit, do that it deletes file of pid, when awesome quits
-- entirryl, so does not doe a simple restart. that way the file of pid will not
-- remain there forever once we change the name convention in our
-- conf/config-naho table. maintainablity !!!

-- TODO: make mode of every major thin that takes or blocks keyboard input such
-- as dmenu, passmenu, or capture.

-- Global variables
-- @since 1.0
local awesome = awesome
local client = client
local mouse = mouse
local root = root
local screen = screen

-- Standard awesome library
-- @since 1.0
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local naughty = require("naughty")
local wibox = require("wibox")

-- Self-made library
-- @since 1.0
local require_table = require("require-table")

-- Self-made library
-- @since 1.0
local File = require(require_table.File)
local Mode = require(require_table.Mode)
local Pid = require(require_table.Pid)
local Sharedtags = require(require_table.Sharedtags)
local Wallpaper = require(require_table.wallpaper)
local colors = require(require_table.colors)
local config = require(require_table.config)
local theme = require(require_table.theme)

local Main = {}

--{{{ Main - Variable: widgets

Main.widgets = nil

--}}}

--{{{ Main - Function: awful_layout_layouts

function Main.awful_layout_layouts()
    awful.layout.layouts = config.layouts
end

--}}}

--{{{ Main - Function: beautiful_init

function Main.beautiful_init()
    beautiful.init(theme)
end

--}}}

--{{{ Main - Function: collectgarbage

function Main.collectgarbage()

    local function table_keys_max(t)
        local max = - math.huge
        for _, v in pairs(t) do
            if type(v) == "number" and max < v then max = v end
        end
        return max
    end

    local wait_min = config.collectgarbage.wait
    local most_delayed_command = table_keys_max(config.commands_startup)
    local start_delay = most_delayed_command and
        most_delayed_command * config.collectgarbage.wait_multiply or
        0

    gears.timer{
        autostart = true,
        call_now  = true,
        timeout   = config.collectgarbage.update_time,
        callback  = function() collectgarbage("collect") end
    }

    gears.timer.start_new(
        start_delay > wait_min and start_delay or wait_min,
        function() collectgarbage("collect") end
    )

end

--}}}

--{{{ Main - Function: collectgarbage_log

function Main.collectgarbage_log()

    local function table_keys_max(t)
        local max = - math.huge
        for _, v in pairs(t) do
            if type(v) == "number" and max < v then max = v end
        end
        return max
    end

    local file_collectgarbage_log = os.getenv("HOME") ..
        "/t/awesome-collectgarbage.log"
    local min_wait = config.collectgarbage.wait
    local start_delay = table_keys_max(config.commands_startup) *
        (config.collectgarbage.wait_multiply or 1)

    local function collectgarbage_log(prefix)
        File.append(
            ("%s %d Kbytes %s"):format(
                prefix,
                gears.math.round(collectgarbage("count")),
                os.date("%F %T")
            ),
            file_collectgarbage_log
        )
    end

    File.append(
        ("[%s] (%d)"):format(
            os.date("%F %T"), config.collectgarbage.update_time
        ),
        file_collectgarbage_log
    )

    gears.timer{
        autostart = true,
        call_now  = true,
        timeout   = config.collectgarbage.update_time,
        callback  = function()
            collectgarbage_log("+")
            collectgarbage("collect")
            collectgarbage_log("-")
        end
    }

    gears.timer{
        autostart = true,
        call_now  = true,
        timeout   = config.collectgarbage.update_time / 50,
        callback  = function() collectgarbage_log(" ") end
    }

    gears.timer.start_new(
        start_delay > min_wait and start_delay or min_wait,
        function()
            collectgarbage_log("+")
            collectgarbage("collect")
            collectgarbage_log("-")
        end
    )

end

--}}}

--{{{ Main - Function: connect_signals

function Main.connect_signals()

    --{{{ awesome

    awesome.connect_signal(
        "debug::error",
        function(error)
            naughty.notify{
                preset = naughty.config.presets.critical,
                title = "A call into the Lua code aborted with an error",
                text = tostring(error)
            }
        end
    )

    awesome.connect_signal(
        "debug::deprecation",
        function(error)
            naughty.notify{
                preset = naughty.config.presets.critical,
                title = "A deprecated Lua function was called",
                text = tostring(error)
            }
        end
    )

    awesome.connect_signal(
        "debug::index::miss",
        function(class, key)
            naughty.notify{
                preset = naughty.config.presets.critical,
                title = "An invalid key was read from an object",
                text = ("Class: %s\nKey: %s"):format(
                    tostring(class), tostring(key)
                )
            }
        end
    )

    awesome.connect_signal(
        "debug::newindex::miss",
        function(class, key, value)
            naughty.notify{
                preset = naughty.config.presets.critical,
                title = "An invalid key was written to an object",
                text = ("Class: %s\nKey: %s\nValue: %s"):format(
                    tostring(class), tostring(key), tostring(value)
                )
            }
        end
    )

    -- Awesome is exiting or about to restart
    awesome.connect_signal(
        "exit", function() Pid.kill(config.pid_full_path) end
    )

    --}}}

    --{{{ Client

    -- Set new clients as slave instead of master and prevent them from being
    -- off screen
    client.connect_signal(
        "manage",
        function(c)
            awful.client.setslave(c)
            if not c.size_hints.user_position
                and not c.size_hints.program_position
            then
                awful.placement.no_offscreen(c)
            end
        end
    )

    -- Restrict clients to their own client and prevent them from going full
    -- screen
    client.connect_signal(
        "property::fullscreen",
        function(c) if c.fullscreen then c.fullscreen = false end end
    )

    -- Floating windwos are always on top
    client.connect_signal(
        "property::floating", function(c) c.ontop = c.floating end
    )

    -- Add a title bar to clients if requested
    client.connect_signal(

        "request::titlebars",

        function(c)

            local buttons = {
                awful.button(
                    {}, 1,
                    function()
                        c:emit_signal(
                            "request::activate", "titlebar",
                            {raise = true}
                        )
                        awful.mouse.client.move(c)
                    end
                ),
                awful.button(
                    {}, 3,
                    function()
                        c:emit_signal(
                            "request::activate", "titlebar",
                            {raise = true}
                        )
                        awful.mouse.client.resize(c)
                    end
                )
            }

            awful.titlebar(c):setup{
                layout = wibox.layout.align.horizontal,
                -- Left
                {
                    layout  = wibox.layout.fixed.horizontal,
                    awful.titlebar.widget.iconwidget(c),
                    buttons = buttons
                },
                -- Middle
                {
                    {
                        align  = "center",
                        widget = awful.titlebar.widget.titlewidget(c)
                    },
                    layout  = wibox.layout.flex.horizontal,
                    buttons = buttons
                },
                -- Right
                {
                    layout = wibox.layout.fixed.horizontal(),
                    awful.titlebar.widget.floatingbutton(c),
                    awful.titlebar.widget.maximizedbutton(c),
                    awful.titlebar.widget.stickybutton(c),
                    awful.titlebar.widget.ontopbutton(c),
                    awful.titlebar.widget.closebutton(c)
                }
            }

        end

    )

    -- Set broder color for focussed windows
    client.connect_signal(
        "focus",
        function(c) c.border_color = beautiful.border_focus end
    )

    -- Set broder color for unfocussed windows
    client.connect_signal(
        "unfocus",
        function(c) c.border_color = beautiful.border_normal end
    )

    -- Focus follows mouse
    client.connect_signal(
        "mouse::enter",
        function(c)
            c:emit_signal("request::activate", "mouse_enter", {raise = false})
        end
    )

    --}}}

    --{{{ Screen

    -- Reinitialise wallpaper if screen's geometry changes
    screen.connect_signal("property::geometry", Wallpaper)

    --}}}

end

--}}}

--{{{ Main - Function: menubar_utils_terminal

function Main.menubar_utils_terminal()
    menubar.utils.terminal = config.terminal
end

--}}}

--{{{ Main - Function: pid_spawn_commands

function Main.pid_spawn_commands()
    Pid.spawn_commands(config.commands_startup, config.pid_full_path)
end

--}}}

--{{{ Main - Function: rules

function Main.rules()

    local key_leader = config.key.leader

    awful.rules.rules = {

        --{{{ All Clients

        {
            rule = {},
            properties = {
                border_color = beautiful.border_normal,
                border_width = beautiful.border_width,
                focus = true,
                placement = awful.placement.no_overlap
                    + awful.placement.no_offscreen,
                raise = true,
                screen = awful.screen.preferred,
                size_hints_honor = false,
                --{{{ Buttons
                buttons = gears.table.join(
                    awful.button(
                        {}, 1,
                        function (c)
                            c:emit_signal(
                                "request::activate", "mouse_click",
                                {raise = true}
                            )
                        end
                    ),
                    awful.button(
                        {key_leader}, 1,
                        function (c)
                            c:emit_signal(
                                "request::activate", "mouse_click",
                                {raise = true}
                            )
                            awful.mouse.client.move(c)
                        end
                    ),
                    awful.button(
                        {key_leader}, 3,
                        function (c)
                            c:emit_signal(
                                "request::activate", "mouse_click",
                                {raise = true}
                            )
                            awful.mouse.client.resize(c)
                        end
                    )
                ),
                --}}}
                --{{{ Keys
                keys = gears.table.join(
                    awful.key(
                        {key_leader}, "q",
                        function(c) c:kill() end,
                        {
                            group = config.hotkeys_groups.clients,
                            description = "Quit/kill focussed client"
                        }
                    )
                )
                --}}}
            }
        },

        --}}}

        --{{{ All Splash

        {
            rule = {type = "splash"},
            properties = {focus = false, floating = false}
        },

        --}}}

        --{{{ Discord

        {
            rule = {instance = "discord"},
            properties = {floating = false, tag = Sharedtags.tags[9]},
            callback = function(c) awful.client.setmaster(c) end
        },

        --}}}

        --{{{ Qutebrowser

        {
            rule = {instance = "qutebrowser"},
            properties = {tag = Sharedtags.tags[2]}
        }

        --}}}

    }

end

--}}}

--{{{ Main - Function: sharedtags_init

function Main.sharedtags_init()
    Sharedtags.init(config.sharedtags_tags)
end

--}}}

--{{{ Main - Fucntion: wallpaper_init

function Main.wallpaper_init()
    gears.timer{
        autostart = true,
        call_now  = true,
        timeout   = config.wallpaper.update_time,
        callback  = Wallpaper
    }
end

--}}}

return Main

-- vim: ft=lua fdm=marker et sts=4 sw=4 ts=8 tw=80
