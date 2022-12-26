-- Rainbow parentheses for neovim using tree-sitter.
require("packer").use({
    "p00f/nvim-ts-rainbow",

    requires = "nvim-treesitter/nvim-treesitter",

    config = function()
        local nvim_treesitter_configs = require("nvim-treesitter.configs")

        nvim_treesitter_configs.setup({
            rainbow = { enable = true, extended_mode = true },
        })
    end,
})
