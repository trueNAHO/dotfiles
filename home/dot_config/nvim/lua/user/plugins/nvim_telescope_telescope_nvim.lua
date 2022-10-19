local function telescope_config()
    local telescope = require("telescope")
    local telescope_actions = require('telescope.actions')
    local telescope_builtin = require("telescope.builtin")

    local leader = "<leader>t"

    local telescope_setup = {
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = telescope_actions.select_default
                }
            }
        }
    }

    local function file_pickers()
        -- Search for files (respecting .gitignore).
        vim.keymap.set(
            "n", leader .. "f", telescope_builtin.find_files,
            { desc = "Search for files (respecting .gitignore)" }
        )

        -- Search for the string under the cursor in the current working
        -- directory.
        vim.keymap.set(
            "n", leader .. "l", telescope_builtin.grep_string,
            {
                desc = "Search for the string under the cursor in the " ..
                    "current working directory"
            }
        )

        -- Search for a string and get results live while typing (respecting
        -- .gitignore).
        vim.keymap.set(
            "n", leader .. "g", telescope_builtin.live_grep,
            {
                desc = "Search for a string and get results live while " ..
                    "typing (respecting .gitignore)"
            }
        )
    end

    local function vim_pickers()
        -- List recently executed commands and rerun them on `<cr>`.
        vim.keymap.set(
            "n", leader .. "c", telescope_builtin.command_history,
            {
                desc = "List recently executed commands and rerun them on " ..
                    "`<cr>`"
            }
        )

        -- List vailable help tags and open a new window with the relevant
        -- help info on `<cr>`.
        vim.keymap.set(
            "n", leader .. "h", telescope_builtin.help_tags,
            {
                desc = "List vailable help tags and open a new window with " ..
                    "the relevant help info on `<cr>`"
            }
        )

        -- List items in the quickfix list and jump to location on `<cr>`.
        vim.keymap.set(
            "n", leader .. "q", telescope_builtin.quickfix,
            {
                desc = "List items in the quickfix list and jump to " ..
                    "location on `<cr>`"
            }
        )

        -- List vim options and edit the current value on `<cr>`.
        vim.keymap.set(
            "n", leader .. "o", telescope_builtin.vim_options,
            { desc = "List vim options and edit the current value on `<cr>`" }
        )

        -- List normal mode keymappings and run the selected keymap on `<cr>`.
        vim.keymap.set(
            "n", leader .. "k", telescope_builtin.keymaps,
            {
                desc = "List normal mode keymappings and run the selected " ..
                    "keymap on `<cr>`"
            }
        )

        -- Live fuzzy search inside of the currently open buffer.
        vim.keymap.set(
            "n", leader .. "G",
            telescope_builtin.current_buffer_fuzzy_find,
            { desc = "Live fuzzy search inside of the currently open buffer" }
        )
    end

    local function lsp_pickers()
        -- List LSP document symbols in the current buffer.
        vim.keymap.set(
            "n", leader .. "S", telescope_builtin.lsp_document_symbols,
            { desc = "List LSP document symbols in the current buffer" }
        )

        -- List LSP document symbols in the current buffer.
        vim.keymap.set(
            "n", leader .. "s", telescope_builtin.lsp_workspace_symbols,
            { desc = "List LSP document symbols in the current buffer" }
        )

        -- List diagnostics.
        vim.keymap.set(
            "n", leader .. "d", telescope_builtin.diagnostics,
            { desc = "List diagnostics" }
        )
    end

    local function main()
        file_pickers()
        vim_pickers()
        lsp_pickers()

        telescope.setup(telescope_setup)
    end

    main()
end

-- Find, Filter, Preview, Pick. All lua, all the time.
require("packer").use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim"
    },
    config = telescope_config
})
