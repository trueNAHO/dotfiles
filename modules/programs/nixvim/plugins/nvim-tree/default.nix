{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.nvim-tree.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.nvim-tree";

  config = lib.mkIf config.modules.programs.nixvim.plugins.nvim-tree.enable {
    programs.nixvim = {
      keymaps = [
        {
          action = "require('nvim-tree.api').tree.toggle";
          key = "<leader>e";
          lua = true;
          mode = "n";
          options.silent = true;
        }
      ];

      plugins.nvim-tree.enable = true;
    };
  };
}
