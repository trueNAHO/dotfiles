{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.aria.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.aria";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.aria.enable {
    home.packages = [pkgs.aria];
  };
}
