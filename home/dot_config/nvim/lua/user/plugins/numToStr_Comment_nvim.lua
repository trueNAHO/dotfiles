-- Smart and powerful comment plugin for neovim. Supports treesitter, dot
-- repeat, left-right/up-down motions, hooks, and more.
require("packer").use({
    "numToStr/Comment.nvim",

    config = function()
        local comment = require("Comment")

        comment.setup()
    end,
})
