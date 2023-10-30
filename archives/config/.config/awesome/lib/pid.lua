--[[
Module for managing commands

@author   NAHO (https://github.com/trueNAHO)
@version  1.0
@module   Pid
--]]

-- Standard awesome library
-- @since 1.0
local awful_spawn = require("awful").spawn
local gears_timer_start_new = require("gears").timer.start_new

-- Self-made library
-- @since 1.0
local require_table = require("require-table")

-- Self-made library
-- @since 1.0
local File = require(require_table.File)
local config = require(require_table.config)

local Pid = {}

--{{{ Pid - Function: manage

--[[
Manage PID by appending it to file. This method is meant for better code
readability.

@param pid        (string or number) PID to be added to file
@param full_path  (string) Full path of file to which content is appended
                  to. Optional argument which defaults to (string)
                  config.pid_full_path argument
--]]
function Pid.manage(pid, full_path)
    File.append(pid, full_path or config.pid_full_path)
end

--}}}

--{{{ Pid - Function: kill

--[[
Synchronously kill every PID in file

@param full_path  (string) Full path of file containing PIDs to be
                  killed. Optional argument which defaults to
                  config.pid_full_path argument.
@return           (bool) True, if file exists, otherwise (bool) false
--]]
function Pid.kill(full_path)
    local full_path = full_path or config.pid_full_path
    awful_spawn("pkill -s " .. File.read(full_path, ","))
    File.clear(full_path)
end

--}}}

--{{{ Pid - Function: spawn_commands

--[[
Spawn a series of commands and append their PID to file. For every command wait
an optionally amount of time before spawning it.

@param commands   (table) Table where every (string) key is the command and its
                  corresponding (number) value is the time to be waited before
                  spawning the command. Time value defaults to (number)
                  zero. This optional argument defaults to
                  config.commands_startup argument.
@param full_path  (string) Full path of file to which PID numbers are appended
                  to. Optional argument which defaults to config.pid_full_path
                  argument.
--]]
function Pid.spawn_commands(commands, full_path)
    for command, time in pairs(commands or config.commands_startup) do
        if type(command) == "number" then command, time = time, 0 end
        gears_timer_start_new(
            time,
            function()
                File.append(
                    awful_spawn.easy_async(command, function() end),
                    full_path or config.pid_full_path
                )
            end
        )
    end
end

--}}}

return Pid

-- vim: ft=lua fdm=marker et sts=4 sw=4 ts=8 tw=80
