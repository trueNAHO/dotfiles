{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.diskonaut.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.diskonaut";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.diskonaut.enable {
    home.packages = [pkgs.diskonaut];
  };
}
