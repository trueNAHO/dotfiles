{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.libreoffice.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.libreoffice";

  config =
    lib.mkIf
    config.dotfiles.homeManager.home.packages.libreoffice.enable {
      home.packages = [pkgs.libreoffice];
    };
}
