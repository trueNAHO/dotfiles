-- Syntax aware text-objects, select, move, swap, and peek support.
require("packer").use({
    "nvim-treesitter/nvim-treesitter-textobjects",

    requires = "nvim-treesitter/nvim-treesitter",

    config = function()
        local treesitter_configs = require("nvim-treesitter.configs")

        treesitter_configs.setup({
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true,

                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },

                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },

                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },

                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },

                select = {
                    enable = true,
                    include_surrounding_whitespace = false,
                    lookahead = true,

                    keymaps = {
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",

                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",

                        ["ai"] = "@conditional.outer",
                        ["ii"] = "@conditional.inner",

                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                    },

                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "<c-v>",
                    },
                },
            },
        })
    end,
})
