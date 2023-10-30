--[[
A mode widget

@author    NAHO (https://github.com/trueNAHO)
@version   1.0
@classmod  Mode
--]]

-- Standard awesome library
-- @since 1.0
local wibox_widget_textbox = require("wibox").widget.textbox

-- Self-made library
-- @since 1.0
local config_mode_concat = require(require("require-table").config).mode.concat

local widget_attribute = "modes"

--{{{ Function: table_concat_values

--[[
Returns all values from table where every value is joined by a separator. Values
are sorted.

@param t          (table) Table from which values are extracted
@param separator  (string) Separator used to join values
@return           (string) All values from table in concatenated and ordered
                  form
--]]
local function table_concat_values(t, separator)
    local values = {}
    for _, v in pairs(t) do table.insert(values, v) end
    table.sort(values)
    return table.concat(values, separator)
end

--}}}

local Mode = {}

--{{{ Mode - Metatable: __call

--[[
Returns text box widget with an additional table attribute consisting of modes
with their respective attributes. This table is assigned to the widget_attribute
argument field inside the text box widget.

@param t  (table) Table where every (string) key is the internal name of the
          mode and where its corresponding (table) key contains the attributes
          for that mode. Available attributes are: (bool) "active" which
          defaults to (bool) false and represents the mode's status. (function)
          "callback" which defaults to (function) doing nothing and is executed
          when Mode.add() is called. (function) "exit" which defaults to
          (function) doing nothing and is executed when Mode.remove() is
          called. (string) "html" which defaults to "%s" and is the format
          string for the mode representation where the only variable is the name
          of the corresponding mode. (string) "name" which defaults to the
          (string) internal mode name and is the beautiful name of its
          corresponding mode.
--]]

setmetatable(Mode, {__call = function(_, t)
    local widget = wibox_widget_textbox()
    widget[widget_attribute] = {}
    for mode_key, mode in pairs(t) do
        widget[widget_attribute][mode_key] = {
            active = mode.active or false,
            callback = mode.callback or function() end,
            exit = mode.exit or function() end,
            html = mode.html or "%s",
            name = mode.name or mode_key
        }
    end
    return widget
end})

--}}}

--{{{ Mode - Variable: modes_active

Mode.modes_active = {}

--}}}

--{{{ Mode - Function: add

--[[
Add mode to a Mode widget. Update representation of active modes and run the
mode's respective callback() function.

@param widget    (Mode) Widget to which a mode is given
@param mode_key  (string) Internal name of mode to be added
--]]
function Mode.add(widget, mode_key)
    local mode = widget[widget_attribute][mode_key]
    mode.active = true
    Mode.modes_active[mode] = mode.html:format(mode.name)
    widget.markup = table_concat_values(Mode.modes_active, config_mode_concat)
    mode.callback()
end

--}}}

--{{{ Mode - Function: remove

--[[
Remove mode from a Mode widget. Update representation of active modes and run
the mode's respective exit() function.

@param widget    (Mode) Widget from which a mode is removed
@param mode_key  (string) Internal name of mode to be removed
--]]
function Mode.remove(widget, mode_key)
    local mode = widget[widget_attribute][mode_key]
    mode.active = false
    Mode.modes_active[mode] = nil
    widget.markup = table_concat_values(Mode.modes_active, config_mode_concat)
    mode.exit()
end

--}}}

return Mode

-- vim: ft=lua fdm=marker et sts=4 sw=4 ts=8 tw=80
