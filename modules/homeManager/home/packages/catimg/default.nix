{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.catimg.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.catimg";

  config = lib.mkIf config.modules.homeManager.home.packages.catimg.enable {
    home.packages = [pkgs.catimg];
  };
}
