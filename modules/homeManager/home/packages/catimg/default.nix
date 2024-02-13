{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.catimg.enable =
    lib.mkEnableOption "catimg";

  config = lib.mkIf config.modules.homeManager.home.packages.catimg.enable {
    home.packages = [pkgs.catimg];
  };
}
