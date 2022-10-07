-- The fastest Neovim colorizer.
require("packer").use({
    "norcalli/nvim-colorizer.lua",
    config = function()
        vim.opt.termguicolors = true
        require("colorizer").setup()
    end
})
