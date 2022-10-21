-- Magit for neovim.
require("packer").use({
    "TimUntersberger/neogit",
    requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    config = function()
        local neogit = require("neogit")
        neogit.setup({
            integrations = { diffview = true },
        })
    end
})
