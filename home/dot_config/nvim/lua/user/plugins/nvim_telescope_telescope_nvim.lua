-- Find, Filter, Preview, Pick. All lua, all the time.
require("packer").use{
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim"
    }
}
