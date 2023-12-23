{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.xdg-utils.enable =
    lib.mkEnableOption "xdg-utils";

  config = lib.mkIf config.modules.homeManager.home.packages.xdg-utils.enable {
    home.packages = [pkgs.xdg-utils];
  };
}
