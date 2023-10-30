-- Global variables
-- @since 1.0
local awesome = awesome

-- Standard awesome library
-- @since 1.0
local awful = require("awful")
local hotkeys_popup_show_help = require("awful.hotkeys_popup").show_help
local beautiful_awesome_icon = require("beautiful").awesome_icon

-- Self-made library
-- @since 1.0
local config = require(require("require-table").config)

return awful.menu{

    items = {

        --{{{ 'awesome'

        {
            "awesome",
            {
                {
                    "Config",
                    config.editor .. " " .. awesome.conffile
                },
                {
                    "Hotkeys",
                    function()
                        hotkeys_popup_show_help(
                            nil, awful.screen.focused()
                        )
                    end
                },
                {
                    "Manual",
                    config.terminal .. " -e man awesome"
                },
                {
                    "Quit",
                    function() awesome.quit() end
                },
                {
                    "Restart",
                    awesome.restart
                }
            },
            beautiful_awesome_icon
        },

        --}}}

        --{{{ Open terminal

        {
            "Open '" .. config.terminal .. "'",
            config.terminal
        }

        --}}}

    }

}
