{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.undotree.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.undotree";

  config = lib.mkIf config.modules.programs.nixvim.plugins.undotree.enable {
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
