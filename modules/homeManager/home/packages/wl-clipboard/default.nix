{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.wl-clipboard.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.wl-clipboard";

  config =
    lib.mkIf
    config.dotfiles.homeManager.home.packages.wl-clipboard.enable {
      home.packages = [pkgs.wl-clipboard];
    };
}
