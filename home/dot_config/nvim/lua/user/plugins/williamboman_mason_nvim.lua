-- Portable package manager for Neovim that runs everywhere Neovim runs. Easily
-- install and manage LSP servers, DAP servers, linters, and formatters.
require("packer").use{
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end
}
