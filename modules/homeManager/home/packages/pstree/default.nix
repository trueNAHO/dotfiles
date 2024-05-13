{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.pstree.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.pstree";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.pstree.enable {
    home.packages = [pkgs.pstree];
  };
}
