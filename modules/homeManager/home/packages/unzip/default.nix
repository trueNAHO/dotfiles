{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.unzip.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.unzip";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.unzip.enable {
    home.packages = [pkgs.unzip];
  };
}
