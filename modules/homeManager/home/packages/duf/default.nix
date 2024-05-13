{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.duf.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.duf";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.duf.enable {
    home.packages = [pkgs.duf];
  };
}
