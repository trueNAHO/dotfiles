{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.tldr.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.tldr";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.tldr.enable {
    home.packages = [pkgs.tldr];
  };
}
