-- File containing initialization commands is generically called a "vimrc" or
-- config file. It can be either Vimscript ("init.vim") or Lua ("init.lua"), but
-- not both.

require("user.autocommands")
require("user.keymaps")
require("user.options")
require("user.plugins")
