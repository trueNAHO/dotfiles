-- Show code context.
require("packer").use({
    "nvim-treesitter/nvim-treesitter-context",

    requires = "nvim-treesitter/nvim-treesitter",

    config = function()
        local treesitter_context = require("treesitter-context")

        treesitter_context.setup()
    end,
})
