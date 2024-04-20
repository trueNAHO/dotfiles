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

    home.shellAliases.lg = pkgs.lazygit.pname;

    programs.lazygit = {
      enable = true;

      settings.git = {
        autoFetch = false;

        branchLogCmd = lib.concatStringsSep " " [
          pkgs.git.pname
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
