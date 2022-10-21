-- Magit for neovim.
require("packer").use({
    "TimUntersberger/neogit",
    requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    config = function()
        local neogit = require("neogit")
        neogit.setup({
            disable_commit_confirmation = true,
            integrations = { diffview = true },
            use_magit_keybindings = true
        })
    end
})
