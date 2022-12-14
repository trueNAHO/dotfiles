local packer = require("packer")
local plugin = {}

-- Modify the default behaviour.
function plugin.behaviour()
    -- A starting point to setup some LSP related features in neovim.
    require("user.plugins.VonHeikemen_lsp-zero_nvim")

    -- Use Neovim as a language server to inject LSP diagnostics, code actions,
    -- and more via Lua. IMPORTANT: This pluging must be loaded after the
    -- `lsp-zero` plugin.
    require("user.plugins.jay-babu_mason-null-ls_nvim")

    -- Syntax aware text-objects, select, move, swap, and peek support.
    require("user.plugins.nvim-treesitter_nvim-treesitter-textobjects")
end

-- Set a color scheme.
function plugin.colorscheme()
    --require("user.plugins.catppuccin_nvim")
    --require("user.plugins.folke_tokyonight_nvim_day")
    --require("user.plugins.folke_tokyonight_nvim_moon")
    --require("user.plugins.folke_tokyonight_nvim_night")
    require("user.plugins.folke_tokyonight_nvim_storm")
    --require("user.plugins.joshdick_onedark_vim")
end

-- Install packer, if it is not already installed. Return true if packer will be
-- installed. Otherwise return false.
function plugin.ensure_packer()
    local vim_fn = vim.fn
    local install_path = vim_fn.stdpath("data") ..
        "/site/pack/packer/start/packer.nvim"

    if vim_fn.empty(vim_fn.glob(install_path)) > 0 then
        vim_fn.system({
            "git", "clone", "--depth", "1",
            "https://github.com/wbthomason/packer.nvim", install_path
        })
        vim.cmd("packadd packer.nvim")
        return true
    end

    return false
end

-- Add new non essential utilities related to maintaining neovim.
function plugin.non_essential_utilities()
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and
    -- formatters.
    require("user.plugins.williamboman_mason_nvim")
end

-- Packer can manage itself.
function plugin.packer()
    require("user.plugins.wbthomason_packer_nvim")
end

-- Automatically set up your configuration after cloning `packer.nvim`. Put
-- this at the end after all plugins.
function plugin.setup()
    if plugin.ensure_packer() then packer.sync() end
end

-- Add new utilities.
function plugin.utilities()
    -- A file explorer tree for neovim written in lua.
    require("user.plugins.nvim-tree_nvim-tree_lua")

    -- Magit for neovim.
    require("user.plugins.TimUntersberger_neogit")

    -- Neovim's answer to the mouse: a "clairvoyant" interface that makes
    -- on-screen jumps quicker and more natural than ever.
    require("user.plugins.ggandor_leap_nvim")

    -- The undo history visualizer for VIM.
    require("user.plugins.mbbill_undotree")

    -- Find, Filter, Preview, Pick. All lua, all the time.
    require("user.plugins.nvim_telescope_telescope_nvim")

    -- Smart and powerful comment plugin for neovim. Supports treesitter, dot
    -- repeat, left-right/up-down motions, hooks, and more.
    require("user.plugins.numToStr_Comment_nvim")

    -- A neovim plugin to run lines/blocs of code (independently of the rest of
    -- the file), supporting multiples languages.
    require("user.plugins.michaelb_sniprun")
end

-- Enhance the default visual effects.
function plugin.visuals()
    -- Nvim Treesitter configurations and abstraction layer.
    require("user.plugins.nvim-treesitter_nvim-treesitter")

    -- Show code context.
    require("user.plugins.nvim-treesitter_nvim-treesitter-context")

    -- Rainbow parentheses for neovim using tree-sitter.
    require("user.plugins.p00f_nvim-ts-rainbow")

    -- The fastest Neovim colorizer.
    require("user.plugins.norcalli_nvim_colorizer")
end

return packer.startup(function()
    plugin.packer()
    plugin.behaviour()
    plugin.utilities()
    plugin.colorscheme()
    plugin.visuals()
    plugin.non_essential_utilities()

    -- Automatically set up your configuration after cloning `packer.nvim`. Put
    -- this at the end after all plugins.
    plugin.setup()
end)
