-- Standard awesome library
-- @since 1.0
local awful_spawn_easy_async = require("awful").spawn.easy_async

-- Self-made library
-- @since 1.0
local config_commands_wallpaper = require(
    require("require-table").config).commands.wallpaper

return function()
    awful_spawn_easy_async(config_commands_wallpaper, function() end)
end
