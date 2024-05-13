{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.zip.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.zip";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.zip.enable {
    home.packages = [pkgs.zip];
  };
}
