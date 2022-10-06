local function telescope_config()
    local telescope_builtin = require("telescope.builtin")

    local leader_prefix = "<leader>f"

    local function file_pickers()
        -- Search for files (respecting .gitignore).
        vim.keymap.set("n", leader_prefix .. "ff", telescope_builtin.find_files)

        -- Fuzzy search for files tracked by Git. This command lists the output
        -- of the `git ls-files` command, respects .gitignore, and optionally
        -- ignores untracked files.
        vim.keymap.set("n", leader_prefix .. "gf", telescope_builtin.git_files)

        -- Searches for the string under your cursor in your current working
        -- directory.
        vim.keymap.set("n", leader_prefix .. "gs",
            telescope_builtin.grep_string)

        -- Search for a string and get results live as you type (respecting
        -- .gitignore).
        vim.keymap.set("n", leader_prefix .. "lg", telescope_builtin.live_grep)
    end

    local function main()
        file_pickers()
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
