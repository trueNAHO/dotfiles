{config, ...}: {
  programs.nixvim = {
    maps = config.nixvim.helpers.mkMaps {silent = true;} {
      normal."<leader>v".action = "<cmd>MCstart<cr>";
    };

    plugins.multicursors = {
      enable = true;
      extraOptions.hint_config = false;
    };
  };
}
