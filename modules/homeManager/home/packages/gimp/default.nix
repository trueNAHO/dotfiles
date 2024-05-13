{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.gimp.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.gimp";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.gimp.enable {
    home.packages = [pkgs.gimp];
  };
}
