{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.neofetch.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.neofetch";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.neofetch.enable {
    home.packages = [pkgs.neofetch];
  };
}
