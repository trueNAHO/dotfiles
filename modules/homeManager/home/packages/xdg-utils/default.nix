{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.xdg-utils.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.xdg-utils";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.xdg-utils.enable {
    home.packages = [pkgs.xdg-utils];
  };
}
