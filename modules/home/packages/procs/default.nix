{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.procs.enable = lib.mkEnableOption "procs";

  config = lib.mkIf config.modules.home.packages.procs.enable {
    home.packages = [pkgs.procs];
  };
}
