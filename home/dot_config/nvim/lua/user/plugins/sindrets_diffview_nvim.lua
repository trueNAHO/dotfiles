-- Single tabpage interface for easily cycling through diffs for all modified
-- files for any git rev.
require("packer").use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
        require("diffview").setup({
            use_icons = false
        })
    end
})
