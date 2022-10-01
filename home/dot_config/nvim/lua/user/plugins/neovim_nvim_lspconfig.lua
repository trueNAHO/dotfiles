-- Quickstart configs for Nvim LSP.

-- Specify code to run after loading plugin.
local function lsp_config()
    local lspconfig = require("lspconfig")

    -- Set autocommand properties.
    local lsp_autocommand_decs = "LSP actions"
    local lsp_autocommand_event = "User"
    local lsp_autocommand_pattern = "LspAttached"

    local leader_prefix = "<leader>l"

    -- Add a new mapping to local buffer.
    local function keymap_buffer(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, {buffer = true})
    end

    -- Set mappings for LSP.
    local function lspconfig_keymap_set()
        -- Display hover information about the symbol under the cursor in
        -- a floating window. Calling the function twice will jump into the
        -- floating window.
        keymap_buffer("n", "K", vim.lsp.buf.hover)

        -- Jump to the declaration of the symbol under the cursor. Many servers
        -- do not implement this method. Generally, see
        -- `vim.lsp.buf.definition()` instead.
        keymap_buffer("n", "gD", vim.lsp.buf.declaration)

        -- Jump to the definition of the symbol under the cursor.
        keymap_buffer("n", "gd", vim.lsp.buf.definition)

        -- Show diagnostics in a floating window.
        keymap_buffer("n", leader_prefix .. "d", vim.diagnostic.open_float)

        -- List all the implementations for the symbol under the cursor.
        keymap_buffer("n", leader_prefix .. "i", vim.lsp.buf.implementation)

        -- List all the references to the symbol under the cursor in the
        -- quickfix window.
        keymap_buffer("n", leader_prefix .. "l", vim.lsp.buf.references)

        -- Move to the next diagnostic.
        keymap_buffer("n", leader_prefix .. "n", vim.diagnostic.goto_next)

        -- Move to the previous diagnostic.
        keymap_buffer("n", leader_prefix .. "p", vim.diagnostic.goto_prev)

        -- Rename all references to the symbol under the cursor.
        keymap_buffer("n", leader_prefix .. "r", vim.lsp.buf.rename)

        -- Display signature information about the symbol under the cursor in
        -- a floating window.
        keymap_buffer("n", leader_prefix .. "s", vim.lsp.buf.signature_help)

        -- Select a code action available at the current cursor position.
        keymap_buffer({"n", "x"}, leader_prefix .. "a", vim.lsp.buf.code_action)
    end

    -- The global defaults for all servers can be overridden by extending the
    -- `default_config` table.
    local function lspconfig_util_default_config()
        lspconfig.util.default_config = vim.tbl_deep_extend(
            "force",
            lspconfig.util.default_config,
            {
                on_attach = function(_, bufnr)
                    vim.api.nvim_exec_autocmds(
                        lsp_autocommand_event,
                        {pattern = lsp_autocommand_pattern}
                    )
                    -- Enable completion triggered by <c-x><c-o>.
                    vim.api.nvim_buf_set_option(bufnr, 'omnifunc',
                                                'v:lua.vim.lsp.omnifunc')
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

        lspconfig.pyright.setup{}

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
