-- Neovim's answer to the mouse: a "clairvoyant" interface that makes on-screen
-- jumps quicker and more natural than ever.
require("packer").use({
    "ggandor/leap.nvim",
    config = function()
        local leap = require("leap")

        local leader_prefix = "<leader>f"

        leap.opts = {
            -- Disable auto-jumping to the first match.
            safe_labels = {},
        }

        -- Bidirectional search. Initiate multi-window mode with the current
        -- window as the only target.
        vim.keymap.set({ "n", "v" }, leader_prefix .. "f", function()
            leap.leap({ target_windows = { vim.fn.win_getid() } })
        end)

        -- Search in all windows.
        vim.keymap.set({ "n", "v" }, leader_prefix .. "w", function()
            leap.leap({ target_windows = vim.tbl_filter(
                function(win)
                    return vim.api.nvim_win_get_config(win).focusable
                end,
                vim.api.nvim_tabpage_list_wins(0)
            ) })
        end)
    end
})
