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

    -- Color scheme.
    require("user.plugins.joshdick_onedark_vim")

    -- Automatically set up your configuration after cloning `packer.nvim`. Put
    -- this at the end after all plugins
    if packer_bootstrap then require("packer").sync() end
end)
