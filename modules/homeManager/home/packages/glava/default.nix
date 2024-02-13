{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.glava.enable =
    lib.mkEnableOption "glava";

  config = lib.mkIf config.modules.homeManager.home.packages.glava.enable {
    home.packages = [pkgs.glava];
  };
}
