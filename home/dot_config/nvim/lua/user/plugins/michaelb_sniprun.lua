-- A neovim plugin to run lines/blocs of code (independently of the rest of the
-- file), supporting multiples languages.
require("packer").use({
    "michaelb/sniprun",

    run = "bash ./install.sh",

    config = function()
        local sniprun = require("sniprun")
        local sniprun_display = require("sniprun.display")

        local leader = "<leader>r"

        -- Run code snippet in normal mode.
        vim.api.nvim_set_keymap(
            "n",
            leader .. "r",
            "<Plug>SnipRun",
            { desc = "snippet Run Run. Run code snippet.", silent = true }
        )

        -- Run code snippet in visual mode.
        vim.api.nvim_set_keymap(
            "v",
            leader .. "r",
            "<Plug>SnipRun",
            { desc = "snippet Run Run. Run code snippet.", silent = true }
        )

        -- Close code snippet output.
        vim.keymap.set(
            "n",
            leader .. "c",
            sniprun_display.close_all,
            { desc = "snippet Run Close. Close code snippet output." }
        )

        sniprun.setup({ display = { "Terminal" } })
    end,
})
