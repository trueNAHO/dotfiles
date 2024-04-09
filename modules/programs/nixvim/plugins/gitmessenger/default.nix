{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.gitmessenger.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.gitmessenger";

  config = lib.mkIf config.modules.programs.nixvim.plugins.gitmessenger.enable {
    programs.nixvim = {
      keymaps = [
        {
          action = "vim.cmd.GitMessenger";
          key = "<leader>gl";
          lua = true;
          mode = "n";
          options.silent = true;
        }
      ];

      plugins.gitmessenger = {
        enable = true;
        floatingWinOps.border = "rounded";
        includeDiff = "current";
        noDefaultMappings = true;
        popupContentMargins = false;
      };
    };
  };
}
