{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.killall.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.killall";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.killall.enable {
    home.packages = [pkgs.killall];
  };
}
