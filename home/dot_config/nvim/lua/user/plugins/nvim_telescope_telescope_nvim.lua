local function telescope_config()
    local telescope_builtin = require("telescope.builtin")

    local leader_prefix = "<leader>f"

    local function file_pickers()
        -- Search for files (respecting .gitignore).
        vim.keymap.set("n", leader_prefix .. "ff", telescope_builtin.find_files)

        -- Searches for the string under your cursor in your current working
        -- directory.
        vim.keymap.set("n", leader_prefix .. "gs",
            telescope_builtin.grep_string)

        -- Search for a string and get results live as you type (respecting
        -- .gitignore).
        vim.keymap.set("n", leader_prefix .. "lg", telescope_builtin.live_grep)
    end

    local function vim_pickers()
        -- Lists commands that were executed recently, and reruns them on
        -- `<cr>`.
        vim.keymap.set("n", leader_prefix .. "ch",
                       telescope_builtin.command_history)

        -- Lists available help tags and opens a new window with the relevant
        -- help info on `<cr>`.
        vim.keymap.set("n", leader_prefix .. "ht", telescope_builtin.help_tags)

        -- Lists items in the quickfix list, jumps to location on `<cr>`.
        vim.keymap.set("n", leader_prefix .. "qf", telescope_builtin.quickfix)

        -- Lists vim options, allows you to edit the current value on `<cr>`.
        vim.keymap.set("n", leader_prefix .. "vo",
            telescope_builtin.vim_options)

        -- Lists normal mode keymappings, runs the selected keymap on `<cr>`.
        vim.keymap.set("n", leader_prefix .. "km", telescope_builtin.keymaps)

        -- Live fuzzy search inside of the currently open buffer.
        vim.keymap.set("n", leader_prefix .. "fb",
                       telescope_builtin.current_buffer_fuzzy_find)
    end

    local function lsp_pickers()
        -- Lists LSP document symbols in the current buffer.
        vim.keymap.set("n", leader_prefix .. "fs",
                       telescope_builtin.lsp_document_symbols)

        -- Lists LSP document symbols in the current buffer.
        vim.keymap.set("n", leader_prefix .. "lS",
                       telescope_builtin.lsp_workspace_symbols)

        -- Lists diagnostics.
        vim.keymap.set("n", leader_prefix .. "dg",
                       telescope_builtin.diagnostics)
    end

    local function main()
        file_pickers()
        vim_pickers()
        lsp_pickers()
    end

    main()
end

-- Find, Filter, Preview, Pick. All lua, all the time.
require("packer").use{
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim"
    },
    config = telescope_config
}
