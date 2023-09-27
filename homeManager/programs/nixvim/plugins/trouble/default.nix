{config, ...}: {
  programs.nixvim = {
    maps = config.nixvim.helpers.mkMaps {silent = true;} {
      normal. "<leader>ll".action = "<cmd>TroubleToggle<cr>";
    };

    plugins.trouble.enable = true;
  };
}
