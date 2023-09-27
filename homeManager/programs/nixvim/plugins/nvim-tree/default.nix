{config, ...}: {
  programs.nixvim = {
    maps = config.nixvim.helpers.mkMaps {silent = true;} {
      normal."<leader>e".action = "<cmd>NvimTreeToggle<cr>";
    };

    plugins.nvim-tree.enable = true;
  };
}
