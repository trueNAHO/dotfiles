{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../git];

  options.modules.homeManager.programs.lazygit.enable =
    lib.mkEnableOption "modules.homeManager.programs.lazygit";

  config = lib.mkIf config.modules.homeManager.programs.lazygit.enable {
    modules.homeManager.programs.git.enable = true;

    home.shellAliases.lg = lib.getExe config.programs.lazygit.package;

    programs.lazygit = {
      enable = true;

      settings.git = {
        autoFetch = false;

        branchLogCmd = lib.concatStringsSep " " [
          (lib.getExe pkgs.git)
          "log"
          "--color=always"
          "--decorate"
          "--graph"
          "--oneline"
          "{{branchName}}"
        ];
      };
    };
  };
}
