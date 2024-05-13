{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.nvim-tree.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.nvim-tree";

  config = lib.mkIf config.dotfiles.programs.nixvim.plugins.nvim-tree.enable {
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
