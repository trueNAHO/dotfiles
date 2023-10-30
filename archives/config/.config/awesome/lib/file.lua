--[[
Module for handling files

@author   NAHO (https://github.com/trueNAHO)
@version  1.0
@module   File
--]]

-- Standard awesome library
-- @since 1.0
local gears_filesystem_make_parent_directories = require(
    "gears").filesystem.make_parent_directories

local File = {}

--{{{ File - Function: append

--[[
Append content to file. Every entry is separated by a newline character. Creates
all parent directories, if necessary.

@param content    (string or number) Content to be added to file
@param full_path  (string) Full path of file to which content is appended to
--]]
function File.append(content, full_path)
    local file = io.open(full_path, "ab")
    if not file then
        gears_filesystem_make_parent_directories(full_path)
        file = io.open(full_path, "ab")
    end
    file:write(content .. "\n")
    file:close()
end

--}}}

--{{{ File - Function: clear

--[[
Clear entire content of file

@param full_path  (string) Full path of file to be cleared
@return           (bool) True if file exists, otherwise (bool) false
--]]
function File.clear(full_path)
    local file = io.open(full_path, "w")
    if file then
        file:write()
        file:close()
        return true
    else
        return false
    end
end

--}}}

--{{{ File - Function: read

--[[
Returns file's content where every line is joined by a seperator. Returns false
if file does not exist.

@param full_path  (string) Full path of file to be read
@param separator  (string) Separator used to join lines. Optional agrument which
                  defaults to (string) single newline character ("\n").
@return           (string) File's content, if file exists, otherwise (bool)
                  false
--]]
function File.read(full_path, separator)
    local file = io.open(full_path)
    if not file then return false end
    local content
    -- When the separator is a single newline character, file:read("*a") is more
    -- efficient
    if not separator or separator == "\n" then
        content = file:read("*a"):gsub("\n$", "")
    else
        local lines = {}
        for line in file:lines() do table.insert(lines, line) end
        content = table.concat(lines, separator)
    end
    file:close()
    return content
end

--}}}

return File

-- vim: ft=lua fdm=marker et sts=4 sw=4 ts=8 tw=80
