{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.undotree.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.undotree";

  config = lib.mkIf config.dotfiles.programs.nixvim.plugins.undotree.enable {
    programs.nixvim = {
      keymaps = [
        {
          action = "vim.cmd.UndotreeToggle";
          key = "<leader>u";
          lua = true;
          mode = "n";
          options.silent = true;
        }
      ];

      plugins.undotree.enable = true;
    };
  };
}
