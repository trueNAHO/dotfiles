-- The undo history visualizer for VIM.
require("packer").use({
    "mbbill/undotree",
    config = function()
        local leader = "<leader>u"

        local prefix_desc = "Undo. "

        vim.g.undotree_CustomDiffpanelCmd = "botright 10 new"

        -- Toggle the undo-tree panel.
        vim.keymap.set(
            "n", leader, function() vim.cmd("UndotreeToggle") end,
            { desc = prefix_desc .. "Toggle the undo-tree panel" }
        )
    end
})
