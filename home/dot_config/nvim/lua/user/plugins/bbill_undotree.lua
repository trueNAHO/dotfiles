-- The undo history visualizer for VIM.
require("packer").use({
    "mbbill/undotree",
    config = function()
        local leader = "<leader>u"

        vim.g.undotree_CustomDiffpanelCmd = "botright 10 new"

        -- Toggle the undo-tree panel.
        vim.keymap.set(
            "n", leader, function() vim.cmd("UndotreeToggle") end,
            { desc = "Toggle the undo-tree panel" }
        )
    end
})
