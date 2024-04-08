{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.xdg-utils.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.xdg-utils";

  config = lib.mkIf config.modules.homeManager.home.packages.xdg-utils.enable {
    home.packages = [pkgs.xdg-utils];
  };
}
