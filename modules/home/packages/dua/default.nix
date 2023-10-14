{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.dua.enable = lib.mkEnableOption "dua";

  config = lib.mkIf config.modules.home.packages.dua.enable {
    home.packages = [pkgs.dua];
  };
}
