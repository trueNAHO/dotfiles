{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.wtf.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.wtf";

  config = lib.mkIf config.modules.programs.nixvim.plugins.wtf.enable {
    programs.nixvim = {
      keymaps = [
        {
          action = "function() require('wtf').search('duck_duck_go') end";
          key = "<leader>ls";
          lua = true;
          mode = "n";
          options.silent = true;
        }
      ];

      plugins.wtf.enable = true;
    };
  };
}
