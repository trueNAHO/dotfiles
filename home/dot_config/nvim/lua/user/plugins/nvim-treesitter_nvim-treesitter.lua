-- Nvim Treesitter configurations and abstraction layer.
require("packer").use({
    "nvim-treesitter/nvim-treesitter",

    config = function()
        local nvim_treesitter_configs = require("nvim-treesitter.configs")

        nvim_treesitter_configs.setup({
            auto_install = true,
            highlight = { enable = true },
        })
    end,
})
