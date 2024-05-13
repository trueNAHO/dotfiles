{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.procs.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.procs";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.procs.enable {
    home.packages = [pkgs.procs];
  };
}
