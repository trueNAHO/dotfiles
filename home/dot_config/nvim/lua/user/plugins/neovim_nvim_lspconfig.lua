-- Quickstart configs for Nvim LSP.

-- Specify code to run after loading plugin.
local function lsp_config()
    local lspconfig = require("lspconfig")

    local leader = "<leader>l"

    -- Set autocommand properties.
    local lsp_autocommand = {
        desc = "LSP actions",
        event = "User",
        pattern = "LspAttached"
    }

    local prefix = {
        desc_a = "Action. ",
        desc_d = "Diagnostics. ",
        desc_f = "Format. ",
        desc_gd = "Goto Declaration. ",
        desc_i = "Implementations. ",
        desc_k = "Keyword program. ",
        desc_l = "List. ",
        desc_n = "Next. ",
        desc_p = "Previous. ",
        desc_r = "Rename. ",
        desc_s = "Signature. "
    }

    -- Add a new mapping to local buffer.
    local function keymap_buffer(mode, lhs, rhs, opts)
        vim.keymap.set(
            mode, lhs, rhs,
            vim.tbl_deep_extend("force", { buffer = true }, opts)
        )
    end

    -- Set mappings for LSP.
    local function lspconfig_keymap_set()
        -- Display hover information about the symbol under the cursor in
        -- a floating window. Calling the function twice will jump into the
        -- floating window.
        keymap_buffer(
            "n", "K", vim.lsp.buf.hover,
            {
                desc = prefix.desc_k .. "Display hover information about " ..
                    "the symbol under the cursor in a floating window. " ..
                    "Calling the function twice will jump into the floating " ..
                    "window"
            }
        )

        -- Select a code action available at the current cursor position.
        keymap_buffer(
            { "n", "x" }, leader .. "a", vim.lsp.buf.code_action,
            {
                desc = prefix.desc_a .. "Select a code action available at " ..
                    "the current cursor position"
            }
        )

        -- Show diagnostics in a floating window.
        keymap_buffer(
            "n", leader .. "d", vim.diagnostic.open_float,
            { desc = prefix.desc_d .. "Show diagnostics in a floating window" }
        )

        -- Formats a buffer using the attached (and optionally filtered)
        -- language server clients.
        keymap_buffer(
            "n", leader .. "f", vim.lsp.buf.format,
            {
                desc = prefix.desc_f ..
                    "Formats a buffer using the attached (and optionally " ..
                    "filtered) language server clients"
            }
        )

        -- Jump to the declaration of the symbol under the cursor. Many servers
        -- do not implement this method. Generally, see
        -- `vim.lsp.buf.definition()` instead.
        keymap_buffer(
            "n", "gD", vim.lsp.buf.declaration,
            {
                desc = prefix.desc_gd .. "Jump to the declaration of the " ..
                    "symbol under the cursor. Many servers do not implement " ..
                    "this method. Generally, see " ..
                    "`vim.lsp.buf.definition()` instead"
            }
        )

        -- Jump to the definition of the symbol under the cursor.
        keymap_buffer(
            "n", "gd", vim.lsp.buf.definition,
            {
                desc = prefix.desc_gd .. "Jump to the definition of the " ..
                    "symbol under the cursor"
            }
        )

        -- List all the implementations for the symbol under the cursor.
        keymap_buffer(
            "n", leader .. "i", vim.lsp.buf.implementation,
            {
                desc = prefix.desc_i .. "List all the implementations for " ..
                    "the symbol under the cursor"
            }
        )

        -- List all the references to the symbol under the cursor in the
        -- quickfix window.
        keymap_buffer(
            "n", leader .. "l", vim.lsp.buf.references,
            {
                desc = prefix.desc_l .. "List all the references to the " ..
                    "symbol under the cursor in the quickfix window"
            }
        )

        -- Move to the next diagnostic.
        keymap_buffer(
            "n", leader .. "n", vim.diagnostic.goto_next,
            { desc = prefix.desc_n .. "Move to the next diagnostic" }
        )

        -- Move to the previous diagnostic.
        keymap_buffer(
            "n", leader .. "p", vim.diagnostic.goto_prev,
            { desc = prefix.desc_p .. "Move to the previous diagnostic" }
        )

        -- Rename all references to the symbol under the cursor.
        keymap_buffer(
            "n", leader .. "r", vim.lsp.buf.rename,
            { desc = prefix.desc_r .. "Rename all references to the symbol " ..
                "under the cursor" }
        )

        -- Display signature information about the symbol under the cursor in
        -- a floating window.
        keymap_buffer(
            "n", leader .. "s", vim.lsp.buf.signature_help,
            {
                desc = prefix.desc_s ..
                    "Display signature information about the symbol under " ..
                    "the cursor in a floating window"
            }
        )
    end

    -- Setup LSPs.
    local function lspconfig_setup()
        lspconfig.bashls.setup({})

        lspconfig.html.setup({})

        lspconfig.marksman.setup({})

        lspconfig.pyright.setup({})

        lspconfig.sumneko_lua.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim`
                        -- global.
                        globals = { "vim" }
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files.
                        library = vim.api.nvim_get_runtime_file("", true)
                    }
                }
            }
        })

        lspconfig.texlab.setup({})

        lspconfig.tsserver.setup({})

        lspconfig.yamlls.setup({})
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
                        lsp_autocommand.event,
                        { pattern = lsp_autocommand.pattern }
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
            lsp_autocommand.event,
            {
                pattern = lsp_autocommand.pattern,
                desc = lsp_autocommand.desc,
                callback = lspconfig_keymap_set
            }
        )
    end

    local function main()
        lspconfig_util_default_config()
        nvim_create_autocmd_LspAttached()
        lspconfig_setup()
    end

    main()
end

require("packer").use({
    "neovim/nvim-lspconfig",
    config = lsp_config
})
