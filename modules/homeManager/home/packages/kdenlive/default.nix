{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.kdenlive.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.kdenlive";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.kdenlive.enable {
    home.packages = [pkgs.libsForQt5.kdenlive];
  };
}
