{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.gimp.enable =
    lib.mkEnableOption "gimp";

  config = lib.mkIf config.modules.homeManager.home.packages.gimp.enable {
    home.packages = [pkgs.gimp];
  };
}
