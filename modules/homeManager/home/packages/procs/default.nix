{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.procs.enable =
    lib.mkEnableOption "procs";

  config = lib.mkIf config.modules.homeManager.home.packages.procs.enable {
    home.packages = [pkgs.procs];
  };
}
