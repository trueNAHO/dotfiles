{config, ...}: {
  programs.nixvim = {
    maps = config.nixvim.helpers.mkMaps {silent = true;} {
      normalVisualOp."<leader>f".action = "<cmd>lua require('leap').leap({ target_windows = vim.tbl_filter(function(win) return vim.api.nvim_win_get_config(win).focusable end, vim.api.nvim_tabpage_list_wins(0)) })<cr>";
    };

    plugins.leap = {
      addDefaultMappings = false;
      enable = true;
      extraOptions = {safe_labels = {};};
    };
  };
}
