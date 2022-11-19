-- A clean, dark Neovim theme written in Lua, with support for lsp, treesitter
-- and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm
-- and Fish.
require("packer").use({
    "folke/tokyonight.nvim",
    config = function()
        require("tokyonight").setup({ transparent = true })
        vim.cmd("colorscheme tokyonight-night")
    end
})
