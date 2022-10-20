-- Magit for neovim.
require("packer").use({
    "TimUntersberger/neogit",
    requires = "nvim-lua/plenary.nvim",
    config = function()
        require("neogit").setup({})
    end
})
