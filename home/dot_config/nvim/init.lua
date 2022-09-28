-- File containing initialization commands is generically called a "vimrc" or
-- config file. It can be either Vimscript ("init.vim") or Lua ("init.lua"), but
-- not both.

-- Set autocommands.
require("user.autocommands")

-- Set options.
require("user.options.command_line_editing")
require("user.options.diff_mode")
require("user.options.displaying_text")
require("user.options.editing_text")
require("user.options.executing_external_commands")
require("user.options.folding")
require("user.options.important")
require("user.options.language_specific")
require("user.options.mapping")
require("user.options.messages_and_info")
require("user.options.moving_and_searching_and_patterns")
require("user.options.multi-byte_characters")
require("user.options.multiple_tab_pages")
require("user.options.multiple_windows")
require("user.options.printing")
require("user.options.reading_writing_files")
require("user.options.running_make_and_jumping_to_errors")
require("user.options.selecting_text")
require("user.options.swap_file")
require("user.options.syntax_and_highlighting_and_spelling")
require("user.options.tabs_and_indenting")
require("user.options.tags")
require("user.options.terminal")
require("user.options.using_the_mouse")
require("user.options.various")
