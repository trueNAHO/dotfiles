-- Magit for neovim.
require("packer").use({
    "TimUntersberger/neogit",
    requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    config = function()
        local neogit = require("neogit")

        local leader = "<leader>g"

        local prefix_desc = "Git. "

        neogit.setup({
            disable_commit_confirmation = true,
            integrations = { diffview = true },
            use_magit_keybindings = true
        })

        -- Open a new NeogitStatus instance.
        vim.keymap.set(
            "n", leader, neogit.open,
            { desc = prefix_desc .. "Open a new NeogitStatus instance." }
        )
    end
})
