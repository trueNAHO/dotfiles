-- Soothing pastel theme for NeoVim.
require("packer").use{
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
        require("catppuccin").setup{transparent_background = true}
        vim.cmd("colorscheme catppuccin")
    end
}
