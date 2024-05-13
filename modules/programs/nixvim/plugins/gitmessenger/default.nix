{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.gitmessenger.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.gitmessenger";

  config =
    lib.mkIf
    config.dotfiles.programs.nixvim.plugins.gitmessenger.enable {
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
