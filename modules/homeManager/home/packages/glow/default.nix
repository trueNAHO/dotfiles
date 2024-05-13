{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.glow.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.glow";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.glow.enable {
    home.packages = [pkgs.glow];
  };
}
