{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.taskwarrior-tui.enable =
    lib.mkEnableOption "taskwarrior-tui";

  config =
    lib.mkIf
    config.modules.homeManager.home.packages.taskwarrior-tui.enable {
      home = {
        packages = [pkgs.taskwarrior-tui];
        shellAliases.tkt = pkgs.taskwarrior-tui.pname;
      };
    };
}
