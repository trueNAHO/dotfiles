-- Install packer, if it is not already installed. Return true if packer will be
-- installed. Otherwise return false.
local function ensure_packer()
    local vim_fn = vim.fn
    local install_path = vim_fn.stdpath("data") ..
        "/site/pack/packer/start/packer.nvim"

    if vim_fn.empty(vim_fn.glob(install_path)) > 0 then
        vim_fn.system{
            "git", "clone", "--depth", "1",
            "https://github.com/wbthomason/packer.nvim", install_path
        }
        vim.cmd("packadd packer.nvim")
        return true
    end

    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function()
    -- Packer can manage itself.
    require("user.plugins.wbthomason_packer_nvim")

    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and
    -- formatters.
    require("user.plugins.williamboman_mason_nvim")

    -- Language Server Protocol (LSP).
    require("user.plugins.neovim_nvim_lspconfig")

    -- Autocompletion.
    require("user.plugins.hrsh7th_nvim_cmp")

    -- Find, Filter, Preview, Pick. All lua, all the time.
    require("user.plugins.nvim_telescope_telescope_nvim")

    -- The undo history visualizer for VIM.
    require("user.plugins.bbill_undotree")

    -- Color scheme.
    --require("user.plugins.catppuccin_nvim")
    --require("user.plugins.joshdick_onedark_vim")
    --require("user.plugins.tokyonight_nvim_day")
    --require("user.plugins.tokyonight_nvim_moon")
    --require("user.plugins.tokyonight_nvim_night")
    require("user.plugins.tokyonight_nvim_storm")

    -- Automatically set up your configuration after cloning `packer.nvim`. Put
    -- this at the end after all plugins.
    if packer_bootstrap then require("packer").sync() end
end)
