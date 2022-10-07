local table_merge = require("user.lib.table.merge")

local requires_mandatory = { "L3MON4D3/LuaSnip", "hrsh7th/cmp-nvim-lsp" }
local requires_optional = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path"
}

-- A completion plugin for neovim coded in Lua.
require("packer").use({
    "hrsh7th/nvim-cmp",
    -- REQUIRED: Must sepcify a snipped engine.
    requires = table_merge(requires_mandatory, requires_optional),
    config = function()
        vim.opt.cot = { "menu", "menuone", "noselect" }

        local cmp = require("cmp")
        local luasnip = require("luasnip")

        local kind_icons = {
            --Text = "",
            --Method = "m",
            --Function = "",
            --Constructor = "",
            --Field = "",
            --Variable = "",
            --Class = "",
            --Interface = "",
            --Module = "",
            --Property = "",
            --Unit = "",
            --Value = "",
            --Enum = "",
            --Keyword = "",
            --Snippet = "",
            --Color = "",
            --File = "",
            --Reference = "",
            --Folder = "",
            --EnumMember = "",
            --Constant = "",
            --Struct = "",
            --Event = "",
            --Operator = "",
            --TypeParameter = "",
        }

        cmp.setup({
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = kind_icons[vim_item.kind]
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snippet]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-1),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-f>"] = cmp.mapping.scroll_docs(1),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-y>"] = cmp.mapping.confirm({ select = true })
            }),

            -- REQUIRED: Must sepcify a snipped engine.
            snippet = {
                expand = function(args) luasnip.lsp_expand(args.body) end
            },

            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" }
            },

            --window = {
            --    completion = cmp.config.window.bordered(),
            --    documentation = cmp.config.window.bordered()
            --}
        })
    end
})
