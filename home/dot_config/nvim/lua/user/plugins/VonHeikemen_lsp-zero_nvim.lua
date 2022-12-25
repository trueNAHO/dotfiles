-- A starting point to setup some LSP related features in neovim.

require("packer").use({
    "VonHeikemen/lsp-zero.nvim",

    requires = {
        -- Plugins for LSP Support.
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",

        -- Plugins for Autocompletion.
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "hrsh7th/nvim-cmp",
        "saadparwaiz1/cmp_luasnip",

        -- Plugins for Snippets.
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    },

    config = function()
        local cmp = require("cmp")
        local lsp = require("lsp-zero")

        local leader = "<leader>l"

        -- Add a new mapping to the current buffer.
        local function keymap_buffer(mode, lhs, rhs, bufnr, opts)
            vim.keymap.set(
                mode, lhs, rhs,
                vim.tbl_deep_extend("force", { buffer = bufnr }, opts or {})
            )
        end

        -- Set the `cmp` up.
        local function cmp_setup()
            local mapping = lsp.defaults.cmp_mappings()

            cmp.setup(lsp.defaults.cmp_config({
                mapping = lsp.defaults.cmp_mappings({
                    ["<C-b>"] = mapping["<C-u>"],
                    ["<C-u>"] = mapping["<C-b>"]
                }),

                window = {
                    completion = cmp.config.window.bordered()
                }
            }))
        end

        -- Set the `lsp` up.
        local function lsp_setup()
            lsp.set_preferences({
                call_servers = "local",
                cmp_capabilities = true,
                configure_diagnostics = false,
                manage_nvim_cmp = true,
                set_lsp_keymaps = false,
                setup_servers_on_start = true,
                --sign_icons = {
                --    error = '✘',
                --    hint = '⚑',
                --    info = '',
                --    warn = '▲'
                --},
                suggest_lsp_servers = true,
            })

            lsp.configure("sumneko_lua", {
                settings = {
                    Lua = {
                        diagnostics = {
                            -- Get the language server to recognize the `vim`
                            -- global.
                            globals = { "vim" }
                        }
                    }
                }
            })

            lsp.on_attach(function(client, bufnr)
                keymap_buffer(
                    "n", "<C-k>", vim.lsp.buf.signature_help, bufnr,
                    {
                        desc = "<C-k>. Displays signature information about the symbol under the cursor in a floating window."
                    }
                )

                keymap_buffer(
                    "n", "K", vim.lsp.buf.hover, bufnr
                )

                keymap_buffer(
                    "n", "[d", vim.diagnostic.goto_prev, bufnr
                )

                keymap_buffer(
                    "n", "]d", vim.diagnostic.goto_next, bufnr
                )

                keymap_buffer(
                    "n", "gD", vim.lsp.buf.declaration, bufnr
                )

                keymap_buffer(
                    "n", "gd", vim.lsp.buf.definition, bufnr
                )

                keymap_buffer(
                    "n", "gl", vim.diagnostic.open_float, bufnr,
                    {
                        desc = "Get Diagnostics List. Show diagnostics in a floating window."
                    }
                )

                keymap_buffer(
                    "n", leader .. "a", vim.lsp.buf.code_action, bufnr,
                    {
                        desc = "LSP code Action. Selects a code action available at the current cursor position."
                    }
                )

                keymap_buffer(
                    "n", leader .. "i", vim.lsp.buf.implementation, bufnr,
                    {
                        desc = "LSP Implementation. Lists all the implementations for the symbol under the cursor in the quickfix window."
                    }
                )

                keymap_buffer(
                    "n", leader .. "l", vim.lsp.buf.references, bufnr,
                    {
                        desc = "LSP List references. Lists all the references to the symbol under the cursor in the quickfix window."
                    }
                )

                keymap_buffer(
                    "n", leader .. "r", vim.lsp.buf.rename, bufnr,
                    {
                        desc = "LSP Rename. Renames all references to the symbol under the cursor."
                    }
                )

                keymap_buffer(
                    "n", leader .. "t", vim.lsp.buf.type_definition, bufnr,
                    {
                        desc = "LSP Type definition. Jumps to the definition of the type of the symbol under the cursor."
                    }
                )

                keymap_buffer(
                    { "n", "v" }, leader .. "f",
                    function() vim.lsp.buf.format({ timeout_ms = 5000 }) end,
                    bufnr,
                    {
                        desc = "LSP Format. Formats a buffer using the attached (and optionally filtered) language server clients."
                    }
                )
            end)

            lsp.setup()
        end


        -- Set the vim diagnostics up.
        local function vim_diagnostic_setup()
            vim.diagnostic.config({ severity_sort = true })
        end

        local function main()
            cmp_setup()
            lsp_setup()
            vim_diagnostic_setup()
        end

        main()
    end
})
