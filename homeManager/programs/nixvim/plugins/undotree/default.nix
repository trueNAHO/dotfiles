{config, ...}: {
  programs.nixvim = {
    maps = config.nixvim.helpers.mkMaps {silent = true;} {
      normal."<leader>u".action = "<cmd>UndotreeToggle<cr>";
    };

    plugins.undotree.enable = true;
  };
}
