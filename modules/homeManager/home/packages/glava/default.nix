{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.glava.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.glava";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.glava.enable {
    home.packages = [pkgs.glava];
  };
}
