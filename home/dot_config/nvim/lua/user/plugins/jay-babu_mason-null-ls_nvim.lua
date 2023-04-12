-- `mason-null-ls` bridges `mason.nvim` with the `null-ls` plugin - making it
-- easier to use both plugins together.

require("packer").use({
    "jay-babu/mason-null-ls.nvim",

    requires = {
        "jose-elias-alvarez/null-ls.nvim",
        "nvim-lua/plenary.nvim",
        "williamboman/mason.nvim",
    },

    config = function()
        local mason_null_ls = require("mason-null-ls")
        local mason_null_ls_setup = require("mason-null-ls.automatic_setup")
        local null_ls = require("null-ls")

        local column_width = 80

        mason_null_ls.setup({
            automatic_installation = true,
            automatic_setup = true,
            handlers = {
                function(source_name, methods)
                    mason_null_ls_setup(source_name, methods)
                end,
                stylua = function(source_name, methods)
                    null_ls.register(null_ls.builtins.formatting.stylua.with({
                        extra_args = {
                            "--column-width",
                            column_width,
                            "--indent-type",
                            "Spaces",
                        },
                    }))
                end,
            }
        })

        null_ls.setup()
    end,
})
