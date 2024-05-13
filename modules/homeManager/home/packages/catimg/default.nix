{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.catimg.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.catimg";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.catimg.enable {
    home.packages = [pkgs.catimg];
  };
}
