-- Quickstart configs for Nvim LSP.

-- Specify code to run after loading plugin.
local function lsp_config()
    local lspconfig = require("lspconfig")

    -- Set autocommand properties.
    local lsp_autocommand_decs = "LSP actions"
    local lsp_autocommand_event = "User"
    local lsp_autocommand_pattern = "LspAttached"

    -- Add a new mapping to local buffer.
    local function keymap_buffer(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, {buffer = true})
    end

    -- Set mappings for LSP.
    local function lspconfig_keymap_set()
        -- Display hover information about the symbol under the cursor.
        keymap_buffer("n", "K", function() vim.lsp.buf.hover() end)

        -- Jump to the definition.
        keymap_buffer("n", "gd", function() vim.lsp.buf.definition() end)

        -- Jump to declaration.
        keymap_buffer("n", "gD", function() vim.lsp.buf.declaration() end)

        -- List all the implementations for the symbol under the cursor.
        keymap_buffer("n", "gi", function() vim.lsp.buf.implementation() end)

        -- Jump to the definition of the type symbol.
        keymap_buffer("n", "go", function() vim.lsp.buf.type_definition() end)

        -- List all the references .
        keymap_buffer("n", "gr", function() vim.lsp.buf.references() end)

        -- Display a function"s signature information.
        keymap_buffer("n", "<C-k>", function() vim.lsp.buf.signature_help() end)

        -- Rename all references to the symbol under the cursor.
        keymap_buffer("n", "<F2>", function() vim.lsp.buf.rename() end)

        -- Select a code action available at the current cursor position.
        keymap_buffer("n", "<F4>", function() vim.lsp.buf.code_action() end)
        keymap_buffer("x", "<F4>",
                      function() vim.lsp.buf.range_code_action() end)
        -- Show diagnostics in a floating window.
        keymap_buffer("n", "gl", function() vim.diagnostic.open_float() end)

        -- Move to the previous diagnostic.
        keymap_buffer("n", "[d", function() vim.diagnostic.goto_prev() end)

        -- Move to the next diagnostic.
        keymap_buffer("n", "]d", function() vim.diagnostic.goto_next() end)
    end

    -- The global defaults for all servers can be overridden by extending the
    -- `default_config` table.
    local function lspconfig_util_default_config()
        lspconfig.util.default_config = vim.tbl_deep_extend(
            "force",
            lspconfig.util.default_config,
            {
                on_attach = function()
                    vim.api.nvim_exec_autocmds(
                        lsp_autocommand_event,
                        {pattern = lsp_autocommand_pattern}
                    )
                end
            }
        )
    end

    -- Create the `LspAttached` autocommand.
    local function nvim_create_autocmd_LspAttached()
        vim.api.nvim_create_autocmd(
            lsp_autocommand_event,
            {
                pattern = lsp_autocommand_pattern,
                desc = lsp_autocommand_decs,
                callback = lspconfig_keymap_set
            }
        )
    end

    local function main()
        lspconfig_util_default_config()
        nvim_create_autocmd_LspAttached()

        lspconfig.sumneko_lua.setup{
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim`
                        -- global.
                        globals = {"vim"}
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files.
                        library = vim.api.nvim_get_runtime_file("", true)
                    }
                }
            }
        }
    end

    main()
end

require("packer").use{
    "neovim/nvim-lspconfig",
    config = lsp_config
}
