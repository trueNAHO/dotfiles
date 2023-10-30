-- Global variables
-- @since 1.0
local root = root

-- Standard awesome library
-- @since 1.0
local awful_button = require("awful").button
local gears_table_join = require("gears").table.join

-- Self-made library
-- @since 1.0
local menu_main = require(require("require-table").menu_main)

root.buttons(
    gears_table_join(
        ----awful_button({}, 4, awful.tag.viewnext),
        ----awful_button({}, 5, awful.tag.viewprev),
        awful_button({}, 3, function() menu_main:toggle() end)
    )
)
