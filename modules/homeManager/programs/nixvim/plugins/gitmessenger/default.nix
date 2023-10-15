{config, ...}: {
  programs.nixvim = {
    maps = config.nixvim.helpers.mkMaps {silent = true;} {
      normal."<leader>gl".action = "<cmd>GitMessenger<cr>";
    };

    plugins.gitmessenger = {
      enable = true;
      floatingWinOps.border = "rounded";
      includeDiff = "all";
      noDefaultMappings = true;
      popupContentMargins = false;
    };
  };
}
