--[[
Module for creating tags shared among screens

@author   NAHO (https://github.com/trueNAHO)
@version  1.0
@module   Sharedtags
@url      https://github.com/Drauthius/awesome-sharedtags
--]]

-- Standard awesome library
-- @since 1.0
local awful = require("awful")

-- Global variables
-- @since 1.0
local screen = screen

local Sharedtags = {}

--{{{ Sharedtags - Variable: tags

Sharedtags.tags = {}

--}}}

--{{{ Sharedtags - Function: init

--[[
Assigns tags to Sharedtags.tags variable

@param all_tags  (table) Table consisting of (table) sub tables. Every sub table
                 represents a tag with its respective initial attributes. Every
                 sub table is the same argument as used for the awful.tag.add()
                 function.
--]]
function Sharedtags.init(all_tags)
    local tags = {}
    for i, t in ipairs(all_tags) do
        if not t.screen or t.screen > screen:count() then
            t.screen = screen.primary
        end
        local tag = awful.tag.add(t.name or i, t)
        tags[i] = tag
        -- Create alias between tag's index and its name
        if t.name and type(t.name) ~= "number" then tags[t.name] = tag end
        -- Assure every screen has a selected tag
        awful.screen.connect_for_each_screen(
            function(s)
                if not s.selected_tag and not tag.selected then
                    Sharedtags.move(tag, s)
                    tag:view_only()
                end
            end
        )
        -- Make sure to salvage tag in case screen disappears
        tag:connect_signal(
            "request::screen",
            function()
                local screen_new
                for s in screen do
                    if s ~= tag.screen then
                        screen_new = s
                        break
                    end
                end
                tag.selected = false
                tag.screen = screen_new
                screen[screen_new]:emit_signal("tag::history::update")
            end
        )
    end
    Sharedtags.tags = tags
end

--}}}

--{{{ Sharedtags - Function: move

--[[
Move tag to a screen

@param tag            (tag) Tag to be moved
@param target_screen  (screen) Screen to which tag will be moved to. Optional
                      argument which defaults to currently focussed screen.
@return               (bool) True, if tag was moved, otherwise (bool) false
--]]
function Sharedtags.move(tag, target_screen)
    local target_screen = target_screen or awful.screen.focused()
    local tag_screen = tag.screen
    if not tag_screen or tag_screen ~= target_screen then
        local target_screen_selected_tag = target_screen.selected_tag
        tag.screen = target_screen
        if not tag_screen.selected_tag then
            target_screen_selected_tag.screen = tag_screen
        end
        return true
    end
    return false
end

--}}}

--{{{ Sharedtags - Function: toggle

--[[
Toggle selection of a tag

@param tag  (tag) Tga whose selection will be toggled
--]]
function Sharedtags.toggle(tag)
    local tag_screen = tag.screen
    if Sharedtags.move(tag) then
        tag.selected = true
        tag_screen:emit_signal("tag::history::update")
        tag.screen:emit_signal("tag::history::update")
    else
        awful.tag.viewtoggle(tag)
    end
end

--}}}

--{{{ Sharedtags - Function: view

--[[
View tag on a screen

@param tag            (tag) Tag to be viewed
@param target_screen  (screen) Screen on which tag will be seen
@param force_screen   (bool) True shifts focus to tag's screen, if tag is
                      currently selected on a screen. (bool) False disables this
                      behavior. Optional argument which defaulls to (bool)
                      false.
--]]
function Sharedtags.view(tag, target_screen, force_screen)
    if not tag.selected or force_screen then
        Sharedtags.move(tag, target_screen)
    end
    tag:view_only()
    awful.screen.focus(tag.screen)
end

--}}}

return Sharedtags

-- vim: ft=lua fdm=marker et sts=4 sw=4 ts=8 tw=80
