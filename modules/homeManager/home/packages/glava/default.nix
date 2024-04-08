{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.glava.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.glava";

  config = lib.mkIf config.modules.homeManager.home.packages.glava.enable {
    home.packages = [pkgs.glava];
  };
}
