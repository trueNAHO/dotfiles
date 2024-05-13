{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.bandwhich.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.bandwhich";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.bandwhich.enable {
    home.packages = [pkgs.bandwhich];
  };
}
