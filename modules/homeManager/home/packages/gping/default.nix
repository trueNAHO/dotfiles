{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.gping.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.gping";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.gping.enable {
    home.packages = [pkgs.gping];
  };
}
