-- The undo history visualizer for VIM.
require("packer").use{
    "mbbill/undotree",
    config = function()
        local leader_prefix = "<leader>u"

        vim.g.undotree_CustomDiffpanelCmd = "botright 10 new"

        -- Toggle the undo-tree panel.
        vim.keymap.set("n", leader_prefix,
                       function() vim.cmd("UndotreeToggle") end)
    end
}