-- vim: fdm=marker tw=79

--{{{ ---- AWESOME ----

--       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
--      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
--      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
--      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
--      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
--      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝
--                                      Tool: http://patorjk.com/software/taag/
--                                      Font: ANSI Shadow

--                                  ███████
--                              ████       ████
--                            ██   █       █   ██
--                            ██   ██      █   ██
--                          ██     █ █     █     ██
--                          ██     █  █    █     ██ GitHub:
--                          ██     █   █   █     ██ https://github.com/trueNAHO
--                          ██     █    █  █     ██
--                            ██   █     █ █   ██
--                            ██   █      ██   ██
--                              ████       ████
--                                  ███████

-- References:
    -- Awesomewm Open Source Projects on Github:
        -- https://awesomeopensource.com/projects/awesomewm
    -- Pre-built 'awesome' widgets:
        -- https://github.com/streetturtle/awesome-wm-widgets
    -- Awesome config exaple:
        -- https://github.com/actionless/awesome_config
        -- https://github.com/imHitchens/awesome-wm-config-1

--}}}

-- TODO: Create Mode class object for widget

-- TODO: collectgarbage behavior can be adjusted inside lua. check lua man page
-- for more information

-- TODO: Convert self-made widgets into module which will contain the different
-- time update widgets like date and battery. The module will also contain
-- a function used to update a given widget, using its respective intialisation
-- function.

-- TODO: add config.suspend_expected_time for updating time itervalled widgets
-- slightly after suspend, actually after config.suspend_expected_time time.

-- Self-made library
-- @since 1.0
local require_table = require("require-table")

-- Standard awesome library
-- @since 1.0
require("beautiful").init(require(require_table.theme))

-- Standard awesome library
-- @since 1.0
require("awful.autofocus")
require("awful.hotkeys_popup.keys")

-- Self-made library
-- @since 1.0
local Main = require(require_table.Main)

Main.sharedtags_init()

-- Self-made library
-- @since 1.0
require(require_table.wibar)

-- Connect signals.
Main.connect_signals()

-- Initialises theme settings. Should be run as early as possible to avoid
-- undesired default theme values being used.
Main.beautiful_init()

-- Run commands on startup. Note that this should be run after
-- 'Main.pid_cleanup()' because the commands are managed by it.
Main.pid_spawn_commands()

-- TODO: put this into a Main.function function
-- Table of layouts, order matters
Main.awful_layout_layouts()

-- TODO: put this into a Main.function function
-- Terminal which applications that need terminal would open in
Main.menubar_utils_terminal()

-- Global rules table
Main.rules()

-- Initialise wallpaper
Main.wallpaper_init()

-- Self-made library
-- @since 1.0
require(require_table.root_keys)

-- Self-made library
-- @since 1.0
require(require_table.root_buttons)

-- TODO: run after evry init command has run. take arrray of all those delay
-- times and wait the longest value from that table. multiply that value by
-- 2 (config variable) and set a default minimum wait time (config variable)

-- Manually run 'collectgarbage' due to 'awesome's memory leak.
Main.collectgarbage_log()
