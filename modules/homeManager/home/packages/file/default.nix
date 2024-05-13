{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.file.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.file";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.file.enable {
    home.packages = [pkgs.file];
  };
}
