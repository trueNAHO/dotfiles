local function telescope_config()
    local telescope = require("telescope")
    local telescope_actions = require('telescope.actions')
    local telescope_builtin = require("telescope.builtin")

    local leader = "<leader>t"

    local prefix_desc_b = "Buffers. "
    local prefix_desc_c = "Command. "
    local prefix_desc_d = "Diagnostics. "
    local prefix_desc_f = "Find. "
    local prefix_desc_g = "Grep. "
    local prefix_desc_h = "Help. "
    local prefix_desc_k = "Keymappings. "
    local prefix_desc_l = "List. "
    local prefix_desc_o = "Options. "
    local prefix_desc_q = "Quickfix. "
    local prefix_desc_s = "Search. "
    local prefix_desc_x = "Oldfiles. "

    local telescope_setup = {
        defaults = {
            layout_strategy = "vertical",
            mappings = {
                i = {
                    ["<C-j>"] = telescope_actions.select_default
                }
            }
        }
    }

    local function file_pickers()
        -- Lists open buffers in current neovim instance, opens selected buffer
        -- on <cr>.
        vim.keymap.set(
            "n", leader .. "b", telescope_builtin.buffers,
            {
                desc = prefix_desc_b .. "Lists open buffers in current " ..
                    "neovim instance, opens selected buffer on <cr>."
            }
        )

        -- Search for files (respecting .gitignore).
        vim.keymap.set(
            "n", leader .. "f", telescope_builtin.find_files,
            {
                desc = prefix_desc_f .. "Search for files (respecting " ..
                    ".gitignore)"
            }
        )

        -- Search for a string and get results live while typing (respecting
        -- .gitignore).
        vim.keymap.set(
            "n", leader .. "g", telescope_builtin.live_grep,
            {
                desc = prefix_desc_g .. "Search for a string and get " ..
                    "results live while typing (respecting .gitignore)"
            }
        )

        -- Search for the string under the cursor in the current working
        -- directory.
        vim.keymap.set(
            "n", leader .. "l", telescope_builtin.grep_string,
            {
                desc = prefix_desc_l .. "Search for the string under the " ..
                    "cursor in the current working directory"
            }
        )

        -- Lists previously open files, opens on `<cr>`.
        vim.keymap.set(
            "n", leader .. "x", telescope_builtin.oldfiles,
            {
                desc = prefix_desc_x .. "Lists previously open files, opens " ..
                    "on `<cr>`"
            }
        )

    end

    local function vim_pickers()
        -- Live fuzzy search inside of the currently open buffer.
        vim.keymap.set(
            "n", leader .. "G",
            telescope_builtin.current_buffer_fuzzy_find,
            {
                desc = prefix_desc_g .. "Live fuzzy search inside of the " ..
                    "currently open buffer"
            }
        )

        -- List recently executed commands and rerun them on `<cr>`.
        vim.keymap.set(
            "n", leader .. "c", telescope_builtin.command_history,
            {
                desc = prefix_desc_c .. "List recently executed commands " ..
                    "and rerun them on `<cr>`"
            }
        )

        -- List vailable help tags and open a new window with the relevant
        -- help info on `<cr>`.
        vim.keymap.set(
            "n", leader .. "h", telescope_builtin.help_tags,
            {
                desc = prefix_desc_h .. "List vailable help tags and open a " ..
                    "new window with the relevant help info on `<cr>`"
            }
        )

        -- List normal mode keymappings and run the selected keymap on `<cr>`.
        vim.keymap.set(
            "n", leader .. "k", telescope_builtin.keymaps,
            {
                desc = prefix_desc_k .. "List normal mode keymappings and " ..
                    "run the selected keymap on `<cr>`"
            }
        )

        -- List vim options and edit the current value on `<cr>`.
        vim.keymap.set(
            "n", leader .. "o", telescope_builtin.vim_options,
            {
                desc = prefix_desc_o .. "List vim options and edit the " ..
                    "current value on `<cr>`"
            }
        )

        -- List items in the quickfix list and jump to location on `<cr>`.
        vim.keymap.set(
            "n", leader .. "q", telescope_builtin.quickfix,
            {
                desc = prefix_desc_q .. "List items in the quickfix list " ..
                    "and jump to location on `<cr>`"
            }
        )
    end

    local function lsp_pickers()
        -- List LSP document symbols in the current buffer.
        vim.keymap.set(
            "n", leader .. "S", telescope_builtin.lsp_document_symbols,
            {
                desc = prefix_desc_s .. "List LSP document symbols in the " ..
                    "current buffer"
            }
        )

        -- List diagnostics.
        vim.keymap.set(
            "n", leader .. "d", telescope_builtin.diagnostics,
            { desc = prefix_desc_d .. "List diagnostics" }
        )

        -- List LSP document symbols in the current workspace.
        vim.keymap.set(
            "n", leader .. "s", telescope_builtin.lsp_workspace_symbols,
            {
                desc = prefix_desc_s .. "List LSP document symbols in the " ..
                    "current workspace"
            }
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
