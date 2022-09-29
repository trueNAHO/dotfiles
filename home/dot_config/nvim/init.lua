-- File containing initialization commands is generically called a "vimrc" or
-- config file. It can be either Vimscript ("init.vim") or Lua ("init.lua"), but
-- not both.

-- Set autocommands.
require("user.autocommands")

-- Set keymaps.
require("user.keymaps")

-- Set options.
require("user.options")

-- Set plugins.
require("user.plugins")
