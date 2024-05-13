{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.catnip.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.catnip";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.catnip.enable {
    home.packages = [pkgs.catnip];
  };
}
