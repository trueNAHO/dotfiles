{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.fd.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.fd";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.fd.enable {
    home.packages = [pkgs.fd];
  };
}
