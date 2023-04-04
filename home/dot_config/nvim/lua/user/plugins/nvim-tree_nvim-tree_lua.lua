-- A file explorer tree for neovim written in lua.
require("packer").use({
    "nvim-tree/nvim-tree.lua",

    requires = "nvim-tree/nvim-web-devicons",

    config = function()
        local nvim_tree = require("nvim-tree")
        local nvim_tree_api = require("nvim-tree.api")

        local leader = "<leader>e"

        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        vim.keymap.set("n", leader, nvim_tree_api.tree.toggle, {
            desc = "file Explorer. Open or close the tree.",
        })

        nvim_tree.setup()
    end,
})
