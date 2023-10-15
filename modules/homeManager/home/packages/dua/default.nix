{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.dua.enable =
    lib.mkEnableOption "dua";

  config = lib.mkIf config.modules.homeManager.home.packages.dua.enable {
    home.packages = [pkgs.dua];
  };
}
