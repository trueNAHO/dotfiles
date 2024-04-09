{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.leap.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.leap";

  config = lib.mkIf config.modules.programs.nixvim.plugins.leap.enable {
    programs.nixvim = {
      keymaps = [
        {
          action = ''
            function()
                require("leap").leap({
                    target_windows = vim.tbl_filter(function(win)
                        return vim.api.nvim_win_get_config(win).focusable
                    end, vim.api.nvim_tabpage_list_wins(0)),
                })
            end
          '';
          key = "<leader>f";
          lua = true;
          mode = ["n" "v"];
          options.silent = true;
        }
      ];

      plugins.leap = {
        addDefaultMappings = false;
        enable = true;
        extraOptions = {safe_labels = {};};
      };
    };
  };
}
