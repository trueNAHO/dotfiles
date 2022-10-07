-- A dark Vim/Neovim color scheme inspired by Atom's One Dark syntax theme.
require("packer").use {
    "joshdick/onedark.vim",
    config = function()
        vim.g.onedark_color_overrides = {
            -- Remove background color.
            background = { gui = "#FFFFFFFF", cterm = "256", cterm16 = "16" }
        }
        vim.cmd("colorscheme onedark")
    end
}
