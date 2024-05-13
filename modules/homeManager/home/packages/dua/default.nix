{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.dua.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.dua";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.dua.enable {
    home.packages = [pkgs.dua];
  };
}
