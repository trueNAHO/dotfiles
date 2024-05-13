{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.inkscape.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.inkscape";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.inkscape.enable {
    home.packages = [pkgs.inkscape];
  };
}
