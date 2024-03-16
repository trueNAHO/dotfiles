{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.inkscape.enable =
    lib.mkEnableOption "inkscape";

  config = lib.mkIf config.modules.homeManager.home.packages.inkscape.enable {
    home.packages = [pkgs.inkscape];
  };
}
