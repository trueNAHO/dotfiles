{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.parallel.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.parallel";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.parallel.enable {
    home.packages = [(pkgs.parallel-full.override {willCite = true;})];
  };
}
