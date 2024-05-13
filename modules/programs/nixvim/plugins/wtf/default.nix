{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.wtf.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.wtf";

  config = lib.mkIf config.dotfiles.programs.nixvim.plugins.wtf.enable {
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
